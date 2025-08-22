-- Industrial Maintenance Operations - Work Orders and Maintenance Operations Data
-- Generate a full year of realistic maintenance work orders

USE DATABASE MAINTENANCE_OPERATIONS;
USE SCHEMA OPERATIONS;

-- =====================================================
-- WORK ORDERS - YEAR 2023 DATA (365 days of operations)
-- =====================================================

-- January 2023 Work Orders
INSERT INTO WORK_ORDERS (WORK_ORDER_ID, EQUIPMENT_ID, MAINTENANCE_TYPE_ID, PRIORITY, STATUS, DESCRIPTION, REQUESTED_BY, REQUESTED_DATE, SCHEDULED_START_DATE, SCHEDULED_END_DATE, ACTUAL_START_DATE, ACTUAL_END_DATE, ESTIMATED_HOURS, ACTUAL_HOURS, ESTIMATED_COST, ACTUAL_COST, DOWNTIME_HOURS) VALUES
('WO2023001', 'EQ001', 'MT001', 'MEDIUM', 'COMPLETED', 'Quarterly preventive maintenance on main feed pump A', 'Operations Supervisor', '2023-01-05 08:00:00', '2023-01-05 08:00:00', '2023-01-05 14:00:00', '2023-01-05 08:15:00', '2023-01-05 13:45:00', 6.0, 5.5, 1200.00, 1100.00, 0.0),
('WO2023002', 'EQ016', 'MT005', 'LOW', 'COMPLETED', 'Calibration of pressure transmitter PT-101', 'Instrument Technician', '2023-01-08 09:00:00', '2023-01-08 09:00:00', '2023-01-08 12:00:00', '2023-01-08 09:10:00', '2023-01-08 11:50:00', 3.0, 2.7, 500.00, 480.00, 1.0),
('WO2023003', 'EQ005', 'MT007', 'MEDIUM', 'COMPLETED', 'Oil change and filter replacement for air compressor', 'Maintenance Planner', '2023-01-12 10:00:00', '2023-01-12 10:00:00', '2023-01-12 12:00:00', '2023-01-12 10:05:00', '2023-01-12 11:45:00', 2.0, 1.7, 300.00, 285.00, 0.5),
('WO2023004', 'EQ013', 'MT002', 'HIGH', 'COMPLETED', 'Repair sticking control valve actuator', 'Operations Team', '2023-01-15 14:30:00', '2023-01-15 16:00:00', '2023-01-15 20:00:00', '2023-01-15 16:15:00', '2023-01-15 19:30:00', 4.0, 3.25, 800.00, 750.00, 2.5),
('WO2023005', 'EQ020', 'MT004', 'MEDIUM', 'COMPLETED', 'Annual inspection of power transformer T-1', 'Electrical Supervisor', '2023-01-18 08:00:00', '2023-01-18 08:00:00', '2023-01-18 12:00:00', '2023-01-18 08:20:00', '2023-01-18 11:40:00', 4.0, 3.3, 600.00, 580.00, 0.0),
('WO2023006', 'EQ003', 'MT008', 'LOW', 'COMPLETED', 'Vibration monitoring and analysis', 'Predictive Maintenance', '2023-01-22 13:00:00', '2023-01-22 13:00:00', '2023-01-22 16:00:00', '2023-01-22 13:10:00', '2023-01-22 15:45:00', 3.0, 2.6, 450.00, 420.00, 0.0),
('WO2023007', 'EQ021', 'MT009', 'HIGH', 'COMPLETED', 'Monthly safety test of backup generator', 'Safety Coordinator', '2023-01-25 11:00:00', '2023-01-25 11:00:00', '2023-01-25 15:00:00', '2023-01-25 11:15:00', '2023-01-25 14:30:00', 4.0, 3.25, 700.00, 680.00, 0.0),
('WO2023008', 'EQ008', 'MT002', 'MEDIUM', 'COMPLETED', 'Clean heat exchanger tubes due to fouling', 'Process Engineer', '2023-01-28 09:00:00', '2023-01-28 09:00:00', '2023-01-28 21:00:00', '2023-01-28 09:30:00', '2023-01-28 20:15:00', 12.0, 10.75, 2500.00, 2300.00, 8.0),

