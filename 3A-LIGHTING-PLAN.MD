# 3A Lighting - Classic MyDesk Implementation Plan

**Project Code:** 3AL-MYDESK-01  
**Client:** 3A Lighting (Khim)  
**Prepared by:** Peter Bardenhagen, Digital Response  
**Date:** 07 August 2026  
**Delivery Timeline:** 4 weeks from approval to go-live

---

## Project Overview

This implementation plan details the Classic MyDesk uplift and workflow expansion for 3A Lighting. The solution will provide Khim with a rebranded, configured instance enabling seamless supplier and customer workflows, including quote management, proforma invoicing, purchase order handling, and automated landed cost calculations.

---

## Scope of Works

### Core Deliverables

1. **Rebrand and configure Classic MyDesk for 3A Lighting**
   - Apply 3A Lighting branding (colors, logo, domain)
   - Configure system settings and defaults
   - Set up environment for Sydney office

2. **Access & Security Setup**
   - Lock down platform to Sydney office location
   - Create single named user account for Khim
   - Configure user roles and permissions

3. **Supplier-side Workflow**
   - Enable supplier sourcing and management
   - Implement data sheet attachments
   - Add confidentiality controls for supplier names
   - Support multiple supplier communication channels

4. **Customer-side Workflow**
   - Enable Bert to request quotes within the system
   - Implement quote preparation tools
   - Allow quote acceptance workflow inside platform
   - Configure customer communication templates

5. **Proforma Invoice (PI) Handling**
   - Implement PI generation from quotes
   - Create black-and-white document templates
   - Enable supplier PI verification before supply
   - Configure PI-to-PO conversion flow

6. **Quote to PO Conversion**
   - Build workflow to convert quotes to purchase orders
   - Maintain data integrity through conversion
   - Track status across document lifecycle

7. **Landed Cost Logic**
   - Implement cost calculation engine:
     - Factory cost (base cost)
     - Freight charges
     - Customs duty
     - Exchange rate buffers
   - Integrate daily bank spot rate lookup
   - Document and confirm formula during discovery

8. **Supplier PI to Customer Quote Copy**
   - Enable selective copying of supplier details to customer quotes
   - Apply confidentiality rules where needed
   - Maintain audit trail of copied data

9. **Email & Domain Setup**
   - Configure @3a-lighting.com.au domain
   - Set up email forwarding and routing
   - Create email templates for quotes, PIs, and POs
   - Test deliverability and branding

10. **Documentation & Handover**
    - Create system documentation
    - Provide user guides for Khim and Bert
    - Conduct handover training
    - Provide production support during first rollout

### Current Module Set

| Module | Function |
|--------|----------|
| Contacts | Customer and supplier management |
| Quotes | Pricing and approval workflows |
| Invoices | Billing and exports |
| Purchase Orders | Supplier order management |
| Setup | System configuration and settings |
| Users | Access control and team management |
| Log Off | Session termination |
| Dashboard | Quick navigation and overview |

---

## Week-by-Week Milestones

### Week 1: Discovery, Solution Design & Access Setup

**Outcomes:** Confirmed workflows, branding specs, user configuration, and core business rules

**Tasks:**

#### Discovery & Requirements (3-4 days)
- [ ] Conduct discovery meetings with Khim and Bert
- [ ] Document current business workflows for quotes, PIs, and POs
- [ ] Clarify confidentiality requirements for supplier data
- [ ] Define landed cost calculation rules and confirm buffer percentages
- [ ] Confirm daily bank spot rate data source and update frequency
- [ ] Gather branding requirements (colors, logo, domain)
- [ ] Define email templates and communication preferences
- [ ] Document edge cases and special handling requirements

#### Solution Design (1-2 days)
- [ ] Create workflow diagrams for supplier and customer journeys
- [ ] Design database schema changes (if any)
- [ ] Design API integrations for bank spot rates
- [ ] Create wireframes for new UI screens (if needed)
- [ ] Document landed cost calculation formula
- [ ] Define user roles and permission matrix
- [ ] Create data migration strategy (if applicable)

