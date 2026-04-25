-- =====================================================
-- DML (Data Manipulation Language)
-- Ananya - AI Interview Assessment Platform
-- Master Data and Sample Data Insertion
-- Version: 1.0
-- Date: 2026-04-26
-- =====================================================

-- =====================================================
-- 1. INSERT USERS (Recruiters and Admins)
-- =====================================================

INSERT INTO users (id, email, password_hash, full_name, role, department, is_active) VALUES
('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'alex.morgan@centific.com', '$2b$10$hashed_password_1', 'Alex Morgan', 'recruiter', 'Talent Acquisition', TRUE),
('b0eebc99-9c0b-4ef8-bb6d-6bb9bd380a22', 'sarah.chen@centific.com', '$2b$10$hashed_password_2', 'Sarah Chen', 'recruiter', 'Talent Acquisition', TRUE),
('c0eebc99-9c0b-4ef8-bb6d-6bb9bd380a33', 'raj.kumar@centific.com', '$2b$10$hashed_password_3', 'Raj Kumar', 'hiring_manager', 'Engineering', TRUE),
('d0eebc99-9c0b-4ef8-bb6d-6bb9bd380a44', 'emily.wong@centific.com', '$2b$10$hashed_password_4', 'Emily Wong', 'admin', 'HR', TRUE);

-- =====================================================
-- 2. INSERT JOB ROLES (As per BRD requirements)
-- =====================================================

INSERT INTO roles (id, title, description, department, difficulty_level, is_active) VALUES
('11111111-1111-1111-1111-111111111111', 'ML Engineer', 'Machine Learning Engineer responsible for developing and deploying ML models', 'AI', 'senior', TRUE),
('22222222-2222-2222-2222-222222222222', 'Product Manager', 'Product Manager for AI products and platforms', 'Product', 'senior', TRUE),
('33333333-3333-3333-3333-333333333333', 'UX Designer', 'User Experience Designer for web and mobile applications', 'Design', 'mid', TRUE),
('44444444-4444-4444-4444-444444444444', 'Data Analyst', 'Data Analyst for business intelligence and analytics', 'Data', 'junior', TRUE),
('55555555-5555-5555-5555-555555555555', 'Frontend Engineer', 'Frontend Engineer specializing in React and modern web technologies', 'Engineering', 'mid', TRUE),
('66666666-6666-6666-6666-666666666666', 'DevOps Engineer', 'DevOps Engineer for CI/CD and cloud infrastructure', 'Engineering', 'senior', TRUE),
('77777777-7777-7777-7777-777777777777', 'Backend Engineer', 'Backend Engineer for API and microservices development', 'Engineering', 'mid', TRUE);

-- =====================================================
-- 3. INSERT QUESTION BANKS
-- =====================================================

INSERT INTO question_banks (id, name, description, version, role_id, total_questions, passing_score, time_limit_minutes, is_active, approved_by, approved_at) VALUES
('qbank-1111-1111-1111-111111111111', 'ML Engineer Assessment V1', 'Technical assessment for ML Engineer position covering Python, ML algorithms, and system design', '1.0', '11111111-1111-1111-1111-111111111111', 10, 70, 30, TRUE, 'd0eebc99-9c0b-4ef8-bb6d-6bb9bd380a44', CURRENT_TIMESTAMP),
('qbank-2222-2222-2222-222222222222', 'Product Manager Assessment V1', 'Assessment for Product Manager role covering product strategy, analytics, and technical understanding', '1.0', '22222222-2222-2222-2222-222222222222', 10, 65, 25, TRUE, 'd0eebc99-9c0b-4ef8-bb6d-6bb9bd380a44', CURRENT_TIMESTAMP),
('qbank-3333-3333-3333-333333333333', 'UX Designer Assessment V1', 'Technical assessment for UX Designer covering design principles, tools, and user research', '1.0', '33333333-3333-3333-3333-333333333333', 10, 70, 30, TRUE, 'd0eebc99-9c0b-4ef8-bb6d-6bb9bd380a44', CURRENT_TIMESTAMP),
('qbank-4444-4444-4444-444444444444', 'Frontend Engineer Assessment V1', 'Assessment for Frontend Engineer covering React, JavaScript, CSS, and web performance', '1.0', '55555555-5555-5555-5555-555555555555', 10, 70, 30, TRUE, 'd0eebc99-9c0b-4ef8-bb6d-6bb9bd380a44', CURRENT_TIMESTAMP);

-- =====================================================
-- 4. INSERT QUESTIONS (Sample 10 Questions for ML Engineer)
-- =====================================================

INSERT INTO questions (id, question_bank_id, question_text, option_a, option_b, option_c, option_d, correct_answer, explanation, difficulty, topic, points, display_order) VALUES
('q1-1111-1111-1111-111111111111', 'qbank-1111-1111-1111-111111111111', 
 'What is the difference between supervised and unsupervised learning?', 
 'Supervised learning uses labeled data, unsupervised learning uses unlabeled data',
 'Supervised learning uses unlabeled data, unsupervised learning uses labeled data',
 'Both use labeled data but different algorithms',
 'Both use unlabeled data but different evaluation metrics',
 'A',
 'Supervised learning requires labeled input-output pairs for training, while unsupervised learning finds patterns in unlabeled data.',
 'medium', 'ML Fundamentals', 1, 1),

('q2-2222-2222-2222-222222222222', 'qbank-1111-1111-1111-111111111111',
 'Which of the following is NOT a supervised learning algorithm?',
 'Linear Regression',
 'Decision Tree',
 'K-Means Clustering',
 'Support Vector Machine',
 'C',
 'K-Means is an unsupervised clustering algorithm, while the others are supervised learning algorithms.',
 'easy', 'ML Algorithms', 1, 2),

('q3-3333-3333-3333-333333333333', 'qbank-1111-1111-1111-111111111111',
 'What is the purpose of a confusion matrix?',
 'To visualize neural network architecture',
 'To evaluate classification model performance',
 'To reduce overfitting',
 'To normalize input data',
 'B',
 'A confusion matrix shows true positives, false positives, true negatives, and false negatives to evaluate classification model performance.',
 'medium', 'Model Evaluation', 1, 3),

('q4-4444-4444-4444-444444444444', 'qbank-1111-1111-1111-111111111111',
 'What does the term "overfitting" mean in machine learning?',
 'Model performs well on training data but poorly on new data',
 'Model performs poorly on training data but well on new data',
 'Model uses too few features',
 'Model has high bias',
 'A',
 'Overfitting occurs when a model learns noise in the training data rather than the underlying pattern, leading to poor generalization.',
 'medium', 'Model Optimization', 1, 4),

('q5-5555-5555-5555-555555555555', 'qbank-1111-1111-1111-111111111111',
 'Which activation function is commonly used in the output layer for binary classification?',
 'ReLU',
 'Tanh',
 'Sigmoid',
 'Softmax',
 'C',
 'Sigmoid function outputs values between 0 and 1, making it ideal for binary classification probability estimation.',
 'easy', 'Neural Networks', 1, 5),

('q6-6666-6666-6666-666666666666', 'qbank-1111-1111-1111-111111111111',
 'What is the purpose of cross-validation?',
 'To increase training data size',
 'To assess model generalization performance',
 'To speed up training',
 'To reduce feature dimensions',
 'B',
 'Cross-validation helps assess how well a model will generalize to an independent dataset by using multiple train-test splits.',
 'medium', 'Model Validation', 1, 6),

('q7-7777-7777-7777-777777777777', 'qbank-1111-1111-1111-111111111111',
 'What is the main advantage of gradient boosting over random forest?',
 'Faster training time',
 'Often achieves higher accuracy with sequential learning',
 'Uses less memory',
 'Easier to interpret',
 'B',
 'Gradient boosting builds trees sequentially, each correcting previous errors, often achieving higher accuracy than random forests.',
 'hard', 'Ensemble Methods', 1, 7),

('q8-8888-8888-8888-888888888888', 'qbank-1111-1111-1111-111111111111',
 'What is the purpose of regularization (L1/L2) in machine learning?',
 'To increase model complexity',
 'To prevent overfitting by penalizing large weights',
 'To speed up convergence',
 'To handle missing values',
 'B',
 'Regularization adds a penalty term to the loss function to discourage large weights, helping prevent overfitting.',
 'hard', 'Regularization', 1, 8),

('q9-9999-9999-9999-999999999999', 'qbank-1111-1111-1111-111111111111',
 'Which metric is most appropriate for imbalanced classification problems?',
 'Accuracy',
 'Precision and Recall',
 'Mean Squared Error',
 'R-squared',
 'B',
 'For imbalanced datasets, precision and recall (or F1-score) provide more meaningful evaluation than accuracy.',
 'hard', 'Model Evaluation', 1, 9),

('q10-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'qbank-1111-1111-1111-111111111111',
 'What is the role of a validation set during model training?',
 'To train the final model',
 'To tune hyperparameters',
 'To test model on unseen data',
 'To augment training data',
 'B',
 'The validation set is used to tune hyperparameters and evaluate model performance during development before final testing.',
 'medium', 'Model Training', 1, 10);

-- =====================================================
-- 5. INSERT CANDIDATES
-- =====================================================

INSERT INTO candidates (id, external_id, full_name, email, phone, experience_years, current_company, current_role, source, status, consent_ai_disclosure, consent_obtained_at) VALUES
('c1-1111-1111-1111-111111111111', 'CND-1042', 'Priya Sharma', 'priya.sharma@email.com', '+91-98765-43210', 6.0, 'Tech Corp', 'Senior ML Engineer', 'linkedin', 'active', TRUE, CURRENT_TIMESTAMP),
('c2-2222-2222-2222-222222222222', 'CND-1043', 'Marcus Lee', 'marcus.lee@email.com', '+1-555-123-4567', 8.0, 'Product Inc', 'Product Manager', 'referral', 'active', TRUE, CURRENT_TIMESTAMP),
('c3-3333-3333-3333-333333333333', 'CND-1044', 'Anjali Reddy', 'anjali.reddy@email.com', '+91-99887-66554', 5.0, 'Design Studio', 'Senior UX Designer', 'linkedin', 'active', TRUE, CURRENT_TIMESTAMP),
('c4-4444-4444-4444-444444444444', 'CND-1045', 'David Okafor', 'david.okafor@email.com', '+234-802-123-4567', 9.0, 'Data Solutions', 'Sales Lead', 'naukri', 'active', TRUE, CURRENT_TIMESTAMP),
('c5-5555-5555-5555-555555555555', 'CND-1046', 'Sofia Hernandez', 'sofia.hernandez@email.com', '+1-555-987-6543', 4.0, 'Web Dev Co', 'Frontend Engineer', 'linkedin', 'active', TRUE, CURRENT_TIMESTAMP),
('c6-6666-6666-6666-666666666666', 'CND-1047', 'James Whitfield', 'james.whitfield@email.com', '+44-20-1234-5678', 3.0, 'Data Analytics', 'Data Analyst', 'indeed', 'active', TRUE, CURRENT_TIMESTAMP);

-- =====================================================
-- 6. INSERT INTERVIEW SESSIONS
-- =====================================================

INSERT INTO interview_sessions (id, session_code, candidate_id, role_id, question_bank_id, status, scheduled_at, started_at, completed_at, time_taken_seconds, ai_disclosure_accepted, ai_disclosure_accepted_at, created_by) VALUES
('s1-1111-1111-1111-111111111111', 'SES-4421', 'c1-1111-1111-1111-111111111111', '11111111-1111-1111-1111-111111111111', 'qbank-1111-1111-1111-111111111111', 'completed', '2026-04-18 10:00:00', '2026-04-18 10:05:00', '2026-04-18 10:32:00', 1620, TRUE, CURRENT_TIMESTAMP, 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11'),
('s2-2222-2222-2222-222222222222', 'SES-4422', 'c2-2222-2222-2222-222222222222', '22222222-2222-2222-2222-222222222222', 'qbank-2222-2222-2222-222222222222', 'completed', '2026-04-19 14:00:00', '2026-04-19 14:10:00', '2026-04-19 14:35:00', 1500, TRUE, CURRENT_TIMESTAMP, 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11'),
('s3-3333-3333-3333-333333333333', 'SES-4423', 'c3-3333-3333-3333-333333333333', '33333333-3333-3333-3333-333333333333', 'qbank-3333-3333-3333-333333333333', 'completed', '2026-04-17 11:30:00', '2026-04-17 11:40:00', '2026-04-17 12:08:00', 1680, TRUE, CURRENT_TIMESTAMP, 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11'),
('s4-4444-4444-4444-444444444444', 'SES-4424', 'c4-4444-4444-4444-444444444444', '11111111-1111-1111-1111-111111111111', 'qbank-1111-1111-1111-111111111111', 'completed', '2026-04-16 09:00:00', '2026-04-16 09:05:00', '2026-04-16 09:28:00', 1380, TRUE, CURRENT_TIMESTAMP, 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11'),
('s5-5555-5555-5555-555555555555', 'SES-4425', 'c5-5555-5555-5555-555555555555', '55555555-5555-5555-5555-555555555555', 'qbank-4444-4444-4444-444444444444', 'completed', '2026-04-20 15:00:00', '2026-04-20 15:10:00', '2026-04-20 15:38:00', 1680, TRUE, CURRENT_TIMESTAMP, 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11'),
('s6-6666-6666-6666-666666666666', 'SES-4426', 'c6-6666-6666-6666-666666666666', '44444444-4444-4444-4444-444444444444', 'qbank-1111-1111-1111-111111111111', 'scheduled', '2026-04-26 11:00:00', NULL, NULL, NULL, FALSE, NULL, 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11');

-- =====================================================
-- 7. INSERT CANDIDATE RESPONSES (Sample for completed sessions)
-- =====================================================

-- Responses for Priya Sharma (Session s1-1111) - Score: 91%
INSERT INTO candidate_responses (id, session_id, question_id, selected_answer, is_correct, points_earned, time_spent_seconds) VALUES
('r1-1111', 's1-1111-1111-1111-111111111111', 'q1-1111-1111-1111-111111111111', 'A', TRUE, 1, 45),
('r2-2222', 's1-1111-1111-1111-111111111111', 'q2-2222-2222-2222-222222222222', 'C', TRUE, 1, 32),
('r3-3333', 's1-1111-1111-1111-111111111111', 'q3-3333-3333-3333-333333333333', 'B', TRUE, 1, 28),
('r4-4444', 's1-1111-1111-1111-111111111111', 'q4-4444-4444-4444-444444444444', 'A', TRUE, 1, 55),
('r5-5555', 's1-1111-1111-1111-111111111111', 'q5-5555-5555-5555-555555555555', 'C', TRUE, 1, 22),
('r6-6666', 's1-1111-1111-1111-111111111111', 'q6-6666-6666-6666-666666666666', 'B', FALSE, 0, 48),
('r7-7777', 's1-1111-1111-1111-111111111111', 'q7-7777-7777-7777-777777777777', 'B', TRUE, 1, 62),
('r8-8888', 's1-1111-1111-1111-111111111111', 'q8-8888-8888-8888-888888888888', 'B', TRUE, 1, 40),
('r9-9999', 's1-1111-1111-1111-111111111111', 'q9-9999-9999-9999-999999999999', 'B', TRUE, 1, 35),
('r10-aaa1', 's1-1111-1111-1111-111111111111', 'q10-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'B', TRUE, 1, 30);

-- =====================================================
-- 8. INSERT RECRUITER DECISIONS
-- =====================================================

INSERT INTO decisions (id, session_id, candidate_id, recruiter_id, decision_type, decision_reason) VALUES
('d1-1111-1111-1111-111111111111', 's1-1111-1111-1111-111111111111', 'c1-1111-1111-1111-111111111111', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'Accept', 'Strong technical skills. Excellent performance in ML fundamentals. Proceed to final round.'),
('d2-2222-2222-2222-222222222222', 's2-2222-2222-2222-222222222222', 'c2-2222-2222-2222-222222222222', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'Hold', 'Good product sense but needs more technical depth. Consider for Q3.'),
('d3-3333-3333-3333-333333333333', 's3-3333-3333-3333-333333333333', 'c3-3333-3333-3333-333333333333', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'Accept', 'Outstanding design portfolio. Strong problem-solving skills.'),
('d4-4444-4444-4444-444444444444', 's4-4444-4444-4444-444444444444', 'c4-4444-4444-4444-444444444444', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'Reject', 'Technical skills below required bar for ML Engineer position.'),
('d5-5555-5555-5555-555555555555', 's5-5555-5555-5555-555555555555', 'c5-5555-5555-5555-555555555555', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'Accept', 'Exceptional frontend skills. Strong hire recommendation.');

-- =====================================================
-- 9. INSERT RECRUITER FEEDBACK
-- =====================================================

INSERT INTO recruiter_feedback (id, user_id, rating, feedback_text, category) VALUES
('f1-1111-1111-1111-111111111111', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 5, 'The platform is excellent! Reports are detailed and AI recommendations are accurate. Saves significant time in screening.', 'general'),
('f2-2222-2222-2222-222222222222', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380a22', 4, 'Very useful tool. Would love to see batch export functionality for multiple candidate reports.', 'feature_request');

-- =====================================================
-- 10. INSERT PROCTORING EVENTS (Suspicious Activity)
-- =====================================================

INSERT INTO proctoring_events (id, session_id, event_type, event_details, severity) VALUES
('p1-1111-1111-1111-111111111111', 's1-1111-1111-1111-111111111111', 'tab_switch', '{"count": 2, "timestamps": ["2026-04-18T10:15:00", "2026-04-18T10:22:00"]}', 'warning'),
('p2-2222-2222-2222-222222222222', 's3-3333-3333-3333-333333333333', 'copy_paste', '{"count": 1, "timestamp": "2026-04-17T11:55:00"}', 'info');

-- =====================================================
-- 11. INSERT NOTIFICATIONS
-- =====================================================

INSERT INTO notifications (id, user_id, title, message, type, metadata) VALUES
('n1-1111-1111-1111-111111111111', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'Report Ready: Priya Sharma', 'Evaluation report for Priya Sharma (ML Engineer) is now available for review.', 'report_ready', '{"candidate_id": "c1-1111-1111-1111-111111111111", "score": 91}'),
('n2-2222-2222-2222-222222222222', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'Report Ready: Marcus Lee', 'Evaluation report for Marcus Lee (Product Manager) is now available for review.', 'report_ready', '{"candidate_id": "c2-2222-2222-2222-222222222222", "score": 78}');

-- =====================================================
-- 12. INSERT AUDIT LOGS
-- =====================================================

INSERT INTO audit_logs (id, user_id, action, entity_type, entity_id, ip_address, user_agent) VALUES
('a1-1111-1111-1111-111111111111', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'LOGIN_SUCCESS', 'user', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', '192.168.1.100', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)'),
('a2-2222-2222-2222-222222222222', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'DECISION_MADE', 'decision', 'd1-1111-1111-1111-111111111111', '192.168.1.100', 'Mozilla/5.0');

-- =====================================================
-- 13. VERIFY DATA COUNTS (Optional - for testing)
-- =====================================================

-- SELECT 'Users' as table_name, COUNT(*) as record_count FROM users
-- UNION ALL SELECT 'Candidates', COUNT(*) FROM candidates
-- UNION ALL SELECT 'Roles', COUNT(*) FROM roles
-- UNION ALL SELECT 'Question Banks', COUNT(*) FROM question_banks
-- UNION ALL SELECT 'Questions', COUNT(*) FROM questions
-- UNION ALL SELECT 'Interview Sessions', COUNT(*) FROM interview_sessions
-- UNION ALL SELECT 'Candidate Responses', COUNT(*) FROM candidate_responses
-- UNION ALL SELECT 'Decisions', COUNT(*) FROM decisions
-- UNION ALL SELECT 'Feedback', COUNT(*) FROM recruiter_feedback
-- UNION ALL SELECT 'Proctoring Events', COUNT(*) FROM proctoring_events;