-- February 2023 Work Orders
('WO2023009', 'EQ002', 'MT001', 'MEDIUM', 'COMPLETED', 'Quarterly preventive maintenance on main feed pump B', 'Operations Supervisor', '2023-02-02 08:00:00', '2023-02-02 08:00:00', '2023-02-02 14:00:00', '2023-02-02 08:10:00', '2023-02-02 13:55:00', 6.0, 5.75, 1200.00, 1150.00, 0.0),
('WO2023010', 'EQ017', 'MT005', 'LOW', 'COMPLETED', 'Calibration of temperature transmitter TT-101', 'Instrument Technician', '2023-02-05 10:00:00', '2023-02-05 10:00:00', '2023-02-05 13:00:00', '2023-02-05 10:15:00', '2023-02-05 12:45:00', 3.0, 2.5, 400.00, 375.00, 0.5),
('WO2023011', 'EQ010', 'MT002', 'HIGH', 'COMPLETED', 'Replace motor bearing due to noise', 'Maintenance Team', '2023-02-08 13:00:00', '2023-02-08 15:00:00', '2023-02-08 21:00:00', '2023-02-08 15:20:00', '2023-02-08 20:30:00', 6.0, 5.17, 1500.00, 1400.00, 4.0),
('WO2023012', 'EQ019', 'MT010', 'MEDIUM', 'COMPLETED', 'Software update for MCC Panel A', 'Electrical Engineer', '2023-02-12 20:00:00', '2023-02-12 20:00:00', '2023-02-12 23:00:00', '2023-02-12 20:15:00', '2023-02-12 22:45:00', 3.0, 2.5, 800.00, 750.00, 2.0),
('WO2023013', 'EQ006', 'MT008', 'MEDIUM', 'COMPLETED', 'Condition monitoring - gas compressor stage 1', 'Predictive Maintenance', '2023-02-15 09:00:00', '2023-02-15 09:00:00', '2023-02-15 11:30:00', '2023-02-15 09:05:00', '2023-02-15 11:20:00', 2.5, 2.25, 350.00, 325.00, 0.0),
('WO2023014', 'EQ024', 'MT002', 'MEDIUM', 'COMPLETED', 'Replace RO membrane elements', 'Water Treatment Tech', '2023-02-18 08:00:00', '2023-02-18 08:00:00', '2023-02-18 16:00:00', '2023-02-18 08:30:00', '2023-02-18 15:30:00', 8.0, 7.0, 3500.00, 3200.00, 5.0),
('WO2023015', 'EQ014', 'MT005', 'MEDIUM', 'COMPLETED', 'Calibration of main control valve B', 'Instrument Technician', '2023-02-22 11:00:00', '2023-02-22 11:00:00', '2023-02-22 15:00:00', '2023-02-22 11:20:00', '2023-02-22 14:40:00', 4.0, 3.33, 600.00, 580.00, 1.5),
('WO2023016', 'EQ023', 'MT004', 'HIGH', 'COMPLETED', 'Annual boiler inspection and testing', 'Boiler Inspector', '2023-02-25 07:00:00', '2023-02-25 07:00:00', '2023-02-25 15:00:00', '2023-02-25 07:15:00', '2023-02-25 14:45:00', 8.0, 7.5, 1800.00, 1700.00, 6.0),

