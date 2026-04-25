-- =====================================================
-- DDL (Data Definition Language)
-- Ananya - AI Interview Assessment Platform
-- Version: 1.0
-- Date: 2026-04-26
-- Database: PostgreSQL 15+
-- =====================================================

-- =====================================================
-- 1. CREATE DATABASE
-- =====================================================

-- CREATE DATABASE ananya_interview_db;

-- =====================================================
-- 2. USERS TABLE (Recruiters and Admins)
-- =====================================================
CREATE SCHEMA IF NOT EXISTS ananya;
CREATE TABLE IF NOT EXISTS users (
    id                      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    email                   VARCHAR(255) NOT NULL UNIQUE,
    password_hash           VARCHAR(255) NOT NULL,
    full_name               VARCHAR(255) NOT NULL,
    role                    VARCHAR(50) NOT NULL CHECK (role IN ('recruiter', 'admin', 'hiring_manager')),
    department              VARCHAR(100),
    is_active               BOOLEAN DEFAULT TRUE,
    last_login_at           TIMESTAMP,
    created_at              TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at              TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by              UUID,
    updated_by              UUID
);

-- =====================================================
-- 3. CANDIDATES TABLE
-- =====================================================

CREATE TABLE IF NOT EXISTS candidates (
    id                      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    external_id             VARCHAR(50) UNIQUE,
    full_name               VARCHAR(255) NOT NULL,
    email                   VARCHAR(255) NOT NULL UNIQUE,
    phone                   VARCHAR(20),
    experience_years        DECIMAL(3,1),
    current_company         VARCHAR(255),
    current_role            VARCHAR(255),
    resume_url              TEXT,
    source                  VARCHAR(50) DEFAULT 'manual',
    status                  VARCHAR(50) DEFAULT 'active' CHECK (status IN ('active', 'inactive', 'blacklisted')),
    consent_ai_disclosure   BOOLEAN DEFAULT FALSE,
    consent_obtained_at     TIMESTAMP,
    created_at              TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at              TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by              UUID REFERENCES users(id),
    updated_by              UUID REFERENCES users(id)
);

-- =====================================================
-- 4. ROLES TABLE (Job Roles for Assessment)
-- =====================================================

CREATE TABLE IF NOT EXISTS roles (
    id                      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    title                   VARCHAR(255) NOT NULL UNIQUE,
    description             TEXT,
    department              VARCHAR(100),
    difficulty_level        VARCHAR(20) CHECK (difficulty_level IN ('junior', 'mid', 'senior', 'lead')),
    is_active               BOOLEAN DEFAULT TRUE,
    created_at              TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at              TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by              UUID REFERENCES users(id),
    updated_by              UUID REFERENCES users(id)
);

-- =====================================================
-- 5. QUESTION BANKS TABLE
-- =====================================================

CREATE TABLE IF NOT EXISTS question_banks (
    id                      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name                    VARCHAR(255) NOT NULL,
    description             TEXT,
    version                 VARCHAR(20) NOT NULL,
    role_id                 UUID REFERENCES roles(id),
    total_questions         INTEGER DEFAULT 0,
    passing_score           INTEGER DEFAULT 60,
    time_limit_minutes      INTEGER DEFAULT 30,
    is_active               BOOLEAN DEFAULT TRUE,
    approved_by             UUID REFERENCES users(id),
    approved_at             TIMESTAMP,
    created_at              TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at              TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by              UUID REFERENCES users(id),
    updated_by              UUID REFERENCES users(id),
    UNIQUE(name, version)
);

-- =====================================================
-- 6. QUESTIONS TABLE (MCQ)
-- =====================================================

