-- Industrial Maintenance Operations - Sample Data Generation Script
-- Snowflake Data Insertion Scripts for Maintenance Operations

USE DATABASE MAINTENANCE_OPERATIONS;
USE SCHEMA OPERATIONS;

-- =====================================================
-- 1. INSERT MAINTENANCE TYPES
-- =====================================================
INSERT INTO MAINTENANCE_TYPES (MAINTENANCE_TYPE_ID, TYPE_NAME, DESCRIPTION, CATEGORY, TYPICAL_DURATION_HOURS) VALUES
('MT001', 'Preventive Maintenance', 'Scheduled routine maintenance to prevent failures', 'PREVENTIVE', 4.0),
('MT002', 'Corrective Maintenance', 'Repair work to fix identified issues', 'CORRECTIVE', 6.0),
('MT003', 'Emergency Repair', 'Urgent repair work for critical failures', 'EMERGENCY', 8.0),
('MT004', 'Inspection', 'Visual and technical inspection of equipment', 'PREVENTIVE', 2.0),
('MT005', 'Calibration', 'Instrument and control system calibration', 'PREVENTIVE', 3.0),
('MT006', 'Overhaul', 'Major maintenance and component replacement', 'PREVENTIVE', 24.0),
('MT007', 'Lubrication', 'Equipment lubrication and fluid change', 'PREVENTIVE', 1.5),
('MT008', 'Condition Monitoring', 'Predictive maintenance using monitoring data', 'PREDICTIVE', 2.5),
('MT009', 'Safety Testing', 'Safety system testing and validation', 'PREVENTIVE', 4.0),
('MT010', 'Software Update', 'Control system and software updates', 'PREVENTIVE', 3.0);

-- =====================================================
-- 2. INSERT TECHNICIANS
-- =====================================================
INSERT INTO TECHNICIANS (TECHNICIAN_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE, HIRE_DATE, SPECIALIZATION, CERTIFICATION_LEVEL, HOURLY_RATE, STATUS) VALUES
('T001', 'John', 'Anderson', 'j.anderson@company.com', '555-0101', '2018-03-15', 'Electrical Systems', 'SENIOR', 45.00, 'ACTIVE'),
('T002', 'Sarah', 'Mitchell', 's.mitchell@company.com', '555-0102', '2019-07-22', 'Mechanical Equipment', 'INTERMEDIATE', 38.50, 'ACTIVE'),
('T003', 'David', 'Thompson', 'd.thompson@company.com', '555-0103', '2020-01-10', 'Instrumentation', 'EXPERT', 52.00, 'ACTIVE'),
('T004', 'Lisa', 'Rodriguez', 'l.rodriguez@company.com', '555-0104', '2017-11-05', 'Electrical Systems', 'EXPERT', 48.00, 'ACTIVE'),
('T005', 'Michael', 'Chang', 'm.chang@company.com', '555-0105', '2021-04-18', 'Mechanical Equipment', 'JUNIOR', 32.00, 'ACTIVE'),
('T006', 'Jennifer', 'Wilson', 'j.wilson@company.com', '555-0106', '2019-09-12', 'Process Control', 'INTERMEDIATE', 41.50, 'ACTIVE'),
('T007', 'Robert', 'Brown', 'r.brown@company.com', '555-0107', '2016-02-28', 'Mechanical Equipment', 'SENIOR', 46.50, 'ACTIVE'),
('T008', 'Amanda', 'Davis', 'a.davis@company.com', '555-0108', '2020-08-03', 'Instrumentation', 'INTERMEDIATE', 39.00, 'ACTIVE'),
('T009', 'Kevin', 'Taylor', 'k.taylor@company.com', '555-0109', '2018-12-01', 'Electrical Systems', 'INTERMEDIATE', 40.00, 'ACTIVE'),
('T010', 'Michelle', 'Garcia', 'm.garcia@company.com', '555-0110', '2022-01-15', 'Process Control', 'JUNIOR', 35.00, 'ACTIVE'),
('T011', 'James', 'Miller', 'j.miller@company.com', '555-0111', '2017-06-20', 'Safety Systems', 'SENIOR', 47.00, 'ACTIVE'),
('T012', 'Nicole', 'Johnson', 'n.johnson@company.com', '555-0112', '2021-10-08', 'Instrumentation', 'JUNIOR', 33.50, 'ACTIVE');