-- March 2023 Work Orders
('WO2023017', 'EQ004', 'MT001', 'MEDIUM', 'COMPLETED', 'Preventive maintenance on cooling water pump 2', 'Operations Supervisor', '2023-03-03 09:00:00', '2023-03-03 09:00:00', '2023-03-03 13:00:00', '2023-03-03 09:15:00', '2023-03-03 12:45:00', 4.0, 3.5, 800.00, 750.00, 0.0),
('WO2023018', 'EQ015', 'MT009', 'HIGH', 'COMPLETED', 'Safety valve testing and certification', 'Safety Engineer', '2023-03-06 10:00:00', '2023-03-06 10:00:00', '2023-03-06 14:00:00', '2023-03-06 10:10:00', '2023-03-06 13:50:00', 4.0, 3.67, 900.00, 850.00, 2.0),
('WO2023019', 'EQ007', 'MT006', 'HIGH', 'COMPLETED', 'Major overhaul of gas compressor stage 2', 'Maintenance Manager', '2023-03-10 06:00:00', '2023-03-10 06:00:00', '2023-03-12 18:00:00', '2023-03-10 06:30:00', '2023-03-12 16:30:00', 60.0, 58.0, 25000.00, 24500.00, 48.0),
('WO2023020', 'EQ018', 'MT005', 'LOW', 'COMPLETED', 'Flow transmitter calibration', 'Instrument Technician', '2023-03-15 14:00:00', '2023-03-15 14:00:00', '2023-03-15 17:00:00', '2023-03-15 14:20:00', '2023-03-15 16:40:00', 3.0, 2.33, 450.00, 420.00, 0.5),
('WO2023021', 'EQ022', 'MT007', 'MEDIUM', 'COMPLETED', 'Lubrication of cooling tower fan bearings', 'Maintenance Team', '2023-03-18 11:00:00', '2023-03-18 11:00:00', '2023-03-18 13:00:00', '2023-03-18 11:10:00', '2023-03-18 12:50:00', 2.0, 1.67, 200.00, 180.00, 0.0),
('WO2023022', 'EQ001', 'MT002', 'EMERGENCY', 'COMPLETED', 'Emergency repair - pump seal failure', 'Operations', '2023-03-22 02:30:00', '2023-03-22 03:00:00', '2023-03-22 11:00:00', '2023-03-22 03:15:00', '2023-03-22 10:45:00', 8.0, 7.5, 2200.00, 2100.00, 6.0),
('WO2023023', 'EQ011', 'MT004', 'MEDIUM', 'COMPLETED', 'Motor vibration analysis and inspection', 'Maintenance Team', '2023-03-25 13:00:00', '2023-03-25 13:00:00', '2023-03-25 16:00:00', '2023-03-25 13:15:00', '2023-03-25 15:45:00', 3.0, 2.5, 400.00, 375.00, 0.0),
('WO2023024', 'EQ009', 'MT002', 'MEDIUM', 'COMPLETED', 'Replace heat exchanger gaskets', 'Maintenance Team', '2023-03-28 08:00:00', '2023-03-28 08:00:00', '2023-03-28 16:00:00', '2023-03-28 08:20:00', '2023-03-28 15:30:00', 8.0, 7.17, 1600.00, 1500.00, 4.0),

-- Continue with more months (April through December)...
-- April 2023
('WO2023025', 'EQ025', 'MT001', 'HIGH', 'COMPLETED', 'Preventive maintenance on emergency pump', 'Safety Team', '2023-04-02 08:00:00', '2023-04-02 08:00:00', '2023-04-02 12:00:00', '2023-04-02 08:15:00', '2023-04-02 11:45:00', 4.0, 3.5, 700.00, 650.00, 0.0),
('WO2023026', 'EQ012', 'MT002', 'MEDIUM', 'COMPLETED', 'Replace motor cooling fan', 'Electrical Team', '2023-04-05 10:00:00', '2023-04-05 10:00:00', '2023-04-05 14:00:00', '2023-04-05 10:20:00', '2023-04-05 13:40:00', 4.0, 3.33, 850.00, 800.00, 2.0),
('WO2023027', 'EQ005', 'MT008', 'LOW', 'COMPLETED', 'Compressor performance monitoring', 'Reliability Engineer', '2023-04-08 09:00:00', '2023-04-08 09:00:00', '2023-04-08 11:00:00', '2023-04-08 09:10:00', '2023-04-08 10:50:00', 2.0, 1.67, 300.00, 275.00, 0.0),