#### Access & Infrastructure Setup (1-2 days)
- [ ] Provision staging and production environments
- [ ] Configure server IP restrictions for Sydney office
- [ ] Set up user account for Khim with appropriate role
- [ ] Configure OAuth/SSO if applicable
- [ ] Set up @3a-lighting.com.au domain DNS and mail routing
- [ ] Create database backups and disaster recovery procedures

**Deliverables:**
- Discovery document with workflow descriptions
- Solution design specification
- Access control matrix
- Branding guidelines document
- Email template specifications
- Infrastructure setup checklist

---

### Week 2: Classic MyDesk Uplift & Core Feature Build

**Outcomes:** Functional supplier/customer workflows, PIs, POs, and landed cost logic

**Tasks:**

#### Rebrand & Configuration (1-2 days)
- [ ] Apply 3A Lighting branding throughout UI
- [ ] Configure system settings and defaults
- [ ] Customize dashboard with relevant metrics
- [ ] Set up system email configuration
- [ ] Configure logo, favicon, and branding assets
- [ ] Test branding across all modules

#### Contacts Module Enhancement (1 day)
- [ ] Add supplier classification system
- [ ] Implement confidentiality flags for suppliers
- [ ] Add supplier category and sourcing information
- [ ] Implement contact search and filtering
- [ ] Add bulk import capability for contacts

#### Quotes Module Development (1.5 days)
- [ ] Implement quote creation workflow
- [ ] Add customer quote request mechanism (web form or email)
- [ ] Implement quote approval workflow
- [ ] Add quote acceptance tracking
- [ ] Create quote email templates
- [ ] Implement quote status tracking
- [ ] Add quote expiration management

#### Proforma Invoice Module (1.5 days)
- [ ] Implement PI generation from quotes
- [ ] Create professional PI document template (black & white)
- [ ] Add PI signature/verification mechanism
- [ ] Implement PI-to-PO conversion
- [ ] Add PI status tracking
- [ ] Create PI email templates
- [ ] Implement supplier acknowledgment tracking

#### Purchase Order Module (1 day)
- [ ] Enhance PO creation with Quote/PI linkage
- [ ] Implement PO approval workflow
- [ ] Add PO numbering and tracking
- [ ] Create PO email templates
- [ ] Add supplier response tracking

#### Landed Cost Logic Implementation (1.5 days)
- [ ] Design cost calculation engine
- [ ] Implement factory cost base calculation
- [ ] Integrate daily bank spot rate API
- [ ] Implement freight charge module
- [ ] Implement customs duty calculator
- [ ] Implement exchange rate buffer logic
- [ ] Create cost calculation UI and reports
- [ ] Add cost breakdown display on quotes and POs

#### Data Integration (1 day)
- [ ] Build supplier PI → customer quote copy functionality
- [ ] Implement confidentiality field filtering
- [ ] Add audit logging for data copies
- [ ] Create mapping rules for PI to quote fields
- [ ] Test data integrity through copy process

**Deliverables:**
- Rebranded Classic MyDesk instance
- Functional supplier management with confidentiality controls
- Quote management with approval workflow
- Proforma invoice module with PI generation
- Purchase order workflow with quote linkage
- Landed cost calculation engine with bank rate integration
- Data copy functionality with audit trail

---

### Week 3: Testing & User Acceptance Testing (UAT)

**Outcomes:** Validated workflows, documented issues fixed, UAT sign-off

**Tasks:**

#### Functional Testing (2 days)
- [ ] Test complete quote creation workflow
- [ ] Test quote approval and acceptance flow
- [ ] Test PI generation and supplier verification
- [ ] Test PI-to-PO conversion workflow
- [ ] Test landed cost calculations with various scenarios
- [ ] Test bank spot rate integration and updates
- [ ] Test supplier data confidentiality enforcement
- [ ] Test email delivery and template rendering
- [ ] Test contact management and search
- [ ] Test user access controls and permissions
- [ ] Test branding consistency across modules
- [ ] Test domain and email configuration

#### Performance & Security Testing (1 day)
- [ ] Load testing on core workflows
- [ ] Security testing on confidential data handling
- [ ] Database backup and recovery testing
- [ ] SSL/TLS certificate validation
- [ ] Permission and access control verification