CREATE TABLE IF NOT EXISTS questions (
    id                      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    question_bank_id        UUID NOT NULL REFERENCES question_banks(id) ON DELETE CASCADE,
    question_text           TEXT NOT NULL,
    option_a                TEXT NOT NULL,
    option_b                TEXT NOT NULL,
    option_c                TEXT NOT NULL,
    option_d                TEXT NOT NULL,
    correct_answer          CHAR(1) NOT NULL CHECK (correct_answer IN ('A', 'B', 'C', 'D')),
    explanation             TEXT,
    difficulty              VARCHAR(20) DEFAULT 'medium' CHECK (difficulty IN ('easy', 'medium', 'hard')),
    topic                   VARCHAR(100),
    points                  INTEGER DEFAULT 1,
    display_order           INTEGER DEFAULT 0,
    created_at              TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at              TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by              UUID REFERENCES users(id)
);

-- =====================================================
-- 7. INTERVIEW SESSIONS TABLE
-- =====================================================

CREATE TABLE IF NOT EXISTS interview_sessions (
    id                      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    session_code            VARCHAR(50) UNIQUE NOT NULL,
    candidate_id            UUID NOT NULL REFERENCES candidates(id),
    role_id                 UUID NOT NULL REFERENCES roles(id),
    question_bank_id        UUID NOT NULL REFERENCES question_banks(id),
    status                  VARCHAR(50) DEFAULT 'scheduled' CHECK (status IN ('scheduled', 'in_progress', 'completed', 'expired', 'cancelled')),
    scheduled_at            TIMESTAMP NOT NULL,
    started_at              TIMESTAMP,
    completed_at            TIMESTAMP,
    time_taken_seconds      INTEGER,
    ai_disclosure_accepted  BOOLEAN DEFAULT FALSE,
    ai_disclosure_accepted_at TIMESTAMP,
    timezone                VARCHAR(100) DEFAULT 'UTC',
    created_at              TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at              TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by              UUID REFERENCES users(id),
    updated_by              UUID REFERENCES users(id)
);

-- =====================================================
-- 8. CANDIDATE RESPONSES TABLE
-- =====================================================

CREATE TABLE IF NOT EXISTS candidate_responses (
    id                      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    session_id              UUID NOT NULL REFERENCES interview_sessions(id) ON DELETE CASCADE,
    question_id             UUID NOT NULL REFERENCES questions(id),
    selected_answer         CHAR(1) CHECK (selected_answer IN ('A', 'B', 'C', 'D', NULL)),
    is_correct              BOOLEAN,
    points_earned           INTEGER DEFAULT 0,
    time_spent_seconds      INTEGER,
    response_timestamp      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_at              TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(session_id, question_id)
);

-- =====================================================
-- 9. EVALUATION REPORTS TABLE
-- =====================================================