-- =====================================================
-- 3. INSERT EQUIPMENT
-- =====================================================
INSERT INTO EQUIPMENT (EQUIPMENT_ID, EQUIPMENT_NAME, EQUIPMENT_TYPE, MANUFACTURER, MODEL, SERIAL_NUMBER, INSTALLATION_DATE, LOCATION, FACILITY, CRITICALITY_LEVEL, STATUS, REPLACEMENT_COST) VALUES
-- Pumps
('EQ001', 'Main Feed Pump A', 'Centrifugal Pump', 'KSB', 'Etanorm 200-150-400', 'KSB2023001', '2019-03-15', 'Processing Unit 1', 'Main Plant', 'HIGH', 'ACTIVE', 125000.00),
('EQ002', 'Main Feed Pump B', 'Centrifugal Pump', 'KSB', 'Etanorm 200-150-400', 'KSB2023002', '2019-03-20', 'Processing Unit 1', 'Main Plant', 'HIGH', 'ACTIVE', 125000.00),
('EQ003', 'Cooling Water Pump 1', 'Centrifugal Pump', 'Goulds', 'Model 3196', 'GLD2022015', '2020-08-10', 'Cooling Tower', 'Main Plant', 'MEDIUM', 'ACTIVE', 85000.00),
('EQ004', 'Cooling Water Pump 2', 'Centrifugal Pump', 'Goulds', 'Model 3196', 'GLD2022016', '2020-08-12', 'Cooling Tower', 'Main Plant', 'MEDIUM', 'ACTIVE', 85000.00),

-- Compressors
('EQ005', 'Air Compressor Unit 1', 'Screw Compressor', 'Atlas Copco', 'GA 90', 'AC2021045', '2021-01-25', 'Utility Building', 'Main Plant', 'HIGH', 'ACTIVE', 95000.00),
('EQ006', 'Gas Compressor Stage 1', 'Centrifugal Compressor', 'Elliott', 'Model H-2500', 'ELL2018009', '2018-11-30', 'Gas Processing', 'Main Plant', 'HIGH', 'ACTIVE', 450000.00),
('EQ007', 'Gas Compressor Stage 2', 'Centrifugal Compressor', 'Elliott', 'Model H-2500', 'ELL2018010', '2018-12-05', 'Gas Processing', 'Main Plant', 'HIGH', 'ACTIVE', 450000.00),

-- Heat Exchangers
('EQ008', 'Primary Heat Exchanger', 'Shell and Tube', 'Alfa Laval', 'M30-FG', 'AL2020033', '2020-05-18', 'Processing Unit 1', 'Main Plant', 'HIGH', 'ACTIVE', 180000.00),
('EQ009', 'Secondary Heat Exchanger', 'Shell and Tube', 'Alfa Laval', 'M30-FG', 'AL2020034', '2020-05-20', 'Processing Unit 1', 'Main Plant', 'MEDIUM', 'ACTIVE', 180000.00),

-- Motors
('EQ010', 'Motor - Main Feed Pump A', 'Electric Motor', 'Siemens', '1LA7 224-4AB10', 'SIE2019078', '2019-03-15', 'Processing Unit 1', 'Main Plant', 'HIGH', 'ACTIVE', 35000.00),
('EQ011', 'Motor - Main Feed Pump B', 'Electric Motor', 'Siemens', '1LA7 224-4AB10', 'SIE2019079', '2019-03-20', 'Processing Unit 1', 'Main Plant', 'HIGH', 'ACTIVE', 35000.00),
('EQ012', 'Motor - Cooling Pump 1', 'Electric Motor', 'ABB', 'M3BP 180L', 'ABB2020134', '2020-08-10', 'Cooling Tower', 'Main Plant', 'MEDIUM', 'ACTIVE', 28000.00),

-- Valves
('EQ013', 'Main Control Valve A', 'Control Valve', 'Fisher', 'ED Type', 'FSH2021067', '2021-06-12', 'Processing Unit 1', 'Main Plant', 'HIGH', 'ACTIVE', 45000.00),
('EQ014', 'Main Control Valve B', 'Control Valve', 'Fisher', 'ED Type', 'FSH2021068', '2021-06-15', 'Processing Unit 1', 'Main Plant', 'HIGH', 'ACTIVE', 45000.00),
('EQ015', 'Safety Relief Valve 1', 'Safety Valve', 'Emerson', 'Crosby J Series', 'EMR2020089', '2020-02-28', 'Processing Unit 1', 'Main Plant', 'HIGH', 'ACTIVE', 25000.00),