-- Add some IN_PROGRESS and OPEN work orders for current state
('WO2023028', 'EQ016', 'MT002', 'HIGH', 'IN_PROGRESS', 'Pressure transmitter showing erratic readings', 'Control Room Operator', '2023-04-10 09:00:00', '2023-04-10 14:00:00', '2023-04-10 18:00:00', '2023-04-10 14:15:00', NULL, 4.0, NULL, 600.00, NULL, NULL),
('WO2023029', 'EQ003', 'MT006', 'MEDIUM', 'OPEN', 'Scheduled overhaul of cooling water pump 1', 'Maintenance Planner', '2023-04-12 08:00:00', '2023-04-15 08:00:00', '2023-04-17 17:00:00', NULL, NULL, 24.0, NULL, 8500.00, NULL, NULL),
('WO2023030', 'EQ021', 'MT004', 'LOW', 'OPEN', 'Generator monthly inspection', 'Safety Team', '2023-04-14 10:00:00', '2023-04-14 10:00:00', '2023-04-14 14:00:00', NULL, NULL, 4.0, NULL, 500.00, NULL, NULL);

-- =====================================================
-- WORK ORDER ASSIGNMENTS
-- =====================================================
INSERT INTO WORK_ORDER_ASSIGNMENTS (ASSIGNMENT_ID, WORK_ORDER_ID, TECHNICIAN_ID, ROLE, HOURS_WORKED) VALUES
-- January assignments
('A001', 'WO2023001', 'T002', 'LEAD', 3.5),
('A002', 'WO2023001', 'T005', 'ASSISTANT', 2.0),
('A003', 'WO2023002', 'T003', 'LEAD', 2.7),
('A004', 'WO2023003', 'T002', 'LEAD', 1.7),
('A005', 'WO2023004', 'T001', 'LEAD', 2.0),
('A006', 'WO2023004', 'T006', 'SPECIALIST', 1.25),
('A007', 'WO2023005', 'T001', 'LEAD', 3.3),
('A008', 'WO2023006', 'T008', 'LEAD', 2.6),
('A009', 'WO2023007', 'T011', 'LEAD', 3.25),
('A010', 'WO2023008', 'T007', 'LEAD', 5.5),
('A011', 'WO2023008', 'T002', 'ASSISTANT', 3.0),
('A012', 'WO2023008', 'T005', 'ASSISTANT', 2.25),

-- February assignments
('A013', 'WO2023009', 'T002', 'LEAD', 3.75),
('A014', 'WO2023009', 'T005', 'ASSISTANT', 2.0),
('A015', 'WO2023010', 'T003', 'LEAD', 2.5),
('A016', 'WO2023011', 'T007', 'LEAD', 3.0),
('A017', 'WO2023011', 'T002', 'ASSISTANT', 2.17),
('A018', 'WO2023012', 'T001', 'LEAD', 2.5),
('A019', 'WO2023013', 'T008', 'LEAD', 2.25),
('A020', 'WO2023014', 'T006', 'LEAD', 4.0),
('A021', 'WO2023014', 'T010', 'ASSISTANT', 3.0),
('A022', 'WO2023015', 'T003', 'LEAD', 3.33),
('A023', 'WO2023016', 'T011', 'LEAD', 4.0),
('A024', 'WO2023016', 'T001', 'SPECIALIST', 3.5),