#### User Acceptance Testing with Khim (1.5 days)
- [ ] UAT session with Khim and Bert
- [ ] Test supplier workflow with sample data
- [ ] Test customer workflow with sample data
- [ ] Validate email templates and communications
- [ ] Confirm landed cost calculations accuracy
- [ ] Review documentation and user guides
- [ ] Test system responsiveness and performance
- [ ] Validate data export and reporting

#### Issue Resolution (1 day)
- [ ] Document all issues found during testing
- [ ] Prioritize issues (critical, high, medium, low)
- [ ] Fix critical and high-priority issues
- [ ] Re-test resolved issues
- [ ] Document any known limitations
- [ ] Get UAT sign-off from Khim

**Deliverables:**
- Functional testing report
- Security testing report
- UAT sign-off document
- Issue log and resolutions
- Updated user documentation
- Known issues and workarounds list

---

### Week 4: Final Polish, Deployment & Handover

**Outcomes:** Go-live, production deployment, user training, support setup

**Tasks:**

#### Final Polish & Optimization (1 day)
- [ ] Code review and cleanup
- [ ] Optimize database queries
- [ ] Minimize page load times
- [ ] Review and finalize all email templates
- [ ] Polish UI for edge cases
- [ ] Final branding consistency check
- [ ] Documentation review and updates

#### Data Migration & Preparation (0.5 days)
- [ ] Prepare production data (if migrating from existing system)
- [ ] Set up initial supplier and customer records
- [ ] Configure system defaults and initial settings
- [ ] Create Khim's production user account
- [ ] Set up API integrations (bank spot rates, etc.)

#### Deployment to Production (1 day)
- [ ] Create deployment checklist
- [ ] Deploy to production environment
- [ ] Verify all services and integrations working
- [ ] Test critical workflows in production
- [ ] Configure monitoring and alerting
- [ ] Set up log aggregation and audit trails
- [ ] Verify backups are running

#### User Training & Documentation (1 day)
- [ ] Prepare training materials
- [ ] Conduct training session with Khim and Bert
- [ ] Walk through key workflows
- [ ] Review reporting and data export
- [ ] Demonstrate admin/setup panel
- [ ] Provide user guides and documentation
- [ ] Set up help and support process

#### Go-Live Support & Handover (1 day)
- [ ] Monitor system during go-live
- [ ] Respond to any production issues
- [ ] Provide real-time support to Khim
- [ ] Document any issues encountered
- [ ] Provide handover documentation
- [ ] Establish ongoing support process
- [ ] Schedule first follow-up check-in

**Deliverables:**
- Production deployment checklist and approval
- User training materials and guides
- System documentation (admin and user)
- Monitoring and alerting configuration
- Support procedures and escalation paths
- Go-live confirmation and sign-off
- First-month support plan

---

## Technical Architecture

### Core Technologies

- **Platform:** Classic MyDesk (Node.js/React based)
- **Database:** PostgreSQL
- **Frontend:** React with Tailwind CSS (or existing MyDesk styling)
- **API:** RESTful API with authentication
- **Email:** SMTP via @3a-lighting.com.au domain
- **External Integrations:** Bank spot rate API (XE.com, OANDA, or similar)

### Key Integrations

1. **Bank Spot Rate API**
   - Daily rate lookups for multiple currencies
   - Caching strategy for rate data
   - Fallback mechanism for API failures

2. **Email System**
   - Quote and PI email notifications
   - PO email delivery to suppliers
   - Template system for dynamic content
   - Delivery tracking and logging

### Database Schema Considerations

- Add `landed_cost_detail` table for cost breakdowns
- Add `supplier_confidentiality_flag` to supplier records
- Add `pi_to_quote_mapping` table for copy audit trail
- Add `bank_rate_cache` table for spot rates
- Extend quote/PO/PI models for workflow tracking

---

## Risk Management

### Identified Risks