-- Instruments
('EQ016', 'Pressure Transmitter PT-101', 'Pressure Transmitter', 'Rosemount', '3051S', 'ROS2022145', '2022-04-05', 'Processing Unit 1', 'Main Plant', 'MEDIUM', 'ACTIVE', 3500.00),
('EQ017', 'Temperature Transmitter TT-101', 'Temperature Transmitter', 'Rosemount', '3144P', 'ROS2022146', '2022-04-05', 'Processing Unit 1', 'Main Plant', 'MEDIUM', 'ACTIVE', 2800.00),
('EQ018', 'Flow Transmitter FT-101', 'Flow Transmitter', 'Endress+Hauser', 'Promass 83F', 'EH2021234', '2021-11-20', 'Processing Unit 1', 'Main Plant', 'MEDIUM', 'ACTIVE', 8500.00),

-- Electrical Equipment
('EQ019', 'MCC Panel A', 'Motor Control Center', 'Schneider Electric', 'BlokSeT', 'SE2020156', '2020-09-14', 'Electrical Room', 'Main Plant', 'HIGH', 'ACTIVE', 75000.00),
('EQ020', 'Transformer T-1', 'Power Transformer', 'ABB', '630 kVA', 'ABB2019234', '2019-07-08', 'Electrical Substation', 'Main Plant', 'HIGH', 'ACTIVE', 120000.00),

-- Additional Equipment for more data variety
('EQ021', 'Backup Generator', 'Diesel Generator', 'Caterpillar', 'C32', 'CAT2018445', '2018-12-15', 'Generator Building', 'Main Plant', 'HIGH', 'ACTIVE', 250000.00),
('EQ022', 'Cooling Tower Fan 1', 'Axial Fan', 'Baltimore Aircoil', 'VXI-1067', 'BAC2020078', '2020-03-22', 'Cooling Tower', 'Main Plant', 'MEDIUM', 'ACTIVE', 65000.00),
('EQ023', 'Steam Boiler', 'Package Boiler', 'Cleaver-Brooks', 'CB-REC-2000', 'CB2017123', '2017-05-10', 'Boiler House', 'Main Plant', 'HIGH', 'ACTIVE', 350000.00),
('EQ024', 'Water Treatment Skid', 'RO System', 'GE Water', 'ZeeWeed 1000', 'GE2021089', '2021-09-30', 'Water Treatment', 'Main Plant', 'MEDIUM', 'ACTIVE', 195000.00),
('EQ025', 'Emergency Pump', 'Centrifugal Pump', 'Flowserve', 'Mark 3', 'FS2022033', '2022-02-14', 'Emergency Systems', 'Main Plant', 'HIGH', 'ACTIVE', 110000.00);