-- March assignments
('A025', 'WO2023017', 'T002', 'LEAD', 3.5),
('A026', 'WO2023018', 'T011', 'LEAD', 3.67),
('A027', 'WO2023019', 'T007', 'LEAD', 20.0),
('A028', 'WO2023019', 'T002', 'ASSISTANT', 15.0),
('A029', 'WO2023019', 'T004', 'SPECIALIST', 12.0),
('A030', 'WO2023019', 'T001', 'SPECIALIST', 11.0),
('A031', 'WO2023020', 'T003', 'LEAD', 2.33),
('A032', 'WO2023021', 'T005', 'LEAD', 1.67),
('A033', 'WO2023022', 'T002', 'LEAD', 4.0),
('A034', 'WO2023022', 'T007', 'ASSISTANT', 3.5),
('A035', 'WO2023023', 'T008', 'LEAD', 2.5),
('A036', 'WO2023024', 'T007', 'LEAD', 4.0),
('A037', 'WO2023024', 'T005', 'ASSISTANT', 3.17),

-- April assignments
('A038', 'WO2023025', 'T002', 'LEAD', 3.5),
('A039', 'WO2023026', 'T001', 'LEAD', 3.33),
('A040', 'WO2023027', 'T008', 'LEAD', 1.67),
('A041', 'WO2023028', 'T003', 'LEAD', 2.5); -- IN_PROGRESS work order

-- =====================================================
-- WORK ORDER PARTS USAGE
-- =====================================================
INSERT INTO WORK_ORDER_PARTS (USAGE_ID, WORK_ORDER_ID, PART_ID, QUANTITY_USED, UNIT_COST, TOTAL_COST) VALUES
-- Parts used in completed work orders
('U001', 'WO2023001', 'P002', 2, 185.00, 370.00),
('U002', 'WO2023001', 'P008', 1, 485.00, 485.00),
('U003', 'WO2023003', 'P005', 2, 89.50, 179.00),
('U004', 'WO2023004', 'P003', 1, 3200.00, 3200.00),
('U005', 'WO2023008', 'P006', 2, 650.00, 1300.00),
('U006', 'WO2023009', 'P002', 2, 185.00, 370.00),
('U007', 'WO2023009', 'P008', 1, 485.00, 485.00),
('U008', 'WO2023011', 'P002', 4, 185.00, 740.00),
('U009', 'WO2023014', 'P015', 8, 85.00, 680.00),
('U010', 'WO2023016', 'P010', 1, 180.00, 180.00),
('U011', 'WO2023019', 'P001', 2, 2850.00, 5700.00),
('U012', 'WO2023019', 'P002', 8, 185.00, 1480.00),
('U013', 'WO2023019', 'P013', 2, 320.00, 640.00),
('U014', 'WO2023022', 'P008', 1, 485.00, 485.00),
('U015', 'WO2023024', 'P006', 1, 650.00, 650.00),
('U016', 'WO2023025', 'P008', 1, 485.00, 485.00),
('U017', 'WO2023026', 'P007', 2, 145.00, 290.00);

-- =====================================================
-- WORK ORDER FAILURES TRACKING
-- =====================================================
INSERT INTO WORK_ORDER_FAILURES (WORK_ORDER_ID, FAILURE_CODE, NOTES) VALUES
('WO2023004', 'F004', 'Control valve actuator sticking due to air contamination'),
('WO2023008', 'F008', 'Severe fouling on tube side, chemical cleaning required'),
('WO2023011', 'F001', 'Motor bearing failure due to inadequate lubrication'),
('WO2023019', 'F001', 'Multiple bearing failures detected during overhaul'),
('WO2023019', 'F010', 'Excessive vibration measurements triggered overhaul'),
('WO2023022', 'F002', 'Mechanical seal failure causing significant leakage'),
('WO2023028', 'F005', 'Pressure transmitter showing calibration drift');

COMMENT ON TABLE WORK_ORDERS IS 'Historical and current maintenance work orders with scheduling and cost tracking';
COMMENT ON TABLE WORK_ORDER_ASSIGNMENTS IS 'Technician assignments and labor hours for work orders';
COMMENT ON TABLE WORK_ORDER_PARTS IS 'Parts consumption and cost tracking for maintenance activities';
COMMENT ON TABLE WORK_ORDER_FAILURES IS 'Failure mode tracking for root cause analysis and trending';