| Risk | Impact | Probability | Mitigation |
|------|--------|-------------|-----------|
| Bank spot rate API unavailability | High | Low | Implement rate caching and fallback rates |
| Scope creep on landed cost calculations | Medium | Medium | Document exact formula during discovery |
| Email deliverability issues | Medium | Low | Verify SPF/DKIM/DMARC records upfront |
| User adoption challenges | Medium | Medium | Comprehensive training and documentation |
| Data confidentiality violations | High | Low | Implement strict access controls and auditing |
| Timeline slippage in Week 2-3 | Medium | Medium | Daily progress tracking, identify blockers early |

### Contingency Planning

- **Week 1 overruns:** Extend Week 2 timeline by 2-3 days
- **Week 2-3 issues:** Prioritize core workflows, defer nice-to-haves
- **Test failures:** Maintain detailed bug list, prioritize by impact
- **Production issues at go-live:** Have rollback plan and maintain support window

---

## Success Criteria

- [ ] All core workflows (quote → PI → PO) operational
- [ ] Landed cost calculations verified accurate
- [ ] Email delivery confirmed for all templates
- [ ] User access properly restricted to Sydney office
- [ ] UAT sign-off received from Khim
- [ ] Zero critical issues in production
- [ ] System performance meets requirements
- [ ] Documentation complete and reviewed
- [ ] User training completed successfully
- [ ] 30-day support period initiated

---

## Assumptions & Exclusions

### Assumptions

- Daily bank spot rates are publicly available via API
- Khim and Bert will be available for discovery and UAT sessions
- No major changes to Techlight infrastructure during project
- Existing Classic MyDesk codebase is stable and suitable for forking
- @3a-lighting.com.au domain can be configured for email routing

### Exclusions

- Trello, Monday.com, Gmail forwarding, or Office 365 integrations
- VPN setup or network configuration beyond web access
- Tax, accounting, or financial advisory
- Customization beyond the stated scope
- Second company setup (available as future add-on)

---

## Future Enhancements

These items are **outside the current scope** but can be added later:

1. **Second Company Instance** (50% discount available)
   - Replicate workflows for second 3A Lighting entity
   - Share codebase and core integrations
   - Estimated cost: 50% of implementation and recurring fees

2. **Advanced Reporting & Analytics**
   - Quote-to-close conversion reports
   - Landed cost analysis and trending
   - Supplier performance metrics
   - Customer payment tracking

3. **Integration Expansions**
   - Trello board sync for project tracking
   - Monday.com workflow integration
   - Gmail forwarding automation
   - Accounting software integration (Xero, QuickBooks)

4. **Supplier Portal**
   - Self-service PO management for suppliers
   - Delivery tracking and shipment notifications
   - Payment status visibility

5. **Customer Portal**
   - Quote tracking and acceptance for customers
   - Invoice and payment history
   - Repeat order functionality

---

## Pricing Summary

### One-off Development Costs

| Item | Description | Cost |
|------|-------------|------|
| 1 | Discovery and solution design | $1,600 |
| 2 | Classic MyDesk rebrand and access configuration | $1,800 |
| 3 | Supplier/customer workflow build | $3,200 |
| 4 | Quote to PI to PO, and landed cost logic | $3,800 |
| 5 | Testing, UAT, deployment, and documentation | $2,400 |
| **Total** | | **$12,800** |

### Ongoing Recurring Costs (Monthly)

| Item | Includes | Cost |
|------|----------|------|
| Hosting / Platform | Server, storage, backups, environment management | $180 |
| Maintenance & Support | Minor fixes, monitoring, business-hours support | $220 |
| Licensing | One named user for Khim | $95 |
| **Total Monthly** | | **$495** |

**Annual Cost:** $5,940 (or $5,346 with 10% annual prepayment discount)

### Payment Terms

- 50% of one-off development fee due on acceptance
- 50% due on final UAT sign-off
- Monthly recurring fees billed in advance
- Annual/6-month prepayment options available with discounts

---

## Contact & Support

**Project Manager:** Peter Bardenhagen  
**Email:** peter@bardenhagen.xyz  
**Support Hours:** Business hours (Mon-Fri, 9AM-5PM AEST)

For questions or changes to this plan, contact the project manager for discussion before proceeding.

---

**Document Version:** 1.0  
**Last Updated:** 07 August 2026  
**Status:** Ready for Approval