-- =====================================================
-- 4. INSERT PARTS INVENTORY
-- =====================================================
INSERT INTO PARTS_INVENTORY (PART_ID, PART_NAME, PART_NUMBER, DESCRIPTION, CATEGORY, MANUFACTURER, UNIT_COST, QUANTITY_ON_HAND, REORDER_POINT, LOCATION) VALUES
('P001', 'Pump Impeller - KSB 200mm', 'KSB-IMP-200', 'Centrifugal pump impeller for main feed pumps', 'Pump Components', 'KSB', 2850.00, 4, 2, 'Warehouse A-12'),
('P002', 'Motor Bearing - Siemens 6324', 'SIE-BRG-6324', 'Deep groove ball bearing for electric motors', 'Bearings', 'Siemens', 185.00, 12, 6, 'Warehouse B-08'),
('P003', 'Control Valve Actuator', 'FSH-ACT-ED', 'Pneumatic actuator for Fisher ED control valves', 'Valve Components', 'Fisher', 3200.00, 3, 1, 'Warehouse A-05'),
('P004', 'Pressure Transmitter Diaphragm', 'ROS-DIA-3051', 'Replacement diaphragm for Rosemount transmitters', 'Instrumentation', 'Rosemount', 425.00, 8, 4, 'Warehouse C-03'),
('P005', 'Compressor Oil Filter', 'AC-FLT-GA90', 'Oil filter for Atlas Copco GA90 compressor', 'Filters', 'Atlas Copco', 89.50, 15, 8, 'Warehouse B-15'),
('P006', 'Heat Exchanger Gasket Set', 'AL-GSK-M30', 'Complete gasket set for Alfa Laval M30 heat exchanger', 'Gaskets & Seals', 'Alfa Laval', 650.00, 6, 3, 'Warehouse A-18'),
('P007', 'Electric Motor Contactor', 'SE-CNT-LC1D', 'Motor starter contactor for Schneider Electric MCC', 'Electrical', 'Schneider Electric', 145.00, 20, 10, 'Warehouse C-12'),
('P008', 'Pump Mechanical Seal', 'GLD-SEAL-3196', 'Mechanical seal assembly for Goulds 3196 pumps', 'Seals', 'Goulds', 485.00, 8, 4, 'Warehouse A-09'),
('P009', 'Valve Stem Packing', 'FSH-PKG-ED', 'PTFE packing set for Fisher ED control valves', 'Valve Components', 'Fisher', 125.00, 25, 12, 'Warehouse A-05'),
('P010', 'Transformer Oil 25L', 'TRF-OIL-25L', 'Insulating oil for power transformers', 'Fluids', 'Shell', 180.00, 12, 6, 'Warehouse D-01'),
('P011', 'Generator Air Filter', 'CAT-AF-C32', 'Air filter element for Caterpillar C32 generator', 'Filters', 'Caterpillar', 95.00, 10, 5, 'Warehouse B-20'),
('P012', 'Thermocouple Type K', 'ROS-TC-K', 'Temperature sensor for Rosemount transmitters', 'Instrumentation', 'Rosemount', 215.00, 15, 8, 'Warehouse C-03'),
('P013', 'Coupling Element', 'CPL-ELM-L100', 'Flexible coupling element for motor-pump connection', 'Couplings', 'Lovejoy', 320.00, 6, 3, 'Warehouse B-05'),
('P014', 'Circuit Breaker 250A', 'SE-CB-250A', 'Motor protection circuit breaker', 'Electrical', 'Schneider Electric', 890.00, 5, 2, 'Warehouse C-12'),
('P015', 'Hydraulic Oil ISO 46', 'HYD-OIL-46', 'Hydraulic fluid for control systems', 'Fluids', 'Mobil', 85.00, 20, 10, 'Warehouse D-01');

-- =====================================================
-- 5. INSERT FAILURE CODES
-- =====================================================
INSERT INTO FAILURE_CODES (FAILURE_CODE, FAILURE_DESCRIPTION, FAILURE_CATEGORY, ROOT_CAUSE, RECOMMENDED_ACTION) VALUES
('F001', 'Bearing Failure', 'MECHANICAL', 'Inadequate lubrication or contamination', 'Replace bearing, check lubrication system, analyze oil condition'),
('F002', 'Seal Leakage', 'MECHANICAL', 'Wear, misalignment, or improper installation', 'Replace mechanical seal, check shaft alignment, verify installation'),
('F003', 'Motor Overheating', 'ELECTRICAL', 'Overload, poor ventilation, or electrical issues', 'Check motor load, clean cooling passages, verify electrical connections'),
('F004', 'Control Valve Sticking', 'MECHANICAL', 'Actuator failure or valve seat damage', 'Service actuator, inspect valve internals, calibrate positioning'),
('F005', 'Instrument Drift', 'ELECTRICAL', 'Temperature effects or component aging', 'Recalibrate instrument, check environmental conditions, replace if needed'),
('F006', 'Pump Cavitation', 'HYDRAULIC', 'Insufficient NPSH or suction line issues', 'Check suction conditions, verify NPSH available, inspect suction piping'),
('F007', 'Compressor Surge', 'MECHANICAL', 'Operating outside design envelope', 'Adjust operating conditions, check anti-surge controls, verify process conditions'),
('F008', 'Heat Exchanger Fouling', 'THERMAL', 'Fluid contamination or scaling', 'Clean heat exchanger, analyze fouling cause, implement prevention measures'),
('F009', 'Electrical Contact Failure', 'ELECTRICAL', 'Arcing, corrosion, or mechanical wear', 'Replace contacts, check electrical connections, verify operating environment'),
('F010', 'Vibration Excessive', 'MECHANICAL', 'Imbalance, misalignment, or wear', 'Balance rotating equipment, check alignment, inspect for wear'),
('F011', 'Pressure Drop High', 'HYDRAULIC', 'Filter clogging or pipe restriction', 'Replace filters, inspect piping, check for blockages'),
('F012', 'Temperature Deviation', 'THERMAL', 'Heat transfer issues or sensor failure', 'Check heat transfer equipment, calibrate temperature sensors, verify process conditions');

-- =====================================================
-- 6. INSERT MAINTENANCE PROCEDURES
-- =====================================================
INSERT INTO MAINTENANCE_PROCEDURES (PROCEDURE_ID, PROCEDURE_NAME, EQUIPMENT_TYPE, MAINTENANCE_TYPE_ID, DESCRIPTION, STEP_BY_STEP_INSTRUCTIONS, SAFETY_REQUIREMENTS, TOOLS_REQUIRED, ESTIMATED_DURATION_HOURS, SKILL_LEVEL_REQUIRED) VALUES
('PR001', 'Centrifugal Pump Preventive Maintenance', 'Centrifugal Pump', 'MT001', 
'Routine maintenance for centrifugal pumps including inspection, lubrication, and alignment check',
'1. Isolate pump and lock out energy sources\n2. Drain pump and piping\n3. Remove pump casing\n4. Inspect impeller for wear or damage\n5. Check mechanical seal condition\n6. Inspect bearings and lubrication\n7. Verify shaft alignment\n8. Reassemble with new gaskets\n9. Test run and check performance',
'Lock out/tag out procedures required. Confined space entry if applicable. Eye protection mandatory.',
'Standard hand tools, dial indicators, feeler gauges, torque wrench, lifting equipment',
6.0, 'INTERMEDIATE'),

('PR002', 'Electric Motor Inspection', 'Electric Motor', 'MT004',
'Comprehensive inspection of electric motors including electrical and mechanical components',
'1. De-energize and lock out motor\n2. Visual inspection of housing and connections\n3. Check insulation resistance\n4. Inspect bearings and lubrication\n5. Check coupling alignment\n6. Verify cooling system operation\n7. Test electrical connections\n8. Record findings and recommendations',
'Electrical safety procedures required. Qualified electrician only for electrical work.',
'Megohmmeter, multimeter, infrared thermometer, dial indicators, grease gun',
3.0, 'INTERMEDIATE'),

('PR003', 'Control Valve Calibration', 'Control Valve', 'MT005',
'Calibration and testing of control valves and actuators',
'1. Isolate valve from process\n2. Connect calibration equipment\n3. Check actuator air supply\n4. Perform stroke test\n5. Calibrate positioner\n6. Check control signal response\n7. Verify safety functions\n8. Document calibration results',
'Process isolation required. Verify safe conditions before work.',
'Pressure calibrator, multimeter, air supply, calibration software',
4.0, 'SENIOR'),

('PR004', 'Heat Exchanger Cleaning', 'Shell and Tube', 'MT002',
'Chemical or mechanical cleaning of shell and tube heat exchangers',
'1. Isolate heat exchanger from process\n2. Drain and flush with water\n3. Remove tube bundle if required\n4. Inspect tubes for fouling or damage\n5. Clean using appropriate method\n6. Pressure test after cleaning\n7. Reassemble with new gaskets\n8. Return to service gradually',
'Chemical handling procedures. Confined space entry. Respiratory protection may be required.',
'Cleaning chemicals, pressure testing equipment, gasket material, lifting equipment',
12.0, 'SENIOR'),

('PR005', 'Compressor Overhaul', 'Centrifugal Compressor', 'MT006',
'Major overhaul of centrifugal compressors including rotor inspection',
'1. Shutdown and isolate compressor\n2. Remove casing and rotor assembly\n3. Inspect impellers and diffusers\n4. Check bearing condition\n5. Measure critical clearances\n6. Replace worn components\n7. Balance rotor if required\n8. Reassemble and test',
'Confined space entry. Heavy lifting operations. Specialized equipment required.',
'Precision measuring tools, balancing equipment, lifting devices, specialized tooling',
40.0, 'EXPERT');

COMMENT ON TABLE EQUIPMENT IS 'Master equipment register containing all maintained assets';
COMMENT ON TABLE WORK_ORDERS IS 'Main maintenance work order tracking table';
COMMENT ON TABLE TECHNICIANS IS 'Maintenance technician information and qualifications';
COMMENT ON TABLE MAINTENANCE_TYPES IS 'Classification of different maintenance activities';
COMMENT ON TABLE PARTS_INVENTORY IS 'Spare parts and materials inventory management';
COMMENT ON TABLE WORK_ORDER_PARTS IS 'Parts consumption tracking for work orders';
COMMENT ON TABLE MAINTENANCE_PROCEDURES IS 'Standard maintenance procedures and instructions';
COMMENT ON TABLE FAILURE_CODES IS 'Standardized failure modes and root causes';