CREATE TABLE IF NOT EXISTS evaluation_reports (
    id                      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    session_id              UUID NOT NULL UNIQUE REFERENCES interview_sessions(id) ON DELETE CASCADE,
    total_score             INTEGER NOT NULL,
    max_possible_score      INTEGER NOT NULL,
    percentage_score        DECIMAL(5,2) NOT NULL,
    questions_answered      INTEGER DEFAULT 0,
    correct_answers         INTEGER DEFAULT 0,
    incorrect_answers       INTEGER DEFAULT 0,
    unanswered              INTEGER DEFAULT 0,
    ai_recommendation       VARCHAR(50) CHECK (ai_recommendation IN ('Proceed', 'Hold', 'Reject')),
    strengths               TEXT[],
    areas_to_probe          TEXT[],
    ai_summary              TEXT,
    report_generated_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    report_available_at     TIMESTAMP,
    report_sla_met          BOOLEAN DEFAULT TRUE,
    report_viewed_by        UUID REFERENCES users(id),
    report_viewed_at        TIMESTAMP,
    created_at              TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at              TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =====================================================
-- 10. DECISIONS TABLE (Recruiter Final Decisions)
-- =====================================================

CREATE TABLE IF NOT EXISTS decisions (
    id                      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    session_id              UUID NOT NULL REFERENCES interview_sessions(id),
    candidate_id            UUID NOT NULL REFERENCES candidates(id),
    recruiter_id            UUID NOT NULL REFERENCES users(id),
    decision_type           VARCHAR(20) NOT NULL CHECK (decision_type IN ('Accept', 'Hold', 'Reject')),
    decision_reason         TEXT,
    notified_at             TIMESTAMP,
    created_at              TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at              TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(session_id, recruiter_id)
);

-- =====================================================
-- 11. PROCTORING EVENTS TABLE (Suspicious Activity)
-- =====================================================

CREATE TABLE IF NOT EXISTS proctoring_events (
    id                      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    session_id              UUID NOT NULL REFERENCES interview_sessions(id) ON DELETE CASCADE,
    event_type              VARCHAR(50) NOT NULL CHECK (event_type IN ('tab_switch', 'copy_paste', 'right_click', 'window_blur', 'timeout_exceeded')),
    event_details           JSONB,
    severity                VARCHAR(20) DEFAULT 'warning' CHECK (severity IN ('info', 'warning', 'critical')),
    created_at              TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =====================================================
-- 12. RECRUITER FEEDBACK TABLE
-- =====================================================

CREATE TABLE IF NOT EXISTS recruiter_feedback (
    id                      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id                 UUID NOT NULL REFERENCES users(id),
    rating                  INTEGER NOT NULL CHECK (rating BETWEEN 1 AND 5),
    feedback_text           TEXT,
    category                VARCHAR(50) CHECK (category IN ('general', 'bug', 'feature_request', 'usability', 'report_quality')),
    page_url                VARCHAR(500),
    created_at              TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =====================================================
-- 13. AUDIT LOGS TABLE (Compliance & Security)
-- =====================================================

CREATE TABLE IF NOT EXISTS audit_logs (
    id                      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id                 UUID REFERENCES users(id),
    action                  VARCHAR(100) NOT NULL,
    entity_type             VARCHAR(50),
    entity_id               UUID,
    old_values              JSONB,
    new_values              JSONB,
    ip_address              INET,
    user_agent              TEXT,
    created_at              TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =====================================================
-- 14. NOTIFICATIONS TABLE
-- =====================================================

CREATE TABLE IF NOT EXISTS notifications (
    id                      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id                 UUID NOT NULL REFERENCES users(id),
    title                   VARCHAR(255) NOT NULL,
    message                 TEXT NOT NULL,
    type                    VARCHAR(50) CHECK (type IN ('report_ready', 'escalation', 'decision_made', 'system')),
    is_read                 BOOLEAN DEFAULT FALSE,
    metadata                JSONB,
    created_at              TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    read_at                 TIMESTAMP
);

-- =====================================================
-- 15. INDEXES FOR PERFORMANCE
-- =====================================================

CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);
CREATE INDEX IF NOT EXISTS idx_users_role ON users(role);
CREATE INDEX IF NOT EXISTS idx_candidates_email ON candidates(email);
CREATE INDEX IF NOT EXISTS idx_candidates_status ON candidates(status);
CREATE INDEX IF NOT EXISTS idx_sessions_candidate_id ON interview_sessions(candidate_id);
CREATE INDEX IF NOT EXISTS idx_sessions_status ON interview_sessions(status);
CREATE INDEX IF NOT EXISTS idx_sessions_scheduled_at ON interview_sessions(scheduled_at);
CREATE INDEX IF NOT EXISTS idx_sessions_session_code ON interview_sessions(session_code);
CREATE INDEX IF NOT EXISTS idx_questions_question_bank_id ON questions(question_bank_id);
CREATE INDEX IF NOT EXISTS idx_responses_session_id ON candidate_responses(session_id);
CREATE INDEX IF NOT EXISTS idx_reports_session_id ON evaluation_reports(session_id);
CREATE INDEX IF NOT EXISTS idx_reports_ai_recommendation ON evaluation_reports(ai_recommendation);
CREATE INDEX IF NOT EXISTS idx_decisions_decision_type ON decisions(decision_type);
CREATE INDEX IF NOT EXISTS idx_proctoring_session_id ON proctoring_events(session_id);
CREATE INDEX IF NOT EXISTS idx_audit_user_id ON audit_logs(user_id);
CREATE INDEX IF NOT EXISTS idx_audit_created_at ON audit_logs(created_at);
CREATE INDEX IF NOT EXISTS idx_feedback_user_id ON recruiter_feedback(user_id);

-- =====================================================
-- 16. COMPOSITE INDEXES
-- =====================================================

CREATE INDEX IF NOT EXISTS idx_sessions_status_scheduled ON interview_sessions(status, scheduled_at);
CREATE INDEX IF NOT EXISTS idx_decisions_candidate_type ON decisions(candidate_id, decision_type);

-- =====================================================
-- 17. TRIGGER: UPDATE updated_at TIMESTAMP
-- =====================================================

CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_users_updated_at BEFORE UPDATE ON users FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER trigger_candidates_updated_at BEFORE UPDATE ON candidates FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER trigger_roles_updated_at BEFORE UPDATE ON roles FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER trigger_question_banks_updated_at BEFORE UPDATE ON question_banks FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER trigger_sessions_updated_at BEFORE UPDATE ON interview_sessions FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER trigger_decisions_updated_at BEFORE UPDATE ON decisions FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER trigger_reports_updated_at BEFORE UPDATE ON evaluation_reports FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- =====================================================
-- 18. TRIGGER: AUTO-CALCULATE SCORE AFTER RESPONSE
-- =====================================================

CREATE OR REPLACE FUNCTION calculate_session_score()
RETURNS TRIGGER AS $$
DECLARE
    v_session_id UUID;
    v_total_score INTEGER;
    v_max_score INTEGER;
    v_correct INTEGER;
    v_answered INTEGER;
    v_percentage DECIMAL(5,2);
    v_recommendation VARCHAR(50);
BEGIN
    SELECT session_id INTO v_session_id FROM candidate_responses WHERE id = NEW.id;
    
    SELECT 
        COALESCE(SUM(CASE WHEN is_correct THEN points_earned ELSE 0 END), 0),
        COALESCE(SUM(q.points), 0),
        COUNT(CASE WHEN is_correct THEN 1 END),
        COUNT(selected_answer)
    INTO v_total_score, v_max_score, v_correct, v_answered
    FROM candidate_responses cr
    JOIN questions q ON cr.question_id = q.id
    WHERE cr.session_id = v_session_id;
    
    v_percentage := ROUND((v_total_score::DECIMAL / NULLIF(v_max_score, 0)) * 100, 2);
    
    IF v_percentage >= 85 THEN
        v_recommendation := 'Proceed';
    ELSIF v_percentage >= 70 THEN
        v_recommendation := 'Hold';
    ELSE
        v_recommendation := 'Reject';
    END IF;
    
    INSERT INTO evaluation_reports (
        session_id, total_score, max_possible_score, percentage_score,
        questions_answered, correct_answers, incorrect_answers,
        report_generated_at, report_available_at, ai_recommendation
    ) VALUES (
        v_session_id, v_total_score, v_max_score, v_percentage,
        v_answered, v_correct, v_answered - v_correct,
        CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, v_recommendation
    ) ON CONFLICT (session_id) DO UPDATE SET
        total_score = EXCLUDED.total_score,
        max_possible_score = EXCLUDED.max_possible_score,
        percentage_score = EXCLUDED.percentage_score,
        questions_answered = EXCLUDED.questions_answered,
        correct_answers = EXCLUDED.correct_answers,
        incorrect_answers = EXCLUDED.incorrect_answers,
        report_available_at = CURRENT_TIMESTAMP,
        ai_recommendation = EXCLUDED.ai_recommendation,
        updated_at = CURRENT_TIMESTAMP;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_calculate_score AFTER INSERT ON candidate_responses 
FOR EACH ROW EXECUTE FUNCTION calculate_session_score();