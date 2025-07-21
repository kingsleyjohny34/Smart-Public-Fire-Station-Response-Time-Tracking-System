# Smart Public Fire Station Response Time Tracking System

A comprehensive blockchain-based system for tracking and analyzing fire station emergency response times, equipment readiness, and training effectiveness.

## System Overview

This system consists of five interconnected smart contracts that work together to provide complete visibility into fire station operations:

### 1. Call Dispatch Contract (`call-dispatch.clar`)
- Records incoming emergency calls with timestamps
- Tracks response initiation and dispatch details
- Manages call priority levels and incident types
- Provides call history and status tracking

### 2. Travel Time Monitoring Contract (`travel-time-monitoring.clar`)
- Tracks fire truck departure and arrival times
- Calculates travel duration for each incident
- Records route information and traffic conditions
- Monitors multiple trucks per incident

### 3. Performance Analysis Contract (`performance-analysis.clar`)
- Evaluates response times against established goals
- Generates performance metrics and statistics
- Tracks improvement trends over time
- Identifies areas needing attention

### 4. Equipment Readiness Contract (`equipment-readiness.clar`)
- Monitors fire truck fuel levels and equipment status
- Tracks maintenance schedules and readiness scores
- Records equipment checks and inspections
- Ensures trucks are deployment-ready

### 5. Training Impact Contract (`training-impact.clar`)
- Records training sessions and participant details
- Measures training effectiveness on response times
- Tracks skill development and certification status
- Correlates training with performance improvements

## Key Features

- **Real-time Tracking**: Monitor all aspects of emergency response in real-time
- **Performance Analytics**: Comprehensive analysis of response time goals and achievements
- **Equipment Management**: Ensure all fire trucks are properly maintained and stocked
- **Training Effectiveness**: Measure how training programs impact response efficiency
- **Historical Data**: Complete audit trail of all emergency responses and operations

## Data Flow

1. Emergency call received → Call Dispatch Contract records details
2. Fire truck dispatched → Travel Time Monitoring begins tracking
3. Equipment status verified → Equipment Readiness Contract confirms readiness
4. Arrival at scene → Travel Time Monitoring records completion
5. Performance analyzed → Performance Analysis Contract evaluates metrics
6. Training correlation → Training Impact Contract measures effectiveness

## Response Time Goals

- **Urban Areas**: Target response time of 4 minutes or less
- **Suburban Areas**: Target response time of 6 minutes or less
- **Rural Areas**: Target response time of 10 minutes or less

## Installation

1. Install Clarinet CLI
2. Clone this repository
3. Run `clarinet check` to validate contracts
4. Run `npm test` to execute test suite
5. Deploy contracts using `clarinet deploy`

## Testing

The system includes comprehensive tests using Vitest:
- Unit tests for each contract function
- Integration tests for cross-contract workflows
- Performance benchmarking tests
- Edge case and error handling tests

## Usage

Each contract provides specific functions for different aspects of fire station operations. Refer to individual contract files for detailed function documentation and usage examples.

## Contributing

Please read PR-DETAILS.md for information about contributing to this project.
