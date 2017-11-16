-- *********************************************************************
-- Update Database Script
-- *********************************************************************
-- Change Log: dbMaster.xml
-- Ran at: 10/6/17 6:21 PM
-- Against: admin@jdbc:empty:mysql
-- Liquibase version: 2.0.1
-- *********************************************************************

-- Create Database Lock Table
CREATE TABLE `DATABASECHANGELOGLOCK` (`ID` INT NOT NULL, `LOCKED` TINYINT(1) NOT NULL, `LOCKGRANTED` DATETIME, `LOCKEDBY` VARCHAR(255), CONSTRAINT `PK_DATABASECHANGELOGLOCK` PRIMARY KEY (`ID`));

INSERT INTO `DATABASECHANGELOGLOCK` (`ID`, `LOCKED`) VALUES (1, 0);

-- Lock Database
-- Create Database Change Log Table
CREATE TABLE `DATABASECHANGELOG` (`ID` VARCHAR(63) NOT NULL, `AUTHOR` VARCHAR(63) NOT NULL, `FILENAME` VARCHAR(200) NOT NULL, `DATEEXECUTED` DATETIME NOT NULL, `ORDEREXECUTED` INT NOT NULL, `EXECTYPE` VARCHAR(10) NOT NULL, `MD5SUM` VARCHAR(35), `DESCRIPTION` VARCHAR(255), `COMMENTS` VARCHAR(255), `TAG` VARCHAR(255), `LIQUIBASE` VARCHAR(20), CONSTRAINT `PK_DATABASECHANGELOG` PRIMARY KEY (`ID`, `AUTHOR`, `FILENAME`));

-- Changeset dbF360_Init.xml::f360_init_mysql_1::hp::(Checksum: 3:ad411db2b7798053aaa268241f410971)
SET collation_connection = @@collation_database;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Custom SQL', 'EXECUTED', 'dbF360_Init.xml', 'f360_init_mysql_1', '2.0.1', '3:ad411db2b7798053aaa268241f410971', 1);

-- Changeset dbF360Db2_2.5.0.xml::f360Db2_2.5.0::hp::(Checksum: 3:49eb2b41fc30ea2613ab387c7aa12802)
INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Custom SQL (x3)', 'MARK_RAN', 'dbF360Db2_2.5.0.xml', 'f360Db2_2.5.0', '2.0.1', '3:49eb2b41fc30ea2613ab387c7aa12802', 2);

-- Changeset dbF360Mysql_2.5.0.xml::f360Mysql_2.5.0::hp::(Checksum: 3:e2de5d8bc5af642a8ec52399ab9168ed)
CREATE TABLE activity(
    id                            INT              AUTO_INCREMENT,
    name                          VARCHAR(255),
    description                   VARCHAR(2000),
    activityType                  VARCHAR(20),
    guid                          VARCHAR(255)     NOT NULL,
    objectVersion                 INT,
    publishVersion                INT,
    defaultWorkOwnerPersona_id    INT,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE activity_persona(
    activity_id    INT    NOT NULL,
    persona_id     INT    NOT NULL,
    PRIMARY KEY (activity_id, persona_id)
)ENGINE=INNODB;

CREATE TABLE activitycomment(
    activityInstance_id    INT              NOT NULL,
    commentTime            DATETIME         NOT NULL,
    userName               VARCHAR(255),
    commentText            VARCHAR(4000),
    commentType            VARCHAR(20),
    PRIMARY KEY (activityInstance_id, commentTime)
)ENGINE=INNODB;

CREATE TABLE activityinstance(
    id                        INT              AUTO_INCREMENT,
    projectVersion_id         INT              NOT NULL,
    activity_id               INT,
    name                      VARCHAR(255),
    description               VARCHAR(2000),
    activityType              VARCHAR(20),
    signOffState              VARCHAR(20),
    signOffDate               DATETIME,
    objectVersion             INT,
    seqNumber                 INT,
    requirementInstance_id    INT,
    savedEvidence_id          INT,
    workOwner                 VARCHAR(255),
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE activitysignoff(
    activityInstance_id    INT             NOT NULL,
    persona_id             INT             NOT NULL,
    signOffState           VARCHAR(20)     NOT NULL,
    signOffDate            DATETIME,
    signOffUser            VARCHAR(255),
    PRIMARY KEY (activityInstance_id, persona_id)
)ENGINE=INNODB;

CREATE TABLE agentcredential(
    id                   INT             AUTO_INCREMENT,
    token                VARCHAR(255),
    action               VARCHAR(255),
    remainingAttempts    INT,
    credential           BLOB,
    userName             VARCHAR(255),
    creationIp           VARCHAR(255),
    creationDate         DATETIME,
    terminalDate         DATETIME,
    sessionId            VARCHAR(255),
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE alert(
    id                     INT              AUTO_INCREMENT,
    name                   VARCHAR(255),
    description            VARCHAR(2000),
    monitoredEntityType    VARCHAR(20),
    monitoredInstanceId    INT,
    startDate              DATETIME,
    endDate                DATETIME,
    additionalParams       VARCHAR(255),
    createdBy              VARCHAR(255),
    creationDate           DATETIME,
    objectVersion          INT,
    reminderPeriod         INT,
    enabled                CHAR(1)          DEFAULT 'Y' NOT NULL,
    alertAllChildren       CHAR(1)          DEFAULT 'N',
    alertStakeholders      CHAR(1)          DEFAULT 'N',
    monitorAllApps         CHAR(1)          DEFAULT 'N',
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE alert_role(
    alert_id    INT    NOT NULL,
    pt_id       INT    NOT NULL,
    PRIMARY KEY (alert_id, pt_id)
)ENGINE=INNODB;

CREATE TABLE alerthistory(
    id                     INT             AUTO_INCREMENT,
    alert_id               INT             NOT NULL,
    userName               VARCHAR(255),
    triggeredDate          DATETIME,
    active                 CHAR(1),
    monitoredEntityType    VARCHAR(20),
    monitoredInstanceId    INT,
    monitoredEntityName    VARCHAR(255),
    alertStartDate         DATETIME,
    projectVersion_id      INT,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE alerttrigger(
    alert_id           INT            NOT NULL,
    monitoredColumn    VARCHAR(80)    NOT NULL,
    triggeredValue     VARCHAR(80)    NOT NULL,
    PRIMARY KEY (alert_id, monitoredColumn, triggeredValue)
)ENGINE=INNODB;

CREATE TABLE analysisblob(
    projectVersion_id    INT            NOT NULL,
    issueInstanceId      VARCHAR(80)    NOT NULL,
    engineType           VARCHAR(20)    NOT NULL,
    analysisTrace        MEDIUMBLOB,
    PRIMARY KEY (projectVersion_id, issueInstanceId, engineType)
)ENGINE=INNODB;

CREATE TABLE applicationassignmentrule(
    id                       INT             AUTO_INCREMENT,
    context                  VARCHAR(512),
    objectVersion            INT,
    seqNumber                INT,
    runtimeApplication_id    INT             NOT NULL,
    name                     VARCHAR(255),
    description              TEXT,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE applicationassignmentrule_host(
    applicationAssignmentRule_id    INT    NOT NULL,
    host_id                         INT    NOT NULL,
    PRIMARY KEY (applicationAssignmentRule_id, host_id)
)ENGINE=INNODB;

CREATE TABLE applicationentity(
    id               INT            AUTO_INCREMENT,
    objectVersion    INT,
    appEntityType    VARCHAR(20),
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE artifact(
    id                   INT              AUTO_INCREMENT,
    projectVersion_id    INT              NOT NULL,
    documentInfo_id      INT              NOT NULL,
    artifactType         VARCHAR(20),
    status               VARCHAR(20),
    messages             VARCHAR(2000),
    allowDelete          CHAR(1)          DEFAULT 'Y',
    srcArtifact_id       INT,
    purged               CHAR(1)          DEFAULT 'N',
    auditUpdated         CHAR(1)          DEFAULT 'N',
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE attr(
    id               INT              AUTO_INCREMENT,
    guid             VARCHAR(255)     NOT NULL,
    attrName         VARCHAR(80)      NOT NULL,
    attrType         VARCHAR(20)      NOT NULL,
    description      VARCHAR(2000),
    extensible       CHAR(1),
    masterAttr       CHAR(1)          DEFAULT 'N',
    defaultValue     INT,
    objectVersion    INT,
    hidden           CHAR(1)          DEFAULT 'N',
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE attrlookup(
    attr_id        INT             NOT NULL,
    lookupIndex    INT             NOT NULL,
    lookupValue    VARCHAR(255),
    attrGuid       VARCHAR(255),
    hidden         CHAR(1)         DEFAULT 'N',
    seqNumber      INT,
    PRIMARY KEY (attr_id, lookupIndex)
)ENGINE=INNODB;

CREATE TABLE auditcomment(
    issue_id       INT              NOT NULL,
    seqNumber      INT              NOT NULL,
    auditTime      BIGINT,
    commentText    VARCHAR(2000),
    userName       VARCHAR(255),
    PRIMARY KEY (issue_id, seqNumber)
)ENGINE=INNODB;

CREATE TABLE audithistory(
    issue_id             INT             NOT NULL,
    seqNumber            INT             NOT NULL,
    attrGuid             VARCHAR(255),
    auditTime            BIGINT,
    oldValue             INT,
    newValue             INT,
    userName             VARCHAR(255),
    conflict             CHAR(1)         DEFAULT 'N',
    projectVersion_id    INT             NOT NULL,
    PRIMARY KEY (issue_id, seqNumber)
)ENGINE=INNODB;

CREATE TABLE auditvalue(
    issue_id             INT            NOT NULL,
    attrGuid             VARCHAR(80)    NOT NULL,
    attrValue            INT,
    projectVersion_id    INT            NOT NULL,
    PRIMARY KEY (issue_id, attrGuid)
)ENGINE=INNODB;

CREATE TABLE consoleeventhandler(
    id                              INT             AUTO_INCREMENT,
    name                            VARCHAR(255)    NOT NULL,
    objectVersion                   INT             NOT NULL,
    description                     TEXT,
    eventHandlerType                VARCHAR(20),
    matchConditionsXml              TEXT,
    additionalMatchConditionsXml    TEXT,
    enabled                         CHAR(1),
    runtimeConfiguration_id         INT             NOT NULL,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE controller(
    id                        INT        AUTO_INCREMENT,
    port                      INT,
    allowNewClients           CHAR(1)    DEFAULT 'N',
    strictCertCheck           CHAR(1)    DEFAULT 'N',
    controllerKeyKeeper_id    INT        NOT NULL,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE controllerkeykeeper(
    id           INT            AUTO_INCREMENT,
    keystore     LONGBLOB,
    integrity    VARCHAR(20),
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE datablob(
    id      INT         AUTO_INCREMENT,
    data    LONGBLOB,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE documentactivity(
    id                INT    NOT NULL,
    documentDef_id    INT    NOT NULL,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE documentai(
    id                     INT    NOT NULL,
    documentDef_id         INT    NOT NULL,
    documentArtifact_id    INT,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE documentartifact(
    id                   INT              AUTO_INCREMENT,
    name                 VARCHAR(255),
    description          VARCHAR(2000),
    projectVersion_id    INT              NOT NULL,
    documentInfo_id      INT              NOT NULL,
    status               VARCHAR(20),
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE documentartifact_def(
    documentArtifact_id    INT    NOT NULL,
    documentDef_id         INT    NOT NULL,
    PRIMARY KEY (documentArtifact_id, documentDef_id)
)ENGINE=INNODB;

CREATE TABLE documentdef(
    id                 INT              AUTO_INCREMENT,
    guid               VARCHAR(255)     NOT NULL,
    name               VARCHAR(255),
    description        VARCHAR(2000),
    templateInfo_id    INT,
    objectVersion      INT,
    publishVersion     INT,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE documentdefinstance(
    activityInstance_id    INT              NOT NULL,
    name                   VARCHAR(255),
    description            VARCHAR(2000),
    documentDef_id         INT              NOT NULL,
    templateInfo_id        INT,
    PRIMARY KEY (activityInstance_id)
)ENGINE=INNODB;

CREATE TABLE documentinfo(
    id                  INT              AUTO_INCREMENT,
    documentType        INT,
    originalFileName    VARCHAR(1999),
    fileName            VARCHAR(255),
    fileURL             VARCHAR(1999),
    versionNumber       INT,
    uploadDate          DATETIME,
    uploadIP            VARCHAR(255),
    fileSize            BIGINT,
    userName            VARCHAR(255),
    fileBlob_id         INT,
    objectVersion       INT,
    externalFlag        CHAR(1)          DEFAULT 'N',
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE dynamicassessment(
    id                   INT             AUTO_INCREMENT,
    projectVersion_id    INT             NOT NULL,
    artifactId           INT,
    siteUrl              VARCHAR(255),
    siteScanStatus       VARCHAR(255),
    creationDate         DATETIME,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE entitytype(
    id            INT             NOT NULL,
    entityName    VARCHAR(255),
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE eventlogentry(
    id                   INT              AUTO_INCREMENT,
    eventType            VARCHAR(255),
    userName             VARCHAR(255),
    eventDate            DATETIME,
    detailedNote         VARCHAR(4000),
    entity_id            INT,
    projectVersion_id    INT,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE f360global(
    id               INT             AUTO_INCREMENT,
    schemaVersion    VARCHAR(255)    NOT NULL,
    publicKey        BLOB,
    privateKey       BLOB,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE federation(
    id                         INT              AUTO_INCREMENT,
    federationName             VARCHAR(255),
    description                VARCHAR(2000),
    defaultFederation          CHAR(1),
    objectVersion              INT,
    runtimeConfiguration_id    INT              NOT NULL,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE filterset(
    id                   INT              AUTO_INCREMENT,
    projectVersion_id    INT,
    title                VARCHAR(80),
    description          VARCHAR(2000),
    guid                 VARCHAR(255),
    disableEdit          CHAR(1)          DEFAULT 'N',
    enabled              CHAR(1)          DEFAULT 'Y',
    filterSetType        VARCHAR(20),
    defaultFolder_id     INT,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE finding(
    projectVersion_id    INT              NOT NULL,
    guid                 VARCHAR(255)     NOT NULL,
    name                 VARCHAR(255),
    description          VARCHAR(2000),
    findingType          VARCHAR(80),
    PRIMARY KEY (projectVersion_id, guid)
)ENGINE=INNODB;

CREATE TABLE folder(
    id                   INT              AUTO_INCREMENT,
    projectVersion_id    INT              NOT NULL,
    name                 VARCHAR(80),
    description          VARCHAR(2000),
    guid                 VARCHAR(255),
    color                VARCHAR(20),
    editable             CHAR(1),
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE foldercountcache(
    projectVersion_id    INT        NOT NULL,
    filterSet_id         INT        NOT NULL,
    folder_id            INT        NOT NULL,
    hidden               CHAR(1)    NOT NULL,
    removed              CHAR(1)    NOT NULL,
    suppressed           CHAR(1)    NOT NULL,
    issueCount           INT,
    PRIMARY KEY (projectVersion_id, filterSet_id, folder_id, hidden, removed, suppressed)
)ENGINE=INNODB;

CREATE TABLE fortifyuser(
    id                       INT             NOT NULL,
    userName                 VARCHAR(255)    NOT NULL,
    password                 VARCHAR(255),
    requirePasswordChange    CHAR(1)         NOT NULL,
    lastPasswordChange       DATETIME,
    passwordNeverExpire      CHAR(1)         NOT NULL,
    failedLoginAttempts      INT             NOT NULL,
    dateFrozen               DATETIME,
    firstName                VARCHAR(255),
    lastName                 VARCHAR(255),
    email                    VARCHAR(255),
    remoteKey                VARCHAR(255),
    suspended                CHAR(1)         NOT NULL,
    secPass                  VARCHAR(255),
    salt                     VARCHAR(255),
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE fpr_scan(
    scan_id        INT    NOT NULL,
    artifact_id    INT    NOT NULL,
    PRIMARY KEY (scan_id, artifact_id)
)ENGINE=INNODB;

CREATE TABLE host(
    id               INT              AUTO_INCREMENT,
    hostName         VARCHAR(255),
    address          VARCHAR(255),
    hostType         VARCHAR(20),
    statusCode       VARCHAR(20),
    statusMessage    VARCHAR(2000),
    os               VARCHAR(50),
    osVersion        VARCHAR(50),
    vm               VARCHAR(50),
    vmVersion        VARCHAR(50),
    lastComm         DATETIME,
    enabled          CHAR(1)          DEFAULT 'Y',
    hasConnected     CHAR(1)          DEFAULT 'N',
    logHasWarning    CHAR(1)          DEFAULT 'N',
    logHasError      CHAR(1)          DEFAULT 'N',
    connAttempts     INT,
    federation_id    INT              NOT NULL,
    controller_id    INT,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE hostlogmessage(
    id              INT              AUTO_INCREMENT,
    creationDate    DATETIME,
    logLevel        VARCHAR(20),
    msg             VARCHAR(4000),
    host_id         INT              NOT NULL,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE idgenerator(
    id             INT             AUTO_INCREMENT,
    sessionGuid    VARCHAR(255)    NOT NULL,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE iidmapping(
    migration_id      INT             NOT NULL,
    fromInstanceId    VARCHAR(255)    NOT NULL,
    toInstanceId      VARCHAR(255)    NOT NULL,
    seqNumber         INT,
    PRIMARY KEY (migration_id, fromInstanceId, toInstanceId)
)ENGINE=INNODB;

CREATE TABLE iidmigration(
    id                   INT         AUTO_INCREMENT,
    artifact_id          INT,
    processingDate       DATETIME,
    projectVersion_id    INT         NOT NULL,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE issue(
    id                     INT              AUTO_INCREMENT,
    remediationConstant    FLOAT(8, 2),
    projectVersion_id      INT              NOT NULL,
    issueInstanceId        VARCHAR(80)      NOT NULL,
    fileName               VARCHAR(500),
    shortFileName          VARCHAR(255),
    severity               FLOAT(8, 2),
    ruleGuid               VARCHAR(120),
    confidence             FLOAT(8, 2),
    kingdom                VARCHAR(80),
    issueType              VARCHAR(120),
    issueSubtype           VARCHAR(180),
    analyzer               VARCHAR(80),
    lineNumber             INT,
    taintFlag              VARCHAR(255),
    packageName            VARCHAR(255),
    functionName           VARCHAR(1024),
    className              VARCHAR(255),
    issueAbstract          TEXT,
    friority               VARCHAR(20),
    engineType             VARCHAR(20),
    scanStatus             VARCHAR(20),
    audienceSet            VARCHAR(100),
    lastScan_id            INT,
    replaceStore           BLOB,
    snippetId              VARCHAR(512),
    url                    VARCHAR(1000),
    category               VARCHAR(300),
    source                 VARCHAR(255),
    sourceContext          VARCHAR(1000),
    sourceFile             VARCHAR(255),
    sink                   VARCHAR(1000),
    sinkContext            VARCHAR(1000),
    userName               VARCHAR(255),
    owasp2004              VARCHAR(120),
    owasp2007              VARCHAR(120),
    cwe                    VARCHAR(120),
    objectVersion          INT,
    revision               INT              DEFAULT 0,
    audited                CHAR(1)          DEFAULT 'N',
    auditedTime            DATETIME,
    suppressed             CHAR(1)          DEFAULT 'N',
    issueStatus            VARCHAR(20)      DEFAULT 'Unreviewed',
    issueState             VARCHAR(20)      DEFAULT 'Open Issue',
    findingGuid            VARCHAR(500),
    dynamicConfidence      INT              DEFAULT 0,
    hidden                 CHAR(1)          DEFAULT 'N',
    likelihood             FLOAT(8, 2),
    impact                 FLOAT(8, 2),
    accuracy               FLOAT(8, 2),
    sans25                 VARCHAR(120),
    wasc                   VARCHAR(120),
    stig                   VARCHAR(120),
    pci11                  VARCHAR(120),
    pci12                  VARCHAR(120),
    rtaCovered             VARCHAR(120),
    probability            FLOAT(8, 2),
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE issuecache(
    filterSet_id         INT             NOT NULL,
    issue_id             INT             NOT NULL,
    projectVersion_id    INT,
    folder_id            INT,
    hidden               CHAR(1)         DEFAULT 'N',
    issueInstanceId      VARCHAR(255),
    PRIMARY KEY (filterSet_id, issue_id)
)ENGINE=INNODB;

CREATE TABLE ldapentity(
    id        INT             NOT NULL,
    ldapDn    VARCHAR(255),
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE measurement(
    id                 INT              AUTO_INCREMENT,
    name               VARCHAR(255),
    description        VARCHAR(2000),
    equation           VARCHAR(1000),
    guid               VARCHAR(255)     NOT NULL,
    valueFormat        VARCHAR(255),
    measurementType    VARCHAR(20),
    objectVersion      INT,
    publishVersion     INT,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE measurement_variable(
    measurement_id    INT    NOT NULL,
    variable_id       INT    NOT NULL,
    PRIMARY KEY (measurement_id, variable_id)
)ENGINE=INNODB;

CREATE TABLE measurementhistory(
    id                  INT            AUTO_INCREMENT,
    measurement_id      INT            NOT NULL,
    creationTime        DATETIME,
    measurementValue    FLOAT(8, 2),
    snapshot_id         INT            NOT NULL,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE measurementinstance(
    activityInstance_id       INT              NOT NULL,
    measurement_id            INT              NOT NULL,
    measurementName           VARCHAR(255),
    measurementDescription    VARCHAR(2000),
    equation                  VARCHAR(1000),
    measurementValue          FLOAT(8, 2),
    valueFormat               VARCHAR(255),
    PRIMARY KEY (activityInstance_id)
)ENGINE=INNODB;

CREATE TABLE metadatarule(
    id             INT              AUTO_INCREMENT,
    name           VARCHAR(255),
    description    VARCHAR(2000),
    ruleType       VARCHAR(20),
    conditions     TEXT,
    seqNumber      INT,
    guid           VARCHAR(255)     NOT NULL,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE metadef(
    id                 INT             AUTO_INCREMENT,
    parent_id          INT,
    metaType           VARCHAR(255),
    seqNumber          INT,
    required           CHAR(1)         DEFAULT 'N',
    hidden             CHAR(1)         DEFAULT 'N',
    booleanDefault     CHAR(1)         DEFAULT 'N',
    guid               VARCHAR(255)    NOT NULL,
    parentOption_id    INT,
    category           VARCHAR(20),
    appEntityType      VARCHAR(80),
    objectVersion      INT,
    publishVersion     INT,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE metadef_t(
    metaDef_id     INT              NOT NULL,
    lang           VARCHAR(10)      NOT NULL,
    name           VARCHAR(255),
    description    VARCHAR(2000),
    help           VARCHAR(2000),
    PRIMARY KEY (metaDef_id, lang)
)ENGINE=INNODB;

CREATE TABLE metaoption(
    id                  INT             AUTO_INCREMENT,
    optionIndex         INT,
    metaDef_id          INT,
    defaultSelection    CHAR(1)         DEFAULT 'N',
    hidden              CHAR(1)         DEFAULT 'N',
    guid                VARCHAR(255),
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE metaoption_t(
    metaOption_id    INT              NOT NULL,
    lang             VARCHAR(255)     NOT NULL,
    name             VARCHAR(255),
    description      VARCHAR(2000),
    help             VARCHAR(2000),
    PRIMARY KEY (metaOption_id, lang)
)ENGINE=INNODB;

CREATE TABLE metavalue(
    id                   INT              AUTO_INCREMENT,
    metaDef_id           INT              NOT NULL,
    textValue            VARCHAR(2000),
    booleanValue         CHAR(1),
    objectVersion        INT,
    projectVersion_id    INT              NOT NULL,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE metavalueselection(
    metaValue_id     INT    NOT NULL,
    metaOption_id    INT    NOT NULL,
    PRIMARY KEY (metaValue_id, metaOption_id)
)ENGINE=INNODB;

CREATE TABLE payloadartifact(
    id                         INT              AUTO_INCREMENT,
    projectVersion_id          INT              NOT NULL,
    analysisDoc_id             INT,
    dependencyDoc_id           INT,
    sourceDoc_id               INT,
    status                     VARCHAR(20),
    messages                   VARCHAR(2000),
    additionalInput            MEDIUMBLOB,
    defaultAnalyzeCount        INT,
    jobId                      INT,
    totalAnalysisFilesCount    INT,
    totalSourceFilesCount      INT,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE payloadentry(
    id             INT              AUTO_INCREMENT,
    artifact_id    INT              NOT NULL,
    filePath       VARCHAR(2000),
    fileName       VARCHAR(255),
    fileType       VARCHAR(20),
    fileSize       INT,
    selected       CHAR(1)          DEFAULT 'N',
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE payloadmessage(
    id              INT            AUTO_INCREMENT,
    artifact_id     INT            NOT NULL,
    messageType     VARCHAR(20),
    messageCode     INT,
    extraMessage    TEXT,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE permission(
    id               INT             AUTO_INCREMENT,
    name             VARCHAR(255)    NOT NULL,
    type             INT             NOT NULL,
    entityType_id    INT,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE permissioninstance(
    id                  INT    AUTO_INCREMENT,
    entityInstanceId    INT,
    permission_id       INT    NOT NULL,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE permissiontemplate(
    id           INT             AUTO_INCREMENT,
    name         VARCHAR(255)    NOT NULL,
    builtin      CHAR(1)         NOT NULL,
    isDefault    CHAR(1)         NOT NULL,
    userOnly     CHAR(1)         NOT NULL,
    sortOrder    INT             NOT NULL,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE persona(
    id                INT             AUTO_INCREMENT,
    guid              VARCHAR(255),
    name              VARCHAR(255),
    description       TEXT,
    objectVersion     INT,
    publishVersion    INT,
    superuser         CHAR(1)         DEFAULT 'N',
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE personaassignment(
    projectVersion_id    INT             NOT NULL,
    persona_id           INT             NOT NULL,
    userName             VARCHAR(255),
    PRIMARY KEY (projectVersion_id, persona_id)
)ENGINE=INNODB;

CREATE TABLE pod(
    id                 INT             AUTO_INCREMENT,
    podType            VARCHAR(255),
    podName            VARCHAR(255),
    multipleEnabled    CHAR(1)         DEFAULT 'N',
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE pref_pod(
    id           INT              AUTO_INCREMENT,
    pref_id      INT,
    pod_id       INT              NOT NULL,
    minimized    CHAR(1)          DEFAULT 'N',
    maximized    CHAR(1)          DEFAULT 'N',
    selection    VARCHAR(4000),
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE pref_projectversion(
    pref_id              INT    NOT NULL,
    projectVersion_id    INT    NOT NULL,
    PRIMARY KEY (pref_id, projectVersion_id)
)ENGINE=INNODB;

CREATE TABLE project(
    id              INT              AUTO_INCREMENT,
    name            VARCHAR(255),
    description     VARCHAR(2000),
    creationDate    DATETIME,
    createdBy       VARCHAR(255),
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE projectstateactivity(
    id                INT            NOT NULL,
    compareType       VARCHAR(20),
    compareValue      FLOAT(8, 2),
    measurement_id    INT            NOT NULL,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE projectstateai(
    id                INT            NOT NULL,
    compareType       VARCHAR(20),
    compareValue      FLOAT(8, 2),
    measurement_id    INT            NOT NULL,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE projecttemplate(
    id                 INT              AUTO_INCREMENT,
    documentInfo_id    INT              NOT NULL,
    name               VARCHAR(255),
    description        VARCHAR(2000),
    guid               VARCHAR(255)     NOT NULL,
    objectVersion      INT,
    publishVersion     INT,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE projecttemplate_attr(
    projectTemplate_id    INT             NOT NULL,
    attrGuid              VARCHAR(255)    NOT NULL,
    seqNumber             INT,
    PRIMARY KEY (projectTemplate_id, attrGuid)
)ENGINE=INNODB;

CREATE TABLE projectversion(
    id                      INT              NOT NULL,
    name                    VARCHAR(255)     NOT NULL,
    description             VARCHAR(1999),
    versionTag              VARCHAR(255),
    active                  CHAR(1)          DEFAULT 'N',
    modifiedAfterCommit     CHAR(1),
    creationDate            DATETIME,
    createdBy               VARCHAR(255),
    objectVersion           INT,
    projectTemplate_id      INT,
    project_id              INT,
    versionCommitted        CHAR(1)          DEFAULT 'N',
    versionMode             VARCHAR(20),
    locked                  CHAR(1)          DEFAULT 'N',
    auditAllowed            CHAR(1)          DEFAULT 'Y',
    staleProjectTemplate    CHAR(1)          DEFAULT 'N',
    loadProperties          VARCHAR(1999),
    currentFprBlob_id       INT,
    snapshotOutOfDate       CHAR(1)          DEFAULT 'N',
    assessmentState         VARCHAR(20),
    owner                   VARCHAR(255),
    serverVersion           FLOAT(8, 0),
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE projectversion_alert(
    alert_id             INT    NOT NULL,
    projectVersion_id    INT    NOT NULL,
    PRIMARY KEY (alert_id, projectVersion_id)
)ENGINE=INNODB;

CREATE TABLE projectversion_rule(
    projectVersion_id    INT             NOT NULL,
    rule_id              INT             NOT NULL,
    ruleGuid             VARCHAR(255),
    engineType           VARCHAR(20),
    PRIMARY KEY (projectVersion_id, rule_id)
)ENGINE=INNODB;

CREATE TABLE projectversiondependency(
    parentProjectVersion_id    INT    NOT NULL,
    childProjectVersion_id     INT    NOT NULL,
    PRIMARY KEY (parentProjectVersion_id, childProjectVersion_id)
)ENGINE=INNODB;

CREATE TABLE pt_permission(
    pt_id            INT    NOT NULL,
    permission_id    INT    NOT NULL,
    PRIMARY KEY (pt_id, permission_id)
)ENGINE=INNODB;

CREATE TABLE publishaction(
    publishedReport_id    INT             NOT NULL,
    procurerTenantId      VARCHAR(255)    NOT NULL,
    procurer_id           INT             NOT NULL,
    publishedBy           VARCHAR(255),
    publishDate           DATETIME,
    PRIMARY KEY (publishedReport_id, procurerTenantId)
)ENGINE=INNODB;

CREATE TABLE publishedreport(
    id                    INT              AUTO_INCREMENT,
    assessmentName        VARCHAR(255),
    vendorTenantId        VARCHAR(255)     NOT NULL,
    savedReport_id        VARCHAR(255),
    name                  VARCHAR(255),
    note                  VARCHAR(1999),
    format                VARCHAR(20),
    generatedBy           VARCHAR(255),
    generationDate        DATETIME,
    reportOutputDoc_id    INT              NOT NULL,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE report_projectversion(
    savedReport_id       INT    NOT NULL,
    projectVersion_id    INT    NOT NULL,
    PRIMARY KEY (savedReport_id, projectVersion_id)
)ENGINE=INNODB;

CREATE TABLE reportdefinition(
    id                 INT              AUTO_INCREMENT,
    name               VARCHAR(255)     NOT NULL,
    description        VARCHAR(2000),
    reportType         VARCHAR(20),
    renderingEngine    VARCHAR(20),
    crossApp           CHAR(1)          DEFAULT 'N',
    guid               VARCHAR(255),
    templateDoc_id     INT,
    objectVersion      INT,
    publishVersion     INT,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE reportparameter(
    id                     INT              AUTO_INCREMENT,
    paramName              VARCHAR(255)     NOT NULL,
    description            VARCHAR(2000),
    dataType               VARCHAR(20)      NOT NULL,
    entityType             VARCHAR(40),
    identifier             VARCHAR(80),
    reportDefinition_id    INT              NOT NULL,
    paramOrder             INT              NOT NULL,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE requirement(
    id                            INT              AUTO_INCREMENT,
    requirementTemplate_id        INT              NOT NULL,
    name                          VARCHAR(255),
    description                   VARCHAR(2000),
    tag                           VARCHAR(255),
    seqNumber                     INT,
    defaultWorkOwnerPersona_id    INT,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE requirement_activity(
    requirement_id    INT    NOT NULL,
    activity_id       INT    NOT NULL,
    seqNumber         INT,
    PRIMARY KEY (requirement_id, activity_id)
)ENGINE=INNODB;

CREATE TABLE requirement_persona(
    requirement_id    INT    NOT NULL,
    persona_id        INT    NOT NULL,
    PRIMARY KEY (requirement_id, persona_id)
)ENGINE=INNODB;

CREATE TABLE requirementcomment(
    requirementInstance_id    INT              NOT NULL,
    commentTime               DATETIME         NOT NULL,
    commentText               VARCHAR(4000),
    userName                  VARCHAR(255),
    commentType               VARCHAR(20),
    PRIMARY KEY (requirementInstance_id, commentTime)
)ENGINE=INNODB;

CREATE TABLE requirementinstance(
    id                   INT              AUTO_INCREMENT,
    projectVersion_id    INT              NOT NULL,
    requirement_id       INT,
    name                 VARCHAR(255),
    description          VARCHAR(2000),
    tag                  VARCHAR(255),
    signOffState         VARCHAR(20),
    signOffDate          DATETIME,
    objectVersion        INT,
    seqNumber            INT,
    workOwner            VARCHAR(255),
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE requirementsignoff(
    requirementInstance_id    INT             NOT NULL,
    persona_id                INT             NOT NULL,
    signOffState              VARCHAR(20)     NOT NULL,
    signOffDate               DATETIME,
    signOffUser               VARCHAR(255),
    PRIMARY KEY (requirementInstance_id, persona_id)
)ENGINE=INNODB;

CREATE TABLE requirementtemplate(
    id                            INT              AUTO_INCREMENT,
    name                          VARCHAR(255),
    description                   VARCHAR(2000),
    guid                          VARCHAR(255)     NOT NULL,
    projectTemplate_id            INT,
    hidden                        CHAR(1)          DEFAULT 'N',
    defaultTemplate               CHAR(1)          DEFAULT 'N',
    templateMode                  VARCHAR(20),
    objectVersion                 INT,
    publishVersion                INT,
    defaultWorkOwnerPersona_id    INT,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE requirementtemplate_persona(
    requirementTemplate_id    INT    NOT NULL,
    persona_id                INT    NOT NULL,
    PRIMARY KEY (requirementTemplate_id, persona_id)
)ENGINE=INNODB;

CREATE TABLE requirementtemplatecomment(
    projectVersion_id    INT              NOT NULL,
    commentTime          DATETIME         NOT NULL,
    commentText          VARCHAR(4000),
    userName             VARCHAR(255),
    commentType          VARCHAR(20),
    PRIMARY KEY (projectVersion_id, commentTime)
)ENGINE=INNODB;

CREATE TABLE requirementtemplateinstance(
    projectVersion_id         INT              NOT NULL,
    requirementTemplate_id    INT              NOT NULL,
    override                  CHAR(1)          DEFAULT 'N',
    metadataRule_id           INT,
    signOffState              VARCHAR(20),
    signOffDate               DATETIME,
    name                      VARCHAR(255),
    description               VARCHAR(2000),
    guid                      VARCHAR(255),
    objectVersion             INT,
    savedEvidence_id          INT,
    workOwner                 VARCHAR(255),
    serverVersion             FLOAT(8, 0),
    PRIMARY KEY (projectVersion_id)
)ENGINE=INNODB;

CREATE TABLE requirementtemplatesignoff(
    projectVersion_id    INT             NOT NULL,
    persona_id           INT             NOT NULL,
    signOffState         VARCHAR(20)     NOT NULL,
    signOffDate          DATETIME,
    signOffUser          VARCHAR(255),
    PRIMARY KEY (projectVersion_id, persona_id)
)ENGINE=INNODB;

CREATE TABLE rtassignment(
    metadataRule_id           INT    NOT NULL,
    requirementTemplate_id    INT    NOT NULL,
    objectVersion             INT,
    publishVersion            INT,
    PRIMARY KEY (metadataRule_id, requirementTemplate_id)
)ENGINE=INNODB;

CREATE TABLE rule_t(
    id                   INT            NOT NULL,
    lang                 VARCHAR(10)    NOT NULL,
    rawDetail            TEXT,
    rawRecommendation    TEXT,
    rawRuleAbstract      TEXT,
    detail               TEXT,
    recommendation       TEXT,
    ruleAbstract         TEXT,
    PRIMARY KEY (id, lang)
)ENGINE=INNODB;

CREATE TABLE ruledescription(
    id             INT             AUTO_INCREMENT,
    guid           VARCHAR(255),
    rulepack_id    INT,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE rulepack(
    id                 INT              AUTO_INCREMENT,
    sku                VARCHAR(255),
    rulepackGuid       VARCHAR(255)     NOT NULL,
    name               VARCHAR(255)     NOT NULL,
    description        VARCHAR(1999),
    versionNumber      VARCHAR(255),
    progLanguage       VARCHAR(255),
    rulepackType       VARCHAR(20),
    objectVersion      INT,
    documentInfo_id    INT              NOT NULL,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE runtimealert(
    id                         INT             NOT NULL,
    runtimeEvent_id            INT             NOT NULL,
    eventHandlerName           VARCHAR(255),
    eventHandlerDescription    TEXT,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE runtimeapplication(
    id                    INT              NOT NULL,
    name                  VARCHAR(255)     NOT NULL,
    description           VARCHAR(2000),
    creationDate          DATETIME,
    createdBy             VARCHAR(255),
    objectVersion         INT,
    defaultApplication    CHAR(1),
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE runtimeconfig_rulepack(
    runtimeConfiguration_id    INT    NOT NULL,
    rulepack_id                INT    NOT NULL,
    seqNumber                  INT,
    PRIMARY KEY (runtimeConfiguration_id, rulepack_id)
)ENGINE=INNODB;

CREATE TABLE runtimeconfiguration(
    id                    INT              AUTO_INCREMENT,
    configGuid            VARCHAR(255),
    configName            VARCHAR(255),
    description           VARCHAR(2000),
    lastModification      DATETIME,
    objectVersion         INT,
    enabled               CHAR(1)          DEFAULT 'Y',
    protectModeEnabled    CHAR(1)          DEFAULT 'N',
    templateInfo_id       INT,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE runtimeevent(
    id                        INT              NOT NULL,
    category                  VARCHAR(512),
    ruleId                    VARCHAR(255),
    monitorId                 VARCHAR(255),
    exceptionStackChecksum    VARCHAR(255),
    eventStackChecksum        VARCHAR(255),
    eventType                 VARCHAR(120),
    creationDate              DATETIME,
    descriptionPath           VARCHAR(255),
    severity                  FLOAT(8, 0),
    accuracy                  FLOAT(8, 0),
    impact                    FLOAT(8, 0),
    impactBias                VARCHAR(120),
    audience                  VARCHAR(120),
    primaryAudience           VARCHAR(20),
    coveredRta                CHAR(1),
    coveredSca                CHAR(1),
    requestHeader             TEXT,
    requestIp                 VARCHAR(255),
    sessionId                 VARCHAR(255),
    requestUri                VARCHAR(2084),
    requestParameter          TEXT,
    authedUser                VARCHAR(255),
    cookie                    TEXT,
    referer                   VARCHAR(2084),
    userAgent                 VARCHAR(255),
    triggeredBy               TEXT,
    action                    VARCHAR(255),
    dispatch                  VARCHAR(255),
    kingdom                   VARCHAR(100),
    hourDate                  INT,
    isAttack                  CHAR(1)          DEFAULT 'N',
    isVulnerability           CHAR(1)          DEFAULT 'N',
    isAudit                   CHAR(1)          DEFAULT 'N',
    requestMethod             VARCHAR(20),
    likelihood                FLOAT(8, 0),
    priority                  VARCHAR(20),
    processed                 CHAR(1)          DEFAULT 'N',
    alerted                   CHAR(1)          DEFAULT 'N',
    probability               FLOAT(8, 0),
    requestScheme             VARCHAR(20),
    host_id                   INT              NOT NULL,
    runtimeApplication_id     INT              NOT NULL,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE runtimeeventarchive(
    id                        INT             AUTO_INCREMENT,
    startDate                 DATETIME,
    endDate                   DATETIME,
    runtimeApplication_id     INT,
    runtimeApplicationName    VARCHAR(255),
    notes                     TEXT,
    restored                  CHAR(1)         DEFAULT 'N',
    documentInfo_id           INT             NOT NULL,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE runtimeeventattr(
    runtimeEvent_id    INT             NOT NULL,
    attrName           VARCHAR(255)    NOT NULL,
    attrValue          MEDIUMTEXT,
    trusted            CHAR(1)         DEFAULT 'N',
    internal           CHAR(1)         DEFAULT 'N',
    PRIMARY KEY (runtimeEvent_id, attrName)
)ENGINE=INNODB;

CREATE TABLE runtimenamedattr(
    id                        INT             AUTO_INCREMENT,
    attrName                  VARCHAR(255),
    attrValue                 VARCHAR(255),
    runtimeNamedAttrSet_id    INT             NOT NULL,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE runtimenamedattrset(
    id                INT             AUTO_INCREMENT,
    rulepack_id       INT,
    attributeSetId    VARCHAR(255),
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE runtimesetting(
    id                         INT             AUTO_INCREMENT,
    objectVersion              INT,
    settingKey                 VARCHAR(255),
    name                       VARCHAR(255),
    content                    VARCHAR(255),
    description                TEXT,
    settingType                VARCHAR(20),
    systemDefined              CHAR(1),
    runtimeConfiguration_id    INT             NOT NULL,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE savedevidence(
    id                   INT            AUTO_INCREMENT,
    evidenceType         VARCHAR(20),
    creationDate         DATETIME,
    projectVersion_id    INT,
    evidenceBlob_id      INT,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE savedreport(
    id                     INT              AUTO_INCREMENT,
    name                   VARCHAR(255)     NOT NULL,
    note                   VARCHAR(1999),
    generationDate         DATETIME         NOT NULL,
    userName               VARCHAR(255),
    format                 VARCHAR(20),
    status                 VARCHAR(20),
    published              CHAR(1)          DEFAULT 'N',
    reportDefinition_id    INT              NOT NULL,
    reportOutputDoc_id     INT,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE scan(
    id                   INT              AUTO_INCREMENT,
    isCompleted          CHAR(1)          DEFAULT 'N',
    updateDate           DATETIME,
    certification        VARCHAR(20),
    auditUpdated         CHAR(1)          DEFAULT 'N',
    scaLabel             VARCHAR(2000),
    scaBuildId           VARCHAR(255),
    hostName             VARCHAR(255),
    startDate            BIGINT,
    elapsedTime          INT,
    hasIssue             CHAR(1)          DEFAULT 'Y',
    updated              CHAR(1)          DEFAULT 'Y',
    scaFiles             INT,
    executableLoc        INT,
    totalLoc             INT,
    engineType           VARCHAR(20)      NOT NULL,
    engineVersion        VARCHAR(80),
    guid                 VARCHAR(255),
    projectLabel         VARCHAR(255),
    versionLabel         VARCHAR(255),
    projectVersion_id    INT              NOT NULL,
    artifact_id          INT              NOT NULL,
    objectVersion        INT,
    migrated             VARCHAR(18)      DEFAULT 'N',
    serverVersion        FLOAT(8, 0),
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE scan_finding(
    scan_id              INT             NOT NULL,
    findingGuid          VARCHAR(255)    NOT NULL,
    severity             FLOAT(8, 2),
    remediationEffort    FLOAT(12, 2),
    PRIMARY KEY (scan_id, findingGuid)
)ENGINE=INNODB;

CREATE TABLE scan_issue(
    scan_id                INT              NOT NULL,
    issueInstanceId        VARCHAR(80)      NOT NULL,
    accuracy               FLOAT(8, 0),
    fileName               VARCHAR(500),
    shortFileName          VARCHAR(255),
    severity               FLOAT(8, 2),
    ruleGuid               VARCHAR(120),
    confidence             FLOAT(8, 2),
    kingdom                VARCHAR(80),
    issueType              VARCHAR(120),
    issueSubtype           VARCHAR(180),
    analyzer               VARCHAR(80),
    lineNumber             INT,
    taintFlag              VARCHAR(255),
    packageName            VARCHAR(255),
    functionName           VARCHAR(1024),
    className              VARCHAR(255),
    issueAbstract          TEXT,
    friority               VARCHAR(20),
    engineType             VARCHAR(20),
    audienceSet            VARCHAR(100),
    replaceStore           BLOB,
    snippetId              VARCHAR(512),
    url                    VARCHAR(1000),
    category               VARCHAR(300),
    source                 VARCHAR(255),
    sourceContext          VARCHAR(1000),
    sourceFile             VARCHAR(255),
    sink                   VARCHAR(1000),
    sinkContext            VARCHAR(1000),
    userName               VARCHAR(255),
    owasp2004              VARCHAR(120),
    owasp2007              VARCHAR(120),
    cwe                    VARCHAR(120),
    findingGuid            VARCHAR(500),
    remediationConstant    FLOAT(8, 2),
    likelihood             FLOAT(8, 0),
    impact                 FLOAT(8, 0),
    sans25                 VARCHAR(120),
    wasc                   VARCHAR(120),
    stig                   VARCHAR(120),
    pci11                  VARCHAR(120),
    pci12                  VARCHAR(120),
    rtaCovered             VARCHAR(120),
    probability            FLOAT(8, 0),
    PRIMARY KEY (scan_id, issueInstanceId)
)ENGINE=INNODB;

CREATE TABLE scan_rulepack(
    scan_id            INT             NOT NULL,
    rulepackGuid       VARCHAR(255)    NOT NULL,
    rulepackVersion    VARCHAR(255)    NOT NULL,
    rulepackName       VARCHAR(255),
    rulepackSku        VARCHAR(255),
    PRIMARY KEY (scan_id, rulepackGuid, rulepackVersion)
)ENGINE=INNODB;

CREATE TABLE sdlhistory(
    id              INT            AUTO_INCREMENT,
    creationTime    DATETIME,
    entityType      VARCHAR(20),
    stateType       VARCHAR(20),
    stateValue      VARCHAR(20),
    snapshot_id     INT            NOT NULL,
    entityCount     INT,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE securityentity(
    id               INT    AUTO_INCREMENT,
    entityTypeId     INT    NOT NULL,
    objectVersion    INT,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE seedhistory(
    id                  INT             AUTO_INCREMENT,
    bundleIdentifier    VARCHAR(255),
    bundleVersion       VARCHAR(255),
    seedDate            DATETIME,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE snapshot(
    id                   INT             AUTO_INCREMENT,
    startDate            DATETIME,
    finishDate           DATETIME,
    projectVersion_id    INT             NOT NULL,
    triggerType          VARCHAR(255),
    triggerEntityId      INT,
    auditBlob_id         INT,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE sourcefile(
    checksum    VARCHAR(255)    NOT NULL,
    fileBlob    LONGBLOB,
    PRIMARY KEY (checksum)
)ENGINE=INNODB;

CREATE TABLE sourcefilemap(
    projectVersion_id    INT             NOT NULL,
    filePath             VARCHAR(255)    NOT NULL,
    scan_id              INT             NOT NULL,
    crossRef             MEDIUMBLOB,
    checksum             VARCHAR(255),
    PRIMARY KEY (projectVersion_id, filePath, scan_id)
)ENGINE=INNODB;

CREATE TABLE stacktrace(
    checksum     VARCHAR(255)    NOT NULL,
    traceBody    TEXT,
    PRIMARY KEY (checksum)
)ENGINE=INNODB;

CREATE TABLE taskcomment(
    taskInstance_id    INT             NOT NULL,
    commentTime        DATETIME        NOT NULL,
    userName           VARCHAR(255),
    commentText        TEXT,
    commentType        VARCHAR(20),
    PRIMARY KEY (taskInstance_id, commentTime)
)ENGINE=INNODB;

CREATE TABLE taskinstance(
    id                     INT             AUTO_INCREMENT,
    name                   VARCHAR(255),
    description            TEXT,
    seqNumber              INT,
    objectVersion          INT,
    signOffState           VARCHAR(20)     NOT NULL,
    signOffDate            DATETIME,
    signOffUser            VARCHAR(255),
    workOwner              VARCHAR(255),
    projectVersion_id      INT             NOT NULL,
    activityInstance_id    INT,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE timelapse_event(
    eventLog_id            INT    NOT NULL,
    activityInstance_id    INT    NOT NULL,
    PRIMARY KEY (eventLog_id, activityInstance_id)
)ENGINE=INNODB;

CREATE TABLE timelapseactivity(
    id           INT            NOT NULL,
    eventType    VARCHAR(20),
    timeLapse    INT,
    unit         VARCHAR(20),
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE timelapseai(
    id                 INT            NOT NULL,
    eventType          VARCHAR(20),
    timeLapse          INT,
    unit               VARCHAR(20),
    lastEventLog_id    INT,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE user_permission(
    user_id          INT    NOT NULL,
    permission_id    INT    NOT NULL,
    pt_id            INT    NOT NULL,
    PRIMARY KEY (user_id, permission_id, pt_id)
)ENGINE=INNODB;

CREATE TABLE user_pi(
    user_id    INT    NOT NULL,
    pi_id      INT    NOT NULL,
    pt_id      INT    NOT NULL,
    PRIMARY KEY (user_id, pi_id, pt_id)
)ENGINE=INNODB;

CREATE TABLE user_pt(
    user_id    INT    NOT NULL,
    pt_id      INT    NOT NULL,
    PRIMARY KEY (user_id, pt_id)
)ENGINE=INNODB;

CREATE TABLE userpreference(
    id                        INT             AUTO_INCREMENT,
    userName                  VARCHAR(255),
    projectVersionListMode    VARCHAR(255),
    email                     VARCHAR(255),
    emailAlerts               CHAR(1)         DEFAULT 'Y',
    dateFormat                VARCHAR(20),
    timeFormat                VARCHAR(20),
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE variable(
    id                INT              AUTO_INCREMENT,
    guid              VARCHAR(255)     NOT NULL,
    name              VARCHAR(255),
    description       VARCHAR(2000),
    searchString      VARCHAR(2000),
    objectVersion     INT,
    publishVersion    INT,
    variableType      VARCHAR(20),
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE variablehistory(
    id               INT         AUTO_INCREMENT,
    creationTime     DATETIME,
    variableValue    INT,
    variable_id      INT         NOT NULL,
    snapshot_id      INT         NOT NULL,
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE variableinstance(
    variable_id      INT              NOT NULL,
    ai_id            INT              NOT NULL,
    name             VARCHAR(255),
    description      VARCHAR(2000),
    searchString     VARCHAR(2000),
    variableValue    INT,
    PRIMARY KEY (variable_id, ai_id)
)ENGINE=INNODB;

CREATE UNIQUE INDEX activity_guid_key ON activity(guid);

CREATE INDEX ai_proj ON activityinstance(projectVersion_id);

CREATE INDEX ai_ri ON activityinstance(requirementInstance_id);

CREATE INDEX ac_token ON agentcredential(token);

CREATE INDEX ac_username ON agentcredential(userName);

CREATE INDEX alert_proj ON alerthistory(projectVersion_id, userName);

CREATE INDEX appruleRA ON applicationassignmentrule(runtimeApplication_id);

CREATE INDEX artifact_proj ON artifact(projectVersion_id);

CREATE UNIQUE INDEX attr_altley ON attr(guid);

CREATE UNIQUE INDEX attr_lookup_altkey ON attrlookup(attrGuid, lookupIndex);

CREATE UNIQUE INDEX AuditCommentAltKey ON auditcomment(issue_id, auditTime);

CREATE UNIQUE INDEX AuditHistoryAltKey ON audithistory(issue_id, attrGuid, auditTime);

CREATE INDEX audithistory_altkey2 ON audithistory(projectVersion_id, attrGuid, auditTime);

CREATE INDEX auditValueSearch_altkey ON auditvalue(projectVersion_id, attrGuid, attrValue);

CREATE UNIQUE INDEX daName_altkey ON documentartifact(projectVersion_id, name);

CREATE UNIQUE INDEX activitydocumentguid ON documentdef(guid);

CREATE UNIQUE INDEX IDX_EMM_NAME ON entitytype(entityName);

CREATE INDEX el_proj_type ON eventlogentry(projectVersion_id, eventType);

CREATE UNIQUE INDEX filterset_altkey_1 ON filterset(projectVersion_id, guid);

CREATE UNIQUE INDEX folder_altkey ON folder(projectVersion_id, guid);

CREATE UNIQUE INDEX fortifyuseruk_1_1 ON fortifyuser(userName);

CREATE INDEX HOST_HN ON host(hostName);

CREATE INDEX HOST_FED ON host(federation_id);

CREATE INDEX HLM_HID ON hostlogmessage(host_id);

CREATE INDEX sessionGuid ON idgenerator(sessionGuid);

CREATE INDEX iidm_proj ON iidmigration(projectVersion_id);

CREATE UNIQUE INDEX Issue_Alt_Key ON issue(projectVersion_id, issueInstanceId);

CREATE UNIQUE INDEX IssueAltKeyWithEngineType ON issue(projectVersion_id, engineType, issueInstanceId);

CREATE UNIQUE INDEX IssueProjLastScanAltKey ON issue(projectVersion_id, lastScan_id, issueInstanceId);

CREATE INDEX IssueEngineStatusAltKey ON issue(projectVersion_id, scanStatus, engineType);

CREATE UNIQUE INDEX IssueCacheAltKey ON issuecache(projectVersion_id, filterSet_id, folder_id, issue_id);

CREATE INDEX viewIssueIndex ON issuecache(filterSet_id, hidden, folder_id);

CREATE UNIQUE INDEX measurement_guid_key ON measurement(guid);

CREATE INDEX mh_ss ON measurementhistory(snapshot_id, measurement_id);

CREATE UNIQUE INDEX metarule_guid_key ON metadatarule(guid);

CREATE UNIQUE INDEX metadef_guid_key ON metadef(guid);

CREATE INDEX mo_md ON metaoption(metaDef_id);

CREATE UNIQUE INDEX metainstance_altkey ON metavalue(projectVersion_id, metaDef_id);

CREATE UNIQUE INDEX UK_PERMISSION_NAME ON permission(name);

CREATE INDEX pi_p_e ON permissioninstance(permission_id, entityInstanceId);

CREATE UNIQUE INDEX UK_PT_NAME ON permissiontemplate(name);

CREATE UNIQUE INDEX PERSONA_GUID ON persona(guid);

CREATE INDEX pref_pod_alt ON pref_pod(pref_id, pod_id);

CREATE UNIQUE INDEX ProjNameUniqueKey ON project(name);

CREATE UNIQUE INDEX pt_guid_key ON projecttemplate(guid);

CREATE UNIQUE INDEX UK_APP_NAME ON projectversion(project_id, name);

CREATE UNIQUE INDEX pva_reverse ON projectversion_alert(projectVersion_id, alert_id);

CREATE INDEX pr_proj_guid ON projectversion_rule(projectVersion_id, ruleGuid);

CREATE INDEX pr_proj_engine ON projectversion_rule(projectVersion_id, engineType);

CREATE UNIQUE INDEX vender_sr ON publishedreport(vendorTenantId, savedReport_id);

CREATE UNIQUE INDEX UK_REPORT_NAME ON reportdefinition(name);

CREATE UNIQUE INDEX UK_REPORTP_NAME ON reportparameter(reportDefinition_id, paramName);

CREATE INDEX req_rt ON requirement(requirementTemplate_id);

CREATE INDEX ri_proj_req ON requirementinstance(projectVersion_id, requirement_id);

CREATE UNIQUE INDEX rt_guid_key ON requirementtemplate(guid);

CREATE INDEX rd_rp ON ruledescription(rulepack_id);

CREATE UNIQUE INDEX rp_guidver_key ON rulepack(rulepackGuid, versionNumber);

CREATE INDEX RUNTIMEALERT_REID ON runtimealert(runtimeEvent_id);

CREATE INDEX RE_RAID ON runtimeevent(runtimeApplication_id, creationDate);

CREATE INDEX RE_DATE ON runtimeevent(creationDate, runtimeApplication_id);

CREATE INDEX REA_RAID ON runtimeeventarchive(runtimeApplication_id);

CREATE INDEX RNA_RNASID ON runtimenamedattr(runtimeNamedAttrSet_id);

CREATE INDEX RNAS_ALTID ON runtimenamedattrset(attributeSetId);

CREATE INDEX scan_proj_date ON scan(projectVersion_id, engineType, updateDate);

CREATE INDEX scan_arti ON scan(artifact_id);

CREATE INDEX sh_ss ON sdlhistory(snapshot_id, entityType, stateType);

CREATE INDEX ss_proj_date ON snapshot(projectVersion_id, startDate);

CREATE INDEX ti_proj ON taskinstance(projectVersion_id);

CREATE INDEX ti_ai ON taskinstance(activityInstance_id);

CREATE UNIQUE INDEX UserPrefUserNameKey ON userpreference(userName);

CREATE UNIQUE INDEX variable_guid_key ON variable(guid);

CREATE INDEX vh_ss ON variablehistory(snapshot_id, variable_id);

ALTER TABLE activity_persona ADD CONSTRAINT RefActPersona 
    FOREIGN KEY (activity_id)
    REFERENCES activity(id) ON DELETE CASCADE;

ALTER TABLE activity_persona ADD CONSTRAINT RefPersonaActPersona 
    FOREIGN KEY (persona_id)
    REFERENCES persona(id) ON DELETE CASCADE;

ALTER TABLE activitycomment ADD CONSTRAINT RefAIActComment 
    FOREIGN KEY (activityInstance_id)
    REFERENCES activityinstance(id) ON DELETE CASCADE;

ALTER TABLE activityinstance ADD CONSTRAINT RefActAi 
    FOREIGN KEY (activity_id)
    REFERENCES activity(id);

ALTER TABLE activityinstance ADD CONSTRAINT RefRIAI 
    FOREIGN KEY (requirementInstance_id)
    REFERENCES requirementinstance(id) ON DELETE CASCADE;

ALTER TABLE activitysignoff ADD CONSTRAINT RefAIActSignOff 
    FOREIGN KEY (activityInstance_id)
    REFERENCES activityinstance(id) ON DELETE CASCADE;

ALTER TABLE activitysignoff ADD CONSTRAINT RefPersonaActSignOff 
    FOREIGN KEY (persona_id)
    REFERENCES persona(id);

ALTER TABLE alert_role ADD CONSTRAINT RefAlertRole 
    FOREIGN KEY (alert_id)
    REFERENCES alert(id) ON DELETE CASCADE;

ALTER TABLE alerthistory ADD CONSTRAINT RefAlertHis 
    FOREIGN KEY (alert_id)
    REFERENCES alert(id) ON DELETE CASCADE;

ALTER TABLE alerthistory ADD CONSTRAINT RefAppEntAlertHis 
    FOREIGN KEY (projectVersion_id)
    REFERENCES applicationentity(id) ON DELETE CASCADE;

ALTER TABLE alerttrigger ADD CONSTRAINT RefAlertTrigger 
    FOREIGN KEY (alert_id)
    REFERENCES alert(id) ON DELETE CASCADE;

ALTER TABLE applicationassignmentrule ADD CONSTRAINT RefRuntimeAppAssignRule 
    FOREIGN KEY (runtimeApplication_id)
    REFERENCES runtimeapplication(id) ON DELETE CASCADE;

ALTER TABLE applicationassignmentrule_host ADD CONSTRAINT RefAppRuleHost 
    FOREIGN KEY (applicationAssignmentRule_id)
    REFERENCES applicationassignmentrule(id) ON DELETE CASCADE;

ALTER TABLE applicationassignmentrule_host ADD CONSTRAINT RefHostAppAssignRuleHost 
    FOREIGN KEY (host_id)
    REFERENCES host(id) ON DELETE CASCADE;

ALTER TABLE artifact ADD CONSTRAINT RefPVArti 
    FOREIGN KEY (projectVersion_id)
    REFERENCES projectversion(id) ON DELETE CASCADE;

ALTER TABLE attrlookup ADD CONSTRAINT RefAttrAttrLookup 
    FOREIGN KEY (attr_id)
    REFERENCES attr(id) ON DELETE CASCADE;

ALTER TABLE auditcomment ADD CONSTRAINT RefIssAuditComment 
    FOREIGN KEY (issue_id)
    REFERENCES issue(id) ON DELETE CASCADE;

ALTER TABLE audithistory ADD CONSTRAINT RefIssAuditHis 
    FOREIGN KEY (issue_id)
    REFERENCES issue(id) ON DELETE CASCADE;

ALTER TABLE auditvalue ADD CONSTRAINT RefIssAuditVal 
    FOREIGN KEY (issue_id)
    REFERENCES issue(id) ON DELETE CASCADE;

ALTER TABLE consoleeventhandler ADD CONSTRAINT RefRuntimeConfEventHandler 
    FOREIGN KEY (runtimeConfiguration_id)
    REFERENCES runtimeconfiguration(id) ON DELETE CASCADE;

ALTER TABLE controller ADD CONSTRAINT RefKeyKeeperController 
    FOREIGN KEY (controllerKeyKeeper_id)
    REFERENCES controllerkeykeeper(id);

ALTER TABLE documentactivity ADD CONSTRAINT RefActDocAct 
    FOREIGN KEY (id)
    REFERENCES activity(id) ON DELETE CASCADE;

ALTER TABLE documentai ADD CONSTRAINT RefAIDocAI 
    FOREIGN KEY (id)
    REFERENCES activityinstance(id) ON DELETE CASCADE;

ALTER TABLE documentartifact ADD CONSTRAINT RefPVDocArti 
    FOREIGN KEY (projectVersion_id)
    REFERENCES projectversion(id) ON DELETE CASCADE;

ALTER TABLE documentartifact_def ADD CONSTRAINT RefDocArtiDocArtiDef 
    FOREIGN KEY (documentArtifact_id)
    REFERENCES documentartifact(id) ON DELETE CASCADE;

ALTER TABLE documentdefinstance ADD CONSTRAINT RefDocAIDocDI 
    FOREIGN KEY (activityInstance_id)
    REFERENCES documentai(id) ON DELETE CASCADE;

ALTER TABLE dynamicassessment ADD CONSTRAINT RefPVDynaAss 
    FOREIGN KEY (projectVersion_id)
    REFERENCES projectversion(id) ON DELETE CASCADE;

ALTER TABLE eventlogentry ADD CONSTRAINT RefAppEntEventLog 
    FOREIGN KEY (projectVersion_id)
    REFERENCES applicationentity(id) ON DELETE SET NULL;

ALTER TABLE federation ADD CONSTRAINT RefRuntimeConfFed 
    FOREIGN KEY (runtimeConfiguration_id)
    REFERENCES runtimeconfiguration(id);

ALTER TABLE filterset ADD CONSTRAINT RefPVFilterSet 
    FOREIGN KEY (projectVersion_id)
    REFERENCES projectversion(id) ON DELETE CASCADE;

ALTER TABLE finding ADD CONSTRAINT RefPVFinding 
    FOREIGN KEY (projectVersion_id)
    REFERENCES projectversion(id) ON DELETE CASCADE;

ALTER TABLE folder ADD CONSTRAINT RefPVFolder 
    FOREIGN KEY (projectVersion_id)
    REFERENCES projectversion(id) ON DELETE CASCADE;

ALTER TABLE foldercountcache ADD CONSTRAINT RefPVFolderCountCache 
    FOREIGN KEY (projectVersion_id)
    REFERENCES projectversion(id) ON DELETE CASCADE;

ALTER TABLE fortifyuser ADD CONSTRAINT RefSEFortifyUser 
    FOREIGN KEY (id)
    REFERENCES securityentity(id) ON DELETE CASCADE;

ALTER TABLE fpr_scan ADD CONSTRAINT RefArtiFPRScan 
    FOREIGN KEY (artifact_id)
    REFERENCES artifact(id) ON DELETE CASCADE;

ALTER TABLE host ADD CONSTRAINT RefControllerHost 
    FOREIGN KEY (controller_id)
    REFERENCES controller(id) ON DELETE CASCADE;

ALTER TABLE host ADD CONSTRAINT RefFedHost 
    FOREIGN KEY (federation_id)
    REFERENCES federation(id);

ALTER TABLE hostlogmessage ADD CONSTRAINT RefHostLogMsg 
    FOREIGN KEY (host_id)
    REFERENCES host(id) ON DELETE CASCADE;

ALTER TABLE iidmapping ADD CONSTRAINT RefIIDMigMapping 
    FOREIGN KEY (migration_id)
    REFERENCES iidmigration(id) ON DELETE CASCADE;

ALTER TABLE iidmigration ADD CONSTRAINT RefPVIIDMig 
    FOREIGN KEY (projectVersion_id)
    REFERENCES projectversion(id) ON DELETE CASCADE;

ALTER TABLE ldapentity ADD CONSTRAINT RefSELDAPEnt 
    FOREIGN KEY (id)
    REFERENCES securityentity(id) ON DELETE CASCADE;

ALTER TABLE measurement_variable ADD CONSTRAINT RefMeasVar 
    FOREIGN KEY (measurement_id)
    REFERENCES measurement(id) ON DELETE CASCADE;

ALTER TABLE measurement_variable ADD CONSTRAINT RefVarMeasVar 
    FOREIGN KEY (variable_id)
    REFERENCES variable(id) ON DELETE CASCADE;

ALTER TABLE measurementhistory ADD CONSTRAINT RefMeasHis 
    FOREIGN KEY (measurement_id)
    REFERENCES measurement(id) ON DELETE CASCADE;

ALTER TABLE measurementhistory ADD CONSTRAINT RefSnapshotMeasHis 
    FOREIGN KEY (snapshot_id)
    REFERENCES snapshot(id) ON DELETE CASCADE;

ALTER TABLE measurementinstance ADD CONSTRAINT RefMeasMI 
    FOREIGN KEY (measurement_id)
    REFERENCES measurement(id);

ALTER TABLE measurementinstance ADD CONSTRAINT RefProjStatAIMI 
    FOREIGN KEY (activityInstance_id)
    REFERENCES projectstateai(id) ON DELETE CASCADE;

ALTER TABLE metadef ADD CONSTRAINT RefMetaDefRecur 
    FOREIGN KEY (parent_id)
    REFERENCES metadef(id);

ALTER TABLE metadef_t ADD CONSTRAINT RefMetaDefT 
    FOREIGN KEY (metaDef_id)
    REFERENCES metadef(id) ON DELETE CASCADE;

ALTER TABLE metaoption ADD CONSTRAINT RefMetaDefOpt 
    FOREIGN KEY (metaDef_id)
    REFERENCES metadef(id) ON DELETE CASCADE;

ALTER TABLE metaoption_t ADD CONSTRAINT RefMetaOptT 
    FOREIGN KEY (metaOption_id)
    REFERENCES metaoption(id) ON DELETE CASCADE;

ALTER TABLE metavalue ADD CONSTRAINT RefAppEntMetaValue 
    FOREIGN KEY (projectVersion_id)
    REFERENCES applicationentity(id) ON DELETE CASCADE;

ALTER TABLE metavalue ADD CONSTRAINT RefMetaDefMV 
    FOREIGN KEY (metaDef_id)
    REFERENCES metadef(id);

ALTER TABLE metavalueselection ADD CONSTRAINT RefMetaOptMVSel 
    FOREIGN KEY (metaOption_id)
    REFERENCES metaoption(id);

ALTER TABLE metavalueselection ADD CONSTRAINT RefMetaValMVSel 
    FOREIGN KEY (metaValue_id)
    REFERENCES metavalue(id) ON DELETE CASCADE;

ALTER TABLE payloadartifact ADD CONSTRAINT RefPVPLArti 
    FOREIGN KEY (projectVersion_id)
    REFERENCES projectversion(id) ON DELETE CASCADE;

ALTER TABLE payloadentry ADD CONSTRAINT RefPLArtiPLEntry 
    FOREIGN KEY (artifact_id)
    REFERENCES payloadartifact(id) ON DELETE CASCADE;

ALTER TABLE payloadmessage ADD CONSTRAINT RefPLArtiPLMsg 
    FOREIGN KEY (artifact_id)
    REFERENCES payloadartifact(id) ON DELETE CASCADE;

ALTER TABLE permissioninstance ADD CONSTRAINT RefPerPI 
    FOREIGN KEY (permission_id)
    REFERENCES permission(id) ON DELETE CASCADE;

ALTER TABLE personaassignment ADD CONSTRAINT RefPersonaAssign 
    FOREIGN KEY (persona_id)
    REFERENCES persona(id);

ALTER TABLE personaassignment ADD CONSTRAINT RefPVPersonaAssign 
    FOREIGN KEY (projectVersion_id)
    REFERENCES projectversion(id) ON DELETE CASCADE;

ALTER TABLE pref_pod ADD CONSTRAINT RefPodPref 
    FOREIGN KEY (pod_id)
    REFERENCES pod(id) ON DELETE CASCADE;

ALTER TABLE pref_pod ADD CONSTRAINT RefUserPrefPrefPod 
    FOREIGN KEY (pref_id)
    REFERENCES userpreference(id) ON DELETE CASCADE;

ALTER TABLE pref_projectversion ADD CONSTRAINT RefPVPrefPV 
    FOREIGN KEY (projectVersion_id)
    REFERENCES projectversion(id) ON DELETE CASCADE;

ALTER TABLE pref_projectversion ADD CONSTRAINT UserPrefPrefPV 
    FOREIGN KEY (pref_id)
    REFERENCES userpreference(id) ON DELETE CASCADE;

ALTER TABLE projectstateactivity ADD CONSTRAINT RefActProjStatAct 
    FOREIGN KEY (id)
    REFERENCES activity(id) ON DELETE CASCADE;

ALTER TABLE projectstateactivity ADD CONSTRAINT RefMeasProjStatAct 
    FOREIGN KEY (measurement_id)
    REFERENCES measurement(id);

ALTER TABLE projectstateai ADD CONSTRAINT RefAIProjStatAI 
    FOREIGN KEY (id)
    REFERENCES activityinstance(id) ON DELETE CASCADE;

ALTER TABLE projectstateai ADD CONSTRAINT RefMeasProjStatAI 
    FOREIGN KEY (measurement_id)
    REFERENCES measurement(id);

ALTER TABLE projecttemplate_attr ADD CONSTRAINT RefPTAttr 
    FOREIGN KEY (projectTemplate_id)
    REFERENCES projecttemplate(id) ON DELETE CASCADE;

ALTER TABLE projectversion_alert ADD CONSTRAINT RefAppEntAlert 
    FOREIGN KEY (projectVersion_id)
    REFERENCES applicationentity(id) ON DELETE CASCADE;

ALTER TABLE projectversion_alert ADD CONSTRAINT RefPVAlert 
    FOREIGN KEY (alert_id)
    REFERENCES alert(id) ON DELETE CASCADE;

ALTER TABLE projectversion_rule ADD CONSTRAINT RefPVPVRule 
    FOREIGN KEY (projectVersion_id)
    REFERENCES projectversion(id) ON DELETE CASCADE;

ALTER TABLE projectversion_rule ADD CONSTRAINT RefRuleDescPVRule 
    FOREIGN KEY (rule_id)
    REFERENCES ruledescription(id) ON DELETE CASCADE;

ALTER TABLE projectversiondependency ADD CONSTRAINT RefPVDepChild 
    FOREIGN KEY (childProjectVersion_id)
    REFERENCES projectversion(id);

ALTER TABLE projectversiondependency ADD CONSTRAINT RefPVDepParent 
    FOREIGN KEY (parentProjectVersion_id)
    REFERENCES projectversion(id);

ALTER TABLE pt_permission ADD CONSTRAINT RefPerPTPer 
    FOREIGN KEY (permission_id)
    REFERENCES permission(id) ON DELETE CASCADE;

ALTER TABLE pt_permission ADD CONSTRAINT RefPTPer 
    FOREIGN KEY (pt_id)
    REFERENCES permissiontemplate(id) ON DELETE CASCADE;

ALTER TABLE publishaction ADD CONSTRAINT RefPubRepPubAct 
    FOREIGN KEY (publishedReport_id)
    REFERENCES publishedreport(id) ON DELETE CASCADE;

ALTER TABLE report_projectversion ADD CONSTRAINT RefSavedRepPV 
    FOREIGN KEY (savedReport_id)
    REFERENCES savedreport(id) ON DELETE CASCADE;

ALTER TABLE reportparameter ADD CONSTRAINT RefRepDefRepParam 
    FOREIGN KEY (reportDefinition_id)
    REFERENCES reportdefinition(id) ON DELETE CASCADE;

ALTER TABLE requirement ADD CONSTRAINT RefRTRep 
    FOREIGN KEY (requirementTemplate_id)
    REFERENCES requirementtemplate(id);

ALTER TABLE requirement_activity ADD CONSTRAINT RefActReqAct 
    FOREIGN KEY (activity_id)
    REFERENCES activity(id) ON DELETE CASCADE;

ALTER TABLE requirement_activity ADD CONSTRAINT RefReqAct 
    FOREIGN KEY (requirement_id)
    REFERENCES requirement(id) ON DELETE CASCADE;

ALTER TABLE requirement_persona ADD CONSTRAINT RefPersonaReqPerson 
    FOREIGN KEY (persona_id)
    REFERENCES persona(id);

ALTER TABLE requirement_persona ADD CONSTRAINT RefReqPerson 
    FOREIGN KEY (requirement_id)
    REFERENCES requirement(id) ON DELETE CASCADE;

ALTER TABLE requirementcomment ADD CONSTRAINT RefRIReqComment 
    FOREIGN KEY (requirementInstance_id)
    REFERENCES requirementinstance(id) ON DELETE CASCADE;

ALTER TABLE requirementinstance ADD CONSTRAINT RefPVRI 
    FOREIGN KEY (projectVersion_id)
    REFERENCES projectversion(id) ON DELETE CASCADE;

ALTER TABLE requirementinstance ADD CONSTRAINT RefReqRI 
    FOREIGN KEY (requirement_id)
    REFERENCES requirement(id);

ALTER TABLE requirementsignoff ADD CONSTRAINT RefPersonaReqSignOff 
    FOREIGN KEY (persona_id)
    REFERENCES persona(id);

ALTER TABLE requirementsignoff ADD CONSTRAINT RefRIReqSignOff 
    FOREIGN KEY (requirementInstance_id)
    REFERENCES requirementinstance(id) ON DELETE CASCADE;

ALTER TABLE requirementtemplate_persona ADD CONSTRAINT RefPersonaRTPersona 
    FOREIGN KEY (persona_id)
    REFERENCES persona(id);

ALTER TABLE requirementtemplate_persona ADD CONSTRAINT RefRTPersona 
    FOREIGN KEY (requirementTemplate_id)
    REFERENCES requirementtemplate(id) ON DELETE CASCADE;

ALTER TABLE requirementtemplatecomment ADD CONSTRAINT RefRTIRTComment 
    FOREIGN KEY (projectVersion_id)
    REFERENCES requirementtemplateinstance(projectVersion_id) ON DELETE CASCADE;

ALTER TABLE requirementtemplateinstance ADD CONSTRAINT RefPVRTI 
    FOREIGN KEY (projectVersion_id)
    REFERENCES projectversion(id) ON DELETE CASCADE;

ALTER TABLE requirementtemplateinstance ADD CONSTRAINT RefRTRTI 
    FOREIGN KEY (requirementTemplate_id)
    REFERENCES requirementtemplate(id);

ALTER TABLE requirementtemplatesignoff ADD CONSTRAINT RefPersonaRTSignOff 
    FOREIGN KEY (persona_id)
    REFERENCES persona(id);

ALTER TABLE requirementtemplatesignoff ADD CONSTRAINT RefRTIRTSignOff 
    FOREIGN KEY (projectVersion_id)
    REFERENCES requirementtemplateinstance(projectVersion_id) ON DELETE CASCADE;

ALTER TABLE rtassignment ADD CONSTRAINT RefMetaRuleRTAssign 
    FOREIGN KEY (metadataRule_id)
    REFERENCES metadatarule(id) ON DELETE CASCADE;

ALTER TABLE rtassignment ADD CONSTRAINT RefRTAssign 
    FOREIGN KEY (requirementTemplate_id)
    REFERENCES requirementtemplate(id);

ALTER TABLE rule_t ADD CONSTRAINT RefRuleDescT 
    FOREIGN KEY (id)
    REFERENCES ruledescription(id) ON DELETE CASCADE;

ALTER TABLE runtimealert ADD CONSTRAINT RefRERuntimeAlert 
    FOREIGN KEY (runtimeEvent_id)
    REFERENCES runtimeevent(id) ON DELETE CASCADE;

ALTER TABLE runtimeconfig_rulepack ADD CONSTRAINT RefRPRuntimeConfRP 
    FOREIGN KEY (rulepack_id)
    REFERENCES rulepack(id) ON DELETE CASCADE;

ALTER TABLE runtimeconfig_rulepack ADD CONSTRAINT RefRuntimeConfRP 
    FOREIGN KEY (runtimeConfiguration_id)
    REFERENCES runtimeconfiguration(id) ON DELETE CASCADE;

ALTER TABLE runtimeevent ADD CONSTRAINT RefHostRE 
    FOREIGN KEY (host_id)
    REFERENCES host(id) ON DELETE CASCADE;

ALTER TABLE runtimeeventarchive ADD CONSTRAINT RefDocInfoREArch 
    FOREIGN KEY (documentInfo_id)
    REFERENCES documentinfo(id);

ALTER TABLE runtimeeventattr ADD CONSTRAINT RefREREAttr 
    FOREIGN KEY (runtimeEvent_id)
    REFERENCES runtimeevent(id) ON DELETE CASCADE;

ALTER TABLE runtimenamedattr ADD CONSTRAINT RefRNASetRNA 
    FOREIGN KEY (runtimeNamedAttrSet_id)
    REFERENCES runtimenamedattrset(id);

ALTER TABLE runtimesetting ADD CONSTRAINT RefRuntimeConfSetting 
    FOREIGN KEY (runtimeConfiguration_id)
    REFERENCES runtimeconfiguration(id) ON DELETE CASCADE;

ALTER TABLE savedevidence ADD CONSTRAINT RefPVSavedEvidence 
    FOREIGN KEY (projectVersion_id)
    REFERENCES projectversion(id) ON DELETE CASCADE;

ALTER TABLE savedreport ADD CONSTRAINT RefRepDefSavedRep 
    FOREIGN KEY (reportDefinition_id)
    REFERENCES reportdefinition(id);

ALTER TABLE scan ADD CONSTRAINT RefPVScan 
    FOREIGN KEY (projectVersion_id)
    REFERENCES projectversion(id) ON DELETE CASCADE;

ALTER TABLE scan_finding ADD CONSTRAINT RefScanFinding 
    FOREIGN KEY (scan_id)
    REFERENCES scan(id) ON DELETE CASCADE;

ALTER TABLE scan_rulepack ADD CONSTRAINT RefScanRP 
    FOREIGN KEY (scan_id)
    REFERENCES scan(id) ON DELETE CASCADE;

ALTER TABLE sdlhistory ADD CONSTRAINT RefSnapshotSDLHis 
    FOREIGN KEY (snapshot_id)
    REFERENCES snapshot(id) ON DELETE CASCADE;

ALTER TABLE snapshot ADD CONSTRAINT RefPVSnapshot 
    FOREIGN KEY (projectVersion_id)
    REFERENCES projectversion(id) ON DELETE CASCADE;

ALTER TABLE sourcefilemap ADD CONSTRAINT RefScanSrcFileMap 
    FOREIGN KEY (scan_id)
    REFERENCES scan(id) ON DELETE CASCADE;

ALTER TABLE taskcomment ADD CONSTRAINT RefTITaskComment 
    FOREIGN KEY (taskInstance_id)
    REFERENCES taskinstance(id) ON DELETE CASCADE;

ALTER TABLE taskinstance ADD CONSTRAINT RefAITaskAI 
    FOREIGN KEY (activityInstance_id)
    REFERENCES activityinstance(id) ON DELETE CASCADE;

ALTER TABLE timelapse_event ADD CONSTRAINT RefTimeAITimeEvent 
    FOREIGN KEY (activityInstance_id)
    REFERENCES timelapseai(id) ON DELETE CASCADE;

ALTER TABLE timelapseactivity ADD CONSTRAINT RefActTimeAct 
    FOREIGN KEY (id)
    REFERENCES activity(id) ON DELETE CASCADE;

ALTER TABLE timelapseai ADD CONSTRAINT RefAITimeAI 
    FOREIGN KEY (id)
    REFERENCES activityinstance(id) ON DELETE CASCADE;

ALTER TABLE user_permission ADD CONSTRAINT RefPerUserPer 
    FOREIGN KEY (permission_id)
    REFERENCES permission(id) ON DELETE CASCADE;

ALTER TABLE user_permission ADD CONSTRAINT RefPTUserPer 
    FOREIGN KEY (pt_id)
    REFERENCES permissiontemplate(id) ON DELETE CASCADE;

ALTER TABLE user_permission ADD CONSTRAINT RefSEUserPer 
    FOREIGN KEY (user_id)
    REFERENCES securityentity(id) ON DELETE CASCADE;

ALTER TABLE user_pi ADD CONSTRAINT RefPIUPI 
    FOREIGN KEY (pi_id)
    REFERENCES permissioninstance(id) ON DELETE CASCADE;

ALTER TABLE user_pi ADD CONSTRAINT RefPTUserPI 
    FOREIGN KEY (pt_id)
    REFERENCES permissiontemplate(id) ON DELETE CASCADE;

ALTER TABLE user_pi ADD CONSTRAINT RefSEUserPI 
    FOREIGN KEY (user_id)
    REFERENCES securityentity(id) ON DELETE CASCADE;

ALTER TABLE user_pt ADD CONSTRAINT RefPTUserPT 
    FOREIGN KEY (pt_id)
    REFERENCES permissiontemplate(id) ON DELETE CASCADE;

ALTER TABLE user_pt ADD CONSTRAINT RefSEUserPT 
    FOREIGN KEY (user_id)
    REFERENCES securityentity(id) ON DELETE CASCADE;

ALTER TABLE variablehistory ADD CONSTRAINT RefSnapshotVarHis 
    FOREIGN KEY (snapshot_id)
    REFERENCES snapshot(id) ON DELETE CASCADE;

ALTER TABLE variablehistory ADD CONSTRAINT RefVarHis 
    FOREIGN KEY (variable_id)
    REFERENCES variable(id) ON DELETE CASCADE;

ALTER TABLE variableinstance ADD CONSTRAINT RefProjStatAIVI 
    FOREIGN KEY (ai_id)
    REFERENCES projectstateai(id) ON DELETE CASCADE;

ALTER TABLE variableinstance ADD CONSTRAINT RefVarVI 
    FOREIGN KEY (variable_id)
    REFERENCES variable(id);

CREATE VIEW ruleview AS
SELECT p.projectVersion_id projectVersion_id, r.id id, p.ruleGuid ruleGuid, r.rulepack_id rulepack_id, t.lang lang,
t.detail detail, t.recommendation recommendation, t.ruleAbstract ruleAbstract,
t.rawDetail rawDetail, t.rawRecommendation rawRecommendation, t.rawRuleAbstract rawRuleAbstract
FROM ruledescription r, rule_t t, projectversion_rule p
where r.id = t.id AND p.rule_id = r.id;

CREATE VIEW audithistoryview AS
SELECT
h.issue_id issue_id,
h.seqNumber seqNumber,
h.attrGuid attrGuid,
h.auditTime auditTime,
h.oldValue oldNum,
h.newValue newNum,
CASE WHEN a.guid='userAssignment' THEN ou.userName ELSE o.lookupValue END oldString,
CASE WHEN a.guid='userAssignment' THEN nu.userName ELSE n.lookupValue END newString,
h.projectVersion_id projectVersion_id,
h.userName userName,
h.conflict conflict,
a.attrName attrName,
a.defaultValue
from audithistory as h JOIN attr as a ON h.attrGuid=a.guid
LEFT OUTER JOIN attrlookup as n ON a.id=n.attr_id
AND h.newValue=n.lookupIndex
LEFT OUTER JOIN attrlookup o ON a.id=o.attr_id
and h.oldValue=o.lookupIndex
LEFT OUTER JOIN userpreference as nu ON nu.id=h.newValue
LEFT OUTER JOIN userpreference ou ON ou.id=h.oldValue;

CREATE VIEW auditvalueview AS 
 SELECT a.projectVersion_id projectVersion_Id, a.issue_id issue_id, a.attrGuid attrGuid, a.attrValue lookupIndex, l.lookupValue lookupValue, attr.attrName attrName, attr.defaultValue, attr.hidden, l.seqNumber
 from auditvalue a, attr, attrlookup l 
 where a.attrGuid=attr.guid and attr.id=l.attr_id and l.lookupIndex=a.attrValue;

CREATE VIEW metadefview AS 
 SELECT def.id id, def.metaType metaType, def.seqNumber seqNumber, def.required required, def.category category, def.hidden hidden, def.booleanDefault booleanDefault, def.guid guid, def.parent_id parent_id, t.name name, t.description description, t.help help, t.lang lang, def.parentOption_id, def.appEntityType, def.objectVersion, def.publishVersion
 from metadef def, metadef_t t 
 where def.id =  t.metaDef_id  AND t.metaDef_id = def.id;

CREATE VIEW metaoptionview AS
 select op.id id, op.optionIndex optionIndex, op.metaDef_id metaDef_id, op.defaultSelection defaultSelection, op.guid guid , t.name name, t.description description, t.help help, t.lang lang, op.hidden
 from metaoption op, metaoption_t t 
 where op.id =  t.metaOption_id;

create view defaultissueview as
select 
c.folder_id,
i.id,
i.issueinstanceid,
    i.fileName,
    i.shortFileName,
    i.severity,
    i.ruleGuid,
    i.confidence,
    i.kingdom,
    i.issueType,
    i.issueSubtype,
    i.analyzer,
    i.lineNumber,
    i.taintFlag,
    i.packageName,
    i.functionName,
    i.className,
    i.issueAbstract,
    i.friority,
    i.engineType,
    i.scanStatus,
    i.audienceSet,
    i.lastScan_id,
    i.replaceStore,
    i.snippetId,
    i.url,
    i.category,
    i.source,
    i.sourceContext,
    i.sourceFile,
    i.sink,
    i.sinkContext,
    i.userName,
    i.owasp2004,
    i.owasp2007,
    i.cwe,
    i.revision,
    i.audited,
    i.auditedTime,
    i.suppressed,
    i.findingGuid,
    i.issueStatus,
    i.issueState,
    i.dynamicConfidence,
    i.remediationConstant,
    p.id projectVersion_id,
    c.hidden,
    i.likelihood,
    i.impact,
    i.accuracy,
    i.sans25,
    i.wasc,
    i.stig,
    i.pci11,
    i.pci12,
    i.rtaCovered,
    i.probability
from issuecache c, issue i, projectversion p, filterset f
where c.issue_id = i.id
and i.projectversion_id = p.id
and c.filterset_id= f.id
and f.enabled='Y'
and f.filtersettype='user'
and f.projectversion_id = p.id;

create view applicationentityview as
 select a.id id, p.name name,a.appEntityType
 from applicationentity a, projectversion p
 where a.id = p.id
 union 
 select a.id id, r.name name ,a.appEntityType from applicationentity a, runtimeapplication r where a.id = r.id;

create view attrlookupview as
select attr_id ,lookupindex , lookupvalue , attrguid, hidden,seqnumber
from attrlookup
union
select attr_id,-1 lookupindex,'' lookupvalue,attrguid,'Y' hidden,-1 seqnumber
from attrlookup
group by attr_id, attrguid;

DELIMITER //
CREATE PROCEDURE updateExistingWithLatest(p_scan_id INT,p_projectVersion_Id INT, p_engineType varchar(20))BEGIN
        UPDATE issue issue, scan_issue si SET issue.lastScan_Id= si.scan_id
        , issue.shortFileName=si.shortFileName, issue.fileName=si.fileName, issue.severity=si.severity, issue.confidence=si.confidence, issue.kingdom=si.kingdom, issue.issueType=si.issueType
        , issue.issueSubtype=si.issueSubtype, issue.analyzer=si.analyzer, issue.engineType=si.engineType, issue.lineNumber=si.lineNumber, issue.taintFlag=si.taintFlag, issue.packageName=si.packageName 
        , issue.functionName=si.functionName, issue.className=si.className, issue.issueAbstract=si.issueAbstract, issue.friority=si.friority, issue.replaceStore=si.replaceStore
        , issue.ruleGuid=si.ruleGuid, issue.snippetId=si.snippetId, issue.category=si.category, issue.url=si.url, issue.source=si.source, issue.sourceContext=si.sourceContext, issue.sink=si.sink
        , issue.sinkContext=si.sinkContext, issue.sourceFile=si.sourceFile, issue.audienceSet=si.audienceSet, issue.owasp2004=si.owasp2004, issue.owasp2007=si.owasp2007, issue.cwe=si.cwe
        , issue.scanStatus = (CASE WHEN scanStatus='REMOVED' THEN 'REINTRODUCED' ELSE 'UPDATED' END)
        , issue.findingGuid = si.findingGuid, issue.remediationConstant=si.remediationConstant,issue.likelihood=si.likelihood,issue.impact=si.impact, issue.accuracy=si.accuracy
        , issue.sans25=si.sans25, issue.wasc=si.wasc, issue.stig=si.stig, issue.pci11=si.pci11, issue.pci12=si.pci12, issue.rtaCovered=si.rtaCovered,issue.probability=si.probability
        WHERE issue.projectVersion_Id = p_projectVersion_Id AND issue.engineType= p_engineType AND si.issueInstanceId=issue.issueInstanceId AND si.scan_id= p_scan_id;    
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE updateDeletedIssues(p_scan_id INT,p_previous_scan_id INT, p_projectVersion_Id INT)BEGIN
        UPDATE issue issue, scan_issue si SET issue.lastScan_Id= si.scan_id
        , issue.shortFileName=si.shortFileName, issue.fileName=si.fileName, issue.severity=si.severity, issue.confidence=si.confidence, issue.kingdom=si.kingdom, issue.issueType=si.issueType
        , issue.issueSubtype=si.issueSubtype, issue.analyzer=si.analyzer, issue.engineType=si.engineType, issue.lineNumber=si.lineNumber, issue.taintFlag=si.taintFlag, issue.packageName=si.packageName 
        , issue.functionName=si.functionName, issue.className=si.className, issue.issueAbstract=si.issueAbstract, issue.friority=si.friority, issue.replaceStore=si.replaceStore
        , issue.ruleGuid=si.ruleGuid, issue.snippetId=si.snippetId, issue.category=si.category, issue.url=si.url, issue.source=si.source, issue.sourceContext=si.sourceContext, issue.sink=si.sink
        , issue.sinkContext=si.sinkContext, issue.sourceFile=si.sourceFile, issue.audienceSet=si.audienceSet, issue.owasp2004=si.owasp2004, issue.owasp2007=si.owasp2007, issue.cwe=si.cwe
        , issue.scanStatus = (CASE WHEN scanStatus='REMOVED' THEN 'REINTRODUCED' ELSE 'UPDATED' END)
        , issue.findingGuid = si.findingGuid, issue.remediationConstant=si.remediationConstant,issue.likelihood=si.likelihood,issue.impact=si.impact, issue.accuracy=si.accuracy
        , issue.sans25=si.sans25, issue.wasc=si.wasc, issue.stig=si.stig, issue.pci11=si.pci11, issue.pci12=si.pci12, issue.rtaCovered=si.rtaCovered,issue.probability=si.probability
        WHERE issue.projectVersion_Id = p_projectVersion_Id AND issue.lastScan_id= p_scan_id AND si.issueInstanceId=issue.issueInstanceId AND si.scan_id= p_previous_scan_id;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE updateRemovedWithUpload(p_scan_id INT,p_projectVersion_Id INT, p_engineType varchar(20), p_scanDate BIGINT)BEGIN
        UPDATE issue issue, scan_issue si, scan scan SET issue.lastScan_Id= si.scan_id
        , issue.shortFileName=si.shortFileName, issue.fileName=si.fileName, issue.severity=si.severity, issue.confidence=si.confidence, issue.kingdom=si.kingdom, issue.issueType=si.issueType
        , issue.issueSubtype=si.issueSubtype, issue.analyzer=si.analyzer, issue.engineType=si.engineType, issue.lineNumber=si.lineNumber, issue.taintFlag=si.taintFlag, issue.packageName=si.packageName 
        , issue.functionName=si.functionName, issue.className=si.className, issue.issueAbstract=si.issueAbstract, issue.friority=si.friority, issue.replaceStore=si.replaceStore
        , issue.ruleGuid=si.ruleGuid, issue.snippetId=si.snippetId, issue.category=si.category, issue.url=si.url, issue.source=si.source, issue.sourceContext=si.sourceContext, issue.sink=si.sink
        , issue.sinkContext=si.sinkContext, issue.sourceFile=si.sourceFile, issue.audienceSet=si.audienceSet, issue.owasp2004=si.owasp2004, issue.owasp2007=si.owasp2007, issue.cwe=si.cwe
        , issue.findingGuid = si.findingGuid, issue.remediationConstant=si.remediationConstant,issue.likelihood=si.likelihood,issue.impact=si.impact, issue.accuracy=si.accuracy
        , issue.sans25=si.sans25, issue.wasc=si.wasc, issue.stig=si.stig, issue.pci11=si.pci11, issue.pci12=si.pci12, issue.rtaCovered=si.rtaCovered,issue.probability=si.probability
        WHERE issue.projectVersion_Id = p_projectVersion_Id AND issue.engineType= p_engineType AND si.issueInstanceId=issue.issueInstanceId AND si.scan_id= p_scan_id AND issue.scanStatus='REMOVED' AND 
        issue.lastScan_id = scan.id and scan.startDate < p_scanDate;    
END//
DELIMITER ;

CREATE TABLE QRTZ_JOB_DETAILS
  (
    JOB_NAME  VARCHAR(200) NOT NULL,
    JOB_GROUP VARCHAR(200) NOT NULL,
    DESCRIPTION VARCHAR(250) NULL,
    JOB_CLASS_NAME   VARCHAR(250) NOT NULL,
    IS_DURABLE VARCHAR(1) NOT NULL,
    IS_VOLATILE VARCHAR(1) NOT NULL,
    IS_STATEFUL VARCHAR(1) NOT NULL,
    REQUESTS_RECOVERY VARCHAR(1) NOT NULL,
    JOB_DATA BLOB NULL,
    PRIMARY KEY (JOB_NAME,JOB_GROUP)
)ENGINE=INNODB;

CREATE TABLE QRTZ_JOB_LISTENERS
  (
    JOB_NAME  VARCHAR(200) NOT NULL,
    JOB_GROUP VARCHAR(200) NOT NULL,
    JOB_LISTENER VARCHAR(200) NOT NULL,
    PRIMARY KEY (JOB_NAME,JOB_GROUP,JOB_LISTENER),
    FOREIGN KEY (JOB_NAME,JOB_GROUP)
    REFERENCES QRTZ_JOB_DETAILS(JOB_NAME,JOB_GROUP)
)ENGINE=INNODB;

CREATE TABLE QRTZ_TRIGGERS
 (
   TRIGGER_NAME VARCHAR(200) NOT NULL,
    TRIGGER_GROUP VARCHAR(200) NOT NULL,
    JOB_NAME  VARCHAR(200) NOT NULL,
    JOB_GROUP VARCHAR(200) NOT NULL,
    IS_VOLATILE VARCHAR(1) NOT NULL,
    DESCRIPTION VARCHAR(250) NULL,
    NEXT_FIRE_TIME BIGINT(13) NULL,
    PREV_FIRE_TIME BIGINT(13) NULL,
    PRIORITY INTEGER NULL,
    TRIGGER_STATE VARCHAR(16) NOT NULL,
    TRIGGER_TYPE VARCHAR(8) NOT NULL,
    START_TIME BIGINT(13) NOT NULL,
    END_TIME BIGINT(13) NULL,
    CALENDAR_NAME VARCHAR(200) NULL,
    MISFIRE_INSTR SMALLINT(2) NULL,
    JOB_DATA BLOB NULL,
    PRIMARY KEY (TRIGGER_NAME,TRIGGER_GROUP)
)ENGINE=INNODB;

CREATE TABLE QRTZ_SIMPLE_TRIGGERS
  (
    TRIGGER_NAME VARCHAR(200) NOT NULL,
    TRIGGER_GROUP VARCHAR(200) NOT NULL,
    REPEAT_COUNT BIGINT(7) NOT NULL,
    REPEAT_INTERVAL BIGINT(12) NOT NULL,
    TIMES_TRIGGERED BIGINT(7) NOT NULL,
    PRIMARY KEY (TRIGGER_NAME,TRIGGER_GROUP)
)ENGINE=INNODB;

CREATE TABLE QRTZ_CRON_TRIGGERS
  (
    TRIGGER_NAME VARCHAR(200) NOT NULL,
    TRIGGER_GROUP VARCHAR(200) NOT NULL,
    CRON_EXPRESSION VARCHAR(200) NOT NULL,
    TIME_ZONE_ID VARCHAR(80),
    PRIMARY KEY (TRIGGER_NAME,TRIGGER_GROUP)
)ENGINE=INNODB;

CREATE TABLE QRTZ_BLOB_TRIGGERS
  (
    TRIGGER_NAME VARCHAR(200) NOT NULL,
    TRIGGER_GROUP VARCHAR(200) NOT NULL,
    BLOB_DATA BLOB NULL,
    PRIMARY KEY (TRIGGER_NAME,TRIGGER_GROUP)
)ENGINE=INNODB;

CREATE TABLE QRTZ_TRIGGER_LISTENERS
  (
    TRIGGER_NAME  VARCHAR(200) NOT NULL,
    TRIGGER_GROUP VARCHAR(200) NOT NULL,
    TRIGGER_LISTENER VARCHAR(200) NOT NULL,
    PRIMARY KEY (TRIGGER_NAME,TRIGGER_GROUP,TRIGGER_LISTENER),
    FOREIGN KEY (TRIGGER_NAME,TRIGGER_GROUP)
        REFERENCES QRTZ_TRIGGERS(TRIGGER_NAME,TRIGGER_GROUP)
)ENGINE=INNODB;

CREATE TABLE QRTZ_CALENDARS
  (
    CALENDAR_NAME  VARCHAR(200) NOT NULL,
    CALENDAR BLOB NOT NULL,
    PRIMARY KEY (CALENDAR_NAME)
)ENGINE=INNODB;

CREATE TABLE QRTZ_PAUSED_TRIGGER_GRPS
  (
    TRIGGER_GROUP  VARCHAR(200) NOT NULL, 
    PRIMARY KEY (TRIGGER_GROUP)
)ENGINE=INNODB;

CREATE TABLE QRTZ_FIRED_TRIGGERS
  (
    ENTRY_ID VARCHAR(95) NOT NULL,
    TRIGGER_NAME VARCHAR(200) NOT NULL,
    TRIGGER_GROUP VARCHAR(200) NOT NULL,
    IS_VOLATILE VARCHAR(1) NOT NULL,
    INSTANCE_NAME VARCHAR(200) NOT NULL,
    FIRED_TIME BIGINT(13) NOT NULL,
    PRIORITY INTEGER NOT NULL,
    STATE VARCHAR(16) NOT NULL,
    JOB_NAME VARCHAR(200) NULL,
    JOB_GROUP VARCHAR(200) NULL,
    IS_STATEFUL VARCHAR(1) NULL,
    REQUESTS_RECOVERY VARCHAR(1) NULL,
    PRIMARY KEY (ENTRY_ID)
)ENGINE=INNODB;

CREATE TABLE QRTZ_SCHEDULER_STATE
  (
    INSTANCE_NAME VARCHAR(200) NOT NULL,
    LAST_CHECKIN_TIME BIGINT(13) NOT NULL,
    CHECKIN_INTERVAL BIGINT(13) NOT NULL,
    PRIMARY KEY (INSTANCE_NAME)
)ENGINE=INNODB;

CREATE TABLE QRTZ_LOCKS
  (
    LOCK_NAME  VARCHAR(40) NOT NULL, 
    PRIMARY KEY (LOCK_NAME)
)ENGINE=INNODB;

INSERT INTO QRTZ_LOCKS values('TRIGGER_ACCESS');

INSERT INTO QRTZ_LOCKS values('JOB_ACCESS');

INSERT INTO QRTZ_LOCKS values('CALENDAR_ACCESS');

INSERT INTO QRTZ_LOCKS values('STATE_ACCESS');

INSERT INTO QRTZ_LOCKS values('MISFIRE_ACCESS');

commit;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Custom SQL (x3)', 'EXECUTED', 'dbF360Mysql_2.5.0.xml', 'f360Mysql_2.5.0', '2.0.1', '3:e2de5d8bc5af642a8ec52399ab9168ed', 3);

-- Changeset dbF360Mssql_2.5.0.xml::f360Mssql_2.5.0::hp::(Checksum: 3:19357c4c88c650c82879366450590e8e)
INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Custom SQL', 'MARK_RAN', 'dbF360Mssql_2.5.0.xml', 'f360Mssql_2.5.0', '2.0.1', '3:19357c4c88c650c82879366450590e8e', 4);

-- Changeset dbF360Oracle_2.5.0.xml::f360Oracle_2.5.0::hp::(Checksum: 3:690cfeadc6702a7914b5e22e04fdac4f)
INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Custom SQL, Create Procedure (x3), Custom SQL', 'MARK_RAN', 'dbF360Oracle_2.5.0.xml', 'f360Oracle_2.5.0', '2.0.1', '3:690cfeadc6702a7914b5e22e04fdac4f', 5);

-- Changeset dbF360Db2_2.6.0.xml::f360Db2_2.6.0::hp::(Checksum: 3:bfc5b167a3c6e3f7965707bcb4a7f724)
INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Custom SQL', 'MARK_RAN', 'dbF360Db2_2.6.0.xml', 'f360Db2_2.6.0', '2.0.1', '3:bfc5b167a3c6e3f7965707bcb4a7f724', 6);

-- Changeset dbF360Derby_2.6.0.xml::f360Derby_2.6.0::hp::(Checksum: 3:2921866a151374d373b71bdc081a333f)
INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Custom SQL', 'MARK_RAN', 'dbF360Derby_2.6.0.xml', 'f360Derby_2.6.0', '2.0.1', '3:2921866a151374d373b71bdc081a333f', 7);

-- Changeset dbF360Mysql_2.6.0.xml::f360Mysql_2.6.0::hp::(Checksum: 3:e297bdb89a88818462926216078a2614)
ALTER TABLE agentcredential DROP credential;

ALTER TABLE consoleeventhandler MODIFY matchConditionsXml MEDIUMTEXT, MODIFY additionalMatchConditionsXml MEDIUMTEXT;

ALTER TABLE host ADD shouldHaveCert CHAR(1) DEFAULT 'N';

UPDATE host set shouldHaveCert=hasConnected;

ALTER TABLE hostlogmessage ADD connectionId VARCHAR(255);

ALTER TABLE issue ADD folder_id INT, MODIFY issueAbstract MEDIUMTEXT;

ALTER TABLE measurementhistory MODIFY measurementValue FLOAT(12,2);

ALTER TABLE measurementinstance MODIFY measurementValue FLOAT(12,2);

ALTER TABLE metadatarule MODIFY conditions MEDIUMTEXT;

ALTER TABLE payloadmessage MODIFY extraMessage MEDIUMTEXT;

ALTER TABLE projectversion MODIFY serverVersion FLOAT(8,2);

ALTER TABLE projectversion_rule MODIFY ruleGuid VARCHAR(255) NOT NULL;

ALTER TABLE projectversion_rule DROP PRIMARY KEY;

ALTER TABLE projectversion_rule ADD PRIMARY KEY (projectVersion_id, rule_id, ruleGuid);

ALTER TABLE rule_t ADD tips MEDIUMTEXT, ADD refers MEDIUMTEXT;

ALTER TABLE requirementtemplateinstance MODIFY serverVersion FLOAT(8,2);

ALTER TABLE runtimeevent ADD requestHost VARCHAR(255), ADD requestPort INT, ADD federationName VARCHAR(255)
, MODIFY severity FLOAT(8, 2), DROP accuracy, DROP impact,DROP likelihood, DROP probability;

ALTER TABLE applicationassignmentrule ADD searchSpec MEDIUMTEXT;

UPDATE applicationassignmentrule SET searchSpec = concat(concat('<?xml version="1.0" encoding="UTF-8" standalone="yes"?><ns2:SearchSpec pageSize="0" startIndex="0" xmlns:ns2="xmlns://www.fortifysoftware.com/schema/wsTypes" xmlns:ns4="xmlns://www.fortify.com/schema/issuemanagement" xmlns:ns3="http://www.fortify.com/schema/fws" xmlns:ns5="xmlns://www.fortifysoftware.com/schema/activitytemplate" xmlns:ns6="xmlns://www.fortify.com/schema/audit" xmlns:ns7="xmlns://www.fortifysoftware.com/schema/seed" xmlns:ns8="xmlns://www.fortifysoftware.com/schema/runtime"><ns2:SearchCondition xsi:type="ns2:ConjunctionFilterCondition" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><ns2:Condition xsi:type="ns2:ContainsSearchCondition"><ns2:SearchConstant>RE_REQUEST_PATH</ns2:SearchConstant><ns2:StringCondition>',context),'</ns2:StringCondition></ns2:Condition></ns2:SearchCondition></ns2:SearchSpec>')
WHERE context IS NOT NULL AND context <>'';

ALTER TABLE applicationassignmentrule DROP context;

ALTER TABLE scan MODIFY serverVersion FLOAT(8, 2);

ALTER TABLE scan_issue MODIFY accuracy FLOAT(8, 2), MODIFY likelihood FLOAT(8, 2), MODIFY impact FLOAT(8, 2), MODIFY probability FLOAT(8, 2), MODIFY issueAbstract MEDIUMTEXT;

ALTER TABLE rule_t MODIFY rawDetail MEDIUMTEXT, MODIFY rawRecommendation MEDIUMTEXT, MODIFY rawRuleAbstract MEDIUMTEXT
, MODIFY detail MEDIUMTEXT, MODIFY recommendation MEDIUMTEXT, MODIFY ruleAbstract MEDIUMTEXT;

ALTER TABLE runtimealert MODIFY eventHandlerDescription MEDIUMTEXT;

ALTER TABLE runtimeevent MODIFY requestHeader MEDIUMTEXT, MODIFY requestParameter MEDIUMTEXT, MODIFY cookie MEDIUMTEXT, MODIFY triggeredBy MEDIUMTEXT;

ALTER TABLE stacktrace MODIFY traceBody MEDIUMTEXT;

CREATE TABLE hostinfo(
    host_id      INT              NOT NULL,
    attrName     VARCHAR(255)     NOT NULL,
    attrValue    VARCHAR(1024),
    seqNumber    INT,
    PRIMARY KEY (host_id, attrName)
)ENGINE=INNODB;

ALTER TABLE hostinfo ADD CONSTRAINT RefHostInfo
    FOREIGN KEY (host_id)
    REFERENCES host(id)  ON DELETE CASCADE;

DROP VIEW ruleview;

CREATE VIEW ruleview AS
SELECT p.projectVersion_id projectVersion_id, r.id id,  r.guid descGuid, p.ruleGuid ruleGuid, r.rulepack_id rulepack_id, t.lang lang,
t.detail detail, t.recommendation recommendation, t.ruleAbstract ruleAbstract,
t.rawDetail rawDetail, t.rawRecommendation rawRecommendation, t.rawRuleAbstract rawRuleAbstract, t.tips tips, t.refers refers
FROM ruledescription r, rule_t t, projectversion_rule p
where r.id = t.id AND p.rule_id = r.id;

UPDATE agentcredential SET action= concat(action,'GetSingleUseFPRUploadTokenRequest') WHERE action LIKE '%FPRUploadRequest%';

update issue i, defaultissueview di set i.hidden= di.hidden, i.folder_id = di.folder_id where i.id = di.id;

UPDATE f360global SET schemaVersion='3.0.0';

update runtimeevent r set federationName=(select f.federationName from federation f,host h where h.federation_id=f.id and h.id=r.host_id);

DROP VIEW defaultissueview;

CREATE VIEW defaultissueview AS
select  i.folder_id, i.id, i.issueinstanceid,     i.fileName,     i.shortFileName,     i.severity,     i.ruleGuid,     i.confidence,     i.kingdom,     i.issueType,     i.issueSubtype,     i.analyzer,     i.lineNumber,     i.taintFlag,     i.packageName,     i.functionName,     i.className,     i.issueAbstract,     i.friority,     i.engineType,     i.scanStatus,     i.audienceSet,     i.lastScan_id,     i.replaceStore,     i.snippetId,     i.url,     i.category,     i.source,     i.sourceContext,     i.sourceFile,     i.sink,     i.sinkContext,     i.userName,     i.owasp2004,     i.owasp2007,     i.cwe,     i.revision,     i.audited,     i.auditedTime,     i.suppressed,     i.findingGuid,     i.issueStatus,     i.issueState,     i.dynamicConfidence,     i.remediationConstant,     i.projectVersion_id projectVersion_id,     i.hidden, i.likelihood, i.impact, i.accuracy,i.wasc,i.sans25, i.stig, i.pci11, i.pci12, i.rtaCovered, i.probability
from issue i;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Custom SQL', 'EXECUTED', 'dbF360Mysql_2.6.0.xml', 'f360Mysql_2.6.0', '2.0.1', '3:e297bdb89a88818462926216078a2614', 8);

-- Changeset dbF360Mssql_2.6.0.xml::f360Mssql_2.6.0::hp::(Checksum: 3:97bfa8cef263a8047ae8d8fac1d03f33)
INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Custom SQL', 'MARK_RAN', 'dbF360Mssql_2.6.0.xml', 'f360Mssql_2.6.0', '2.0.1', '3:97bfa8cef263a8047ae8d8fac1d03f33', 9);

-- Changeset dbF360Oracle_2.6.0.xml::f360Oracle_2.6.0::hp::(Checksum: 3:d851f68eb9cbd5ba85a664e8f47b4232)
INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Custom SQL', 'MARK_RAN', 'dbF360Oracle_2.6.0.xml', 'f360Oracle_2.6.0', '2.0.1', '3:d851f68eb9cbd5ba85a664e8f47b4232', 10);

-- Changeset dbF360Db2_3.0.0.xml::f360Db2_3.0.0::hp::(Checksum: 3:ab050adb5b7dfe7baf25924f0747772d)
INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Custom SQL (x4)', 'MARK_RAN', 'dbF360Db2_3.0.0.xml', 'f360Db2_3.0.0', '2.0.1', '3:ab050adb5b7dfe7baf25924f0747772d', 11);

-- Changeset dbF360Derby_3.0.0.xml::f360Derby_3.0.0::hp::(Checksum: 3:3a131322bfbbca38e7646a9ca34fac03)
INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Custom SQL', 'MARK_RAN', 'dbF360Derby_3.0.0.xml', 'f360Derby_3.0.0', '2.0.1', '3:3a131322bfbbca38e7646a9ca34fac03', 12);

-- Changeset dbF360Mysql_3.0.0.xml::f360Mysql_3.0.0::hp::(Checksum: 3:7642608e9cbd6da2d362881971463f3f)
ALTER TABLE activity              ADD dueDate INT;

ALTER TABLE activity              ADD dueDateUnits VARCHAR(20);

ALTER TABLE activityinstance      ADD dueDate DATETIME;

ALTER TABLE alert                 ADD startAtDueDate         CHAR(1)          DEFAULT 'N';

ALTER TABLE alerthistory          ADD alertStartAtDueDate    CHAR(1)          DEFAULT 'N';

ALTER TABLE artifact MODIFY documentInfo_id INT NULL;

ALTER TABLE artifact              ADD approvalComment VARCHAR(2000);

ALTER TABLE artifact              ADD approvalUsername VARCHAR(255);

ALTER TABLE artifact              ADD approvalDate DATETIME;

ALTER TABLE artifact              ADD job_id INT;

ALTER TABLE artifact              ADD associatedDocInfo_id INT;

ALTER TABLE artifact              ADD uploadDate DATETIME;

CREATE TABLE assessmentsite(
    id                      INT              NOT NULL,
    account_id              INT,
    siteId                  INT,
    siteUrl                 VARCHAR(2000),
    webApiKey               VARCHAR(255),
    currentScanStatus       VARCHAR(255),
    lastProjectVersionId    INT,
    lastJobSpecId           INT,
    registerDate            DATETIME,
    lastAssocDate           DATETIME,
    state                   VARCHAR(255),
    name                    VARCHAR(255),
    scheduleType            VARCHAR(255),
    scheduleTime            DATETIME,
    PRIMARY KEY (id)
)ENGINE=INNODB;

ALTER TABLE attr MODIFY extensible CHAR(1) DEFAULT 'N';

ALTER TABLE attr ADD restriction VARCHAR(20) DEFAULT 'NONE';

ALTER TABLE attrlookup ADD description VARCHAR(2000);

CREATE TABLE correlationresult(
    issue_id             INT              NOT NULL,
    correlation_id       INT              NOT NULL,
    checksum             VARCHAR(255)     NOT NULL,
    projectVersion_id    INT              NOT NULL,
    correlationValue     VARCHAR(2000)    NOT NULL,
    engineType           VARCHAR(255),
    PRIMARY KEY (issue_id, correlation_id, checksum)
)ENGINE=INNODB;

CREATE TABLE correlationrule(
    id                INT              AUTO_INCREMENT,
    name              VARCHAR(255),
    guid              VARCHAR(255),
    description       VARCHAR(2000),
    ruleXml           TEXT,
    objectVersion     INT,
    publishVersion    INT,
    ruleType          VARCHAR(255),
    PRIMARY KEY (id)
)ENGINE=INNODB;

CREATE TABLE correlationset(
    issue_id              INT             NOT NULL,
    projectVersion_id     INT             NOT NULL,
    correlationSetGuid    VARCHAR(255),
    PRIMARY KEY (issue_id)
)ENGINE=INNODB;

ALTER TABLE dynamicassessment     ADD siteId INT;

ALTER TABLE dynamicassessment     ADD uploadUserName VARCHAR(120);

ALTER TABLE issue MODIFY taintFlag VARCHAR(1024);

ALTER TABLE issue                 ADD foundDate              BIGINT;

ALTER TABLE issue                 ADD removedDate            BIGINT;

ALTER TABLE issue                 ADD requestIdentifier      TEXT;

ALTER TABLE issue                 ADD requestHeader          TEXT;

ALTER TABLE issue                 ADD requestParameter       TEXT;

ALTER TABLE issue                 ADD requestBody            TEXT;

ALTER TABLE issue                 ADD requestMethod          VARCHAR(20);

ALTER TABLE issue                 ADD cookie                 TEXT;

ALTER TABLE issue                 ADD httpVersion            VARCHAR(20);

ALTER TABLE issue                 ADD attackPayload          TEXT;

ALTER TABLE issue                 ADD attackType             VARCHAR(20);

ALTER TABLE issue                 ADD response               MEDIUMTEXT;

ALTER TABLE issue                 ADD triggerDefinition      BLOB;

ALTER TABLE issue                 ADD triggerString          TEXT;

ALTER TABLE issue                 ADD triggerDisplayText     TEXT;

ALTER TABLE issue                 ADD secondaryRequest       TEXT;

ALTER TABLE issue                 ADD sourceLine             FLOAT(8, 0);

ALTER TABLE issue                 ADD mappedCategory         VARCHAR(512);

ALTER TABLE issue                 ADD owasp2010              VARCHAR(120);

ALTER TABLE issue                 ADD fisma                  VARCHAR(120);

ALTER TABLE issue                 ADD sans2010               VARCHAR(120);

ALTER TABLE issue                 ADD issueRecommendation    MEDIUMTEXT;

ALTER TABLE issue                 ADD correlated             CHAR(1)          DEFAULT 'N';

ALTER TABLE issue                 ADD correlationSetGuid     VARCHAR(255);

ALTER TABLE issue                 ADD tempInstanceId         VARCHAR(80);

ALTER TABLE issue                 ADD contextId              INT;

CREATE TABLE migrationhistory(
    serverVersion    FLOAT(8, 2)     NOT NULL,
    migrationTask    VARCHAR(255)    NOT NULL,
    PRIMARY KEY (serverVersion, migrationTask)
)ENGINE=INNODB;

ALTER TABLE payloadartifact       ADD uploadUserName         VARCHAR(120);

CREATE TABLE pref_page(
    id           INT              AUTO_INCREMENT,
    pref_id      INT              NOT NULL,
    seqNumber    INT,
    name         VARCHAR(4000),
    PRIMARY KEY (id)
)ENGINE=INNODB;

ALTER TABLE pref_pod              ADD page_id      INT;

ALTER TABLE pref_pod              ADD location     INT;

ALTER TABLE projecttemplate       ADD masterAttrGuid     VARCHAR(255);

ALTER TABLE projecttemplate       ADD defaultTemplate CHAR(1) DEFAULT 'N';

ALTER TABLE projectversion        ADD masterAttrGuid     VARCHAR(255);

CREATE TABLE projectversion_attr(
    projectVersion_id     INT             NOT NULL,
    attrGuid              VARCHAR(255)    NOT NULL,
    seqNumber             INT,
    PRIMARY KEY (projectVersion_id, attrGuid)
)ENGINE=INNODB;

INSERT INTO projectversion_attr(projectVersion_id, attrGuid, seqNumber)
(
SELECT pv.id, pta.attrGuid, pta.seqNumber
from projectversion pv INNER JOIN projecttemplate_attr pta on pta.projectTemplate_id = pv.projectTemplate_id
);

CREATE TABLE reportlibrary(
    id                 INT              AUTO_INCREMENT,
    name               VARCHAR(255)		NOT NULL,
    description        VARCHAR(2000),
    guid			   VARCHAR(255),
    fileDoc_id         INT              NOT NULL,
    objectVersion      INT,
    publishVersion     INT,
    PRIMARY KEY (id)
)ENGINE=INNODB;

ALTER TABLE requirement           ADD dueDate INT;

ALTER TABLE requirement           ADD dueDateUnits VARCHAR(20);

ALTER TABLE requirementinstance   ADD dueDate DATETIME;

ALTER TABLE requirementtemplate   ADD dueDate INT;

ALTER TABLE requirementtemplate   ADD dueDateUnits VARCHAR(20);

ALTER TABLE requirementtemplateinstance   ADD dueDate DATETIME;

ALTER TABLE runtimeevent          ADD systemEventType           VARCHAR(20);

ALTER TABLE runtimeevent          ADD guid                      VARCHAR(120);

ALTER TABLE runtimeevent          ADD configurationEventGuid    VARCHAR(120);

ALTER TABLE runtimeevent          ADD rawEventLog               BLOB;

ALTER TABLE runtimeevent          ADD suggestedAction           VARCHAR(255);

ALTER TABLE runtimesetting MODIFY content TEXT;

ALTER TABLE scan                  ADD entryName              VARCHAR(255);

ALTER TABLE scan_issue MODIFY taintFlag VARCHAR(1024);

ALTER TABLE scan_issue            ADD issue_id               INT;

ALTER TABLE scan_issue            ADD requestIdentifier      TEXT;

ALTER TABLE scan_issue            ADD requestHeader          TEXT;

ALTER TABLE scan_issue            ADD requestParameter       TEXT;

ALTER TABLE scan_issue            ADD requestBody            TEXT;

ALTER TABLE scan_issue            ADD requestMethod          VARCHAR(20);

ALTER TABLE scan_issue            ADD httpVersion            VARCHAR(20);

ALTER TABLE scan_issue            ADD cookie                 TEXT;

ALTER TABLE scan_issue            ADD attackPayload          TEXT;

ALTER TABLE scan_issue            ADD attackType             VARCHAR(20);

ALTER TABLE scan_issue            ADD response               MEDIUMTEXT;

ALTER TABLE scan_issue            ADD triggerDefinition      BLOB;

ALTER TABLE scan_issue            ADD triggerString          TEXT;

ALTER TABLE scan_issue            ADD triggerDisplayText     TEXT;

ALTER TABLE scan_issue            ADD secondaryRequest       TEXT;

ALTER TABLE scan_issue            ADD sourceLine             FLOAT(8, 0);

ALTER TABLE scan_issue            ADD mappedCategory         VARCHAR(512);

ALTER TABLE scan_issue            ADD owasp2010              VARCHAR(120);

ALTER TABLE scan_issue            ADD fisma                  VARCHAR(120);

ALTER TABLE scan_issue            ADD sans2010               VARCHAR(120);

ALTER TABLE scan_issue            ADD issueRecommendation    MEDIUMTEXT;

ALTER TABLE scan_issue            ADD contextId              INT;

ALTER TABLE taskinstance          ADD dueDate                DATETIME;

DROP VIEW auditvalueview;

CREATE VIEW auditvalueview AS
 SELECT a.projectVersion_id projectVersion_Id, a.issue_id issue_id, a.attrGuid attrGuid, a.attrValue lookupIndex, l.lookupValue lookupValue, attr.attrName attrName, attr.defaultValue, attr.hidden, l.seqNumber
 from auditvalue a, attr, attrlookup l
 where a.attrGuid=attr.guid and attr.id=l.attr_id and l.lookupIndex=a.attrValue;

DROP VIEW defaultissueview;

CREATE VIEW defaultissueview AS
select i.folder_id, i.id, i.issueInstanceId, i.fileName, i.shortFileName, i.severity, i.ruleGuid, i.confidence, i.kingdom, i.issueType, i.issueSubtype, i.analyzer, i.lineNumber, i.taintFlag, i.packageName, i.functionName, i.className, i.issueAbstract, i.issueRecommendation, i.friority, i.engineType, i.scanStatus, i.audienceSet, i.lastScan_id, i.replaceStore, i.snippetId, i.url, i.category, i.source, i.sourceContext, i.sourceFile, i.sink, i.sinkContext, i.userName, i.owasp2004, i.owasp2007, i.cwe, i.revision, i.audited, i.auditedTime, i.suppressed, i.findingGuid, i.issueStatus, i.issueState, i.dynamicConfidence, i.remediationConstant, i.projectVersion_id projectVersion_id, i.hidden, i.likelihood, i.impact, i.accuracy, i.wasc, i.sans25, i.stig, i.pci11, i.pci12, i.rtaCovered, i.probability, i.foundDate, i.removedDate, i.requestHeader, i.requestParameter, i.requestBody, i.attackPayload, i.attackType, i.response, i.triggerDefinition, i.triggerString, i.triggerDisplayText, i.secondaryRequest, i.sourceLine, i.requestMethod, i.httpVersion, i.cookie, i.mappedCategory, i.owasp2010, i.fisma, i.sans2010, i.correlated
from issue i;

CREATE OR REPLACE VIEW view_standards AS
 select i.folder_id, i.id, i.issueInstanceId, i.fileName, i.shortFileName, i.severity, i.ruleGuid, i.confidence, i.kingdom, i.issueType, i.issueSubtype, i.analyzer, i.lineNumber, i.taintFlag, i.packageName, i.functionName, i.className, i.issueAbstract, i.issueRecommendation, i.friority, i.engineType, i.scanStatus, i.audienceSet, i.lastScan_id, i.replaceStore, i.snippetId, i.url, i.category, i.source, i.sourceContext, i.sourceFile, i.sink, i.sinkContext, i.userName, i.owasp2004, i.owasp2007, i.cwe, i.revision, i.audited, i.auditedTime, i.suppressed, i.findingGuid, i.issueStatus, i.issueState, i.dynamicConfidence, i.remediationConstant, i.projectVersion_id projectVersion_id, i.hidden, i.likelihood, i.impact, i.accuracy, i.wasc, i.sans25 AS sans2009, i.stig, i.pci11, i.pci12, i.rtaCovered, i.probability, i.foundDate, i.removedDate, i.requestHeader, i.requestParameter, i.requestBody, i.attackPayload, i.attackType, i.response, i.triggerDefinition, i.triggerString, i.triggerDisplayText, i.secondaryRequest, i.sourceLine, i.requestMethod, i.httpVersion, i.cookie, i.mappedCategory, i.owasp2010, i.fisma AS fips200, i.sans2010, i.correlated
 from defaultissueview i
 where i.hidden='N' and i.suppressed='N' and i.scanStatus <> 'REMOVED' AND ((i.owasp2010 IS NOT NULL and upper(i.owasp2010) <> 'NONE') OR (i.fisma IS NOT NULL AND upper(i.fisma) <> 'NONE') OR (i.sans25 IS NOT NULL AND upper(i.sans25) <> 'NONE') OR (i.sans2010 IS NOT NULL AND upper(i.sans2010) <> 'NONE'));

CREATE UNIQUE INDEX assessmentsite_id_index ON assessmentsite(siteId);

CREATE INDEX correlationSetIndex ON correlationset(projectVersion_id, correlationSetGuid);

DROP INDEX Issue_Alt_Key ON issue;

CREATE UNIQUE INDEX Issue_Alt_Key ON issue(projectVersion_id, issueInstanceId, engineType);

CREATE INDEX tempInstanceId_Key ON issue(projectVersion_id, tempInstanceId);

CREATE UNIQUE INDEX RL_NAME_INDEX ON reportlibrary(name);

CREATE INDEX scanissueidkey ON scan_issue(issue_id, scan_id);

ALTER TABLE analysisblob DROP PRIMARY KEY;

ALTER TABLE correlationresult ADD CONSTRAINT Refprojectversion871
    FOREIGN KEY (projectVersion_id)
    REFERENCES projectversion(id) ON DELETE CASCADE;

ALTER TABLE correlationset ADD CONSTRAINT Refprojectversion882
    FOREIGN KEY (projectVersion_id)
    REFERENCES projectversion(id) ON DELETE CASCADE;

ALTER TABLE pref_page ADD CONSTRAINT ref_pref_page
    FOREIGN KEY (pref_id)
    REFERENCES userpreference(id);

ALTER TABLE projectversion_attr ADD CONSTRAINT RefPVPVAttr
    FOREIGN KEY (projectVersion_id)
    REFERENCES projectversion(id) ON DELETE CASCADE;

DROP PROCEDURE updateExistingWithLatest;

DROP PROCEDURE updateDeletedIssues;

DROP PROCEDURE updateRemovedWithUpload;

DELIMITER //
CREATE PROCEDURE updateExistingWithLatest(p_scan_id INT,p_projectVersion_Id INT, p_engineType varchar(20))BEGIN
        UPDATE issue issue, scan_issue si SET issue.lastScan_Id= si.scan_id
        , issue.shortFileName=si.shortFileName, issue.fileName=si.fileName, issue.severity=si.severity, issue.confidence=si.confidence, issue.kingdom=si.kingdom, issue.issueType=si.issueType
        , issue.issueSubtype=si.issueSubtype, issue.analyzer=si.analyzer, issue.engineType=si.engineType, issue.lineNumber=si.lineNumber, issue.taintFlag=si.taintFlag, issue.packageName=si.packageName
        , issue.functionName=si.functionName, issue.className=si.className, issue.issueAbstract=si.issueAbstract, issue.issueRecommendation=si.issueRecommendation, issue.friority=si.friority, issue.replaceStore=si.replaceStore
        , issue.ruleGuid=si.ruleGuid, issue.snippetId=si.snippetId, issue.contextId=si.contextId, issue.category=si.category, issue.url=si.url, issue.source=si.source, issue.sourceContext=si.sourceContext, issue.sink=si.sink
        , issue.sinkContext=si.sinkContext, issue.sourceFile=si.sourceFile, issue.audienceSet=si.audienceSet, issue.owasp2004=si.owasp2004, issue.owasp2007=si.owasp2007, issue.cwe=si.cwe
        , issue.scanStatus = (CASE WHEN scanStatus='REMOVED' THEN 'REINTRODUCED' ELSE 'UPDATED' END)
        , issue.findingGuid = si.findingGuid, issue.remediationConstant=si.remediationConstant,issue.likelihood=si.likelihood,issue.impact=si.impact, issue.accuracy=si.accuracy
        , issue.sans25=si.sans25, issue.wasc=si.wasc, issue.stig=si.stig, issue.pci11=si.pci11, issue.pci12=si.pci12, issue.rtaCovered=si.rtaCovered,issue.probability=si.probability
		, issue.requestIdentifier=si.requestIdentifier, issue.requestHeader=si.requestHeader, issue.requestParameter=si.requestParameter, issue.requestBody=si.requestBody, issue.requestMethod=si.requestMethod
		, issue.cookie=si.cookie, issue.httpVersion=si.httpVersion, issue.attackPayload=si.attackPayload, issue.attackType=si.attackType, issue.response=si.response, issue.triggerDefinition=si.triggerDefinition, issue.triggerString=si.triggerString
		, issue.triggerDisplayText=si.triggerDisplayText, issue.secondaryRequest=si.secondaryRequest, issue.sourceLine=si.sourceLine, issue.mappedCategory=si.mappedCategory, issue.owasp2010=si.owasp2010, issue.fisma=si.fisma, issue.sans2010=si.sans2010
        WHERE issue.projectVersion_Id = p_projectVersion_Id AND issue.engineType= p_engineType AND si.issueInstanceId=issue.issueInstanceId AND si.scan_id= p_scan_id;

END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE updateDeletedIssues(p_scan_id INT,p_previous_scan_id INT, p_projectVersion_Id INT)BEGIN
        UPDATE issue issue, scan_issue si SET issue.lastScan_Id= si.scan_id
        , issue.shortFileName=si.shortFileName, issue.fileName=si.fileName, issue.severity=si.severity, issue.confidence=si.confidence, issue.kingdom=si.kingdom, issue.issueType=si.issueType
        , issue.issueSubtype=si.issueSubtype, issue.analyzer=si.analyzer, issue.engineType=si.engineType, issue.lineNumber=si.lineNumber, issue.taintFlag=si.taintFlag, issue.packageName=si.packageName
        , issue.functionName=si.functionName, issue.className=si.className, issue.issueAbstract=si.issueAbstract, issue.issueRecommendation=si.issueRecommendation, issue.friority=si.friority, issue.replaceStore=si.replaceStore
        , issue.ruleGuid=si.ruleGuid, issue.snippetId=si.snippetId, issue.contextId=si.contextId, issue.category=si.category, issue.url=si.url, issue.source=si.source, issue.sourceContext=si.sourceContext, issue.sink=si.sink
        , issue.sinkContext=si.sinkContext, issue.sourceFile=si.sourceFile, issue.audienceSet=si.audienceSet, issue.owasp2004=si.owasp2004, issue.owasp2007=si.owasp2007, issue.cwe=si.cwe
        , issue.scanStatus = (CASE WHEN scanStatus='REMOVED' THEN 'REINTRODUCED' ELSE 'UPDATED' END)
        , issue.findingGuid = si.findingGuid, issue.remediationConstant=si.remediationConstant,issue.likelihood=si.likelihood,issue.impact=si.impact, issue.accuracy=si.accuracy
        , issue.sans25=si.sans25, issue.wasc=si.wasc, issue.stig=si.stig, issue.pci11=si.pci11, issue.pci12=si.pci12, issue.rtaCovered=si.rtaCovered,issue.probability=si.probability
		, issue.requestIdentifier=si.requestIdentifier, issue.requestHeader=si.requestHeader, issue.requestParameter=si.requestParameter, issue.requestBody=si.requestBody, issue.requestMethod=si.requestMethod
		, issue.cookie=si.cookie, issue.httpVersion=si.httpVersion, issue.attackPayload=si.attackPayload, issue.attackType=si.attackType, issue.response=si.response, issue.triggerDefinition=si.triggerDefinition, issue.triggerString=si.triggerString
		, issue.triggerDisplayText=si.triggerDisplayText, issue.secondaryRequest=si.secondaryRequest, issue.sourceLine=si.sourceLine, issue.mappedCategory=si.mappedCategory, issue.owasp2010=si.owasp2010, issue.fisma=si.fisma, issue.sans2010=si.sans2010
        WHERE issue.projectVersion_Id = p_projectVersion_Id AND issue.lastScan_id= p_scan_id AND si.issue_id=issue.id AND si.scan_id= p_previous_scan_id;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE updateRemovedWithUpload(p_scan_id INT,p_projectVersion_Id INT, p_engineType varchar(20), p_scanDate BIGINT)BEGIN
        UPDATE issue issue, scan_issue si, scan scan SET issue.lastScan_Id= si.scan_id
        , issue.shortFileName=si.shortFileName, issue.fileName=si.fileName, issue.severity=si.severity, issue.confidence=si.confidence, issue.kingdom=si.kingdom, issue.issueType=si.issueType
        , issue.issueSubtype=si.issueSubtype, issue.analyzer=si.analyzer, issue.engineType=si.engineType, issue.lineNumber=si.lineNumber, issue.taintFlag=si.taintFlag, issue.packageName=si.packageName
        , issue.functionName=si.functionName, issue.className=si.className, issue.issueAbstract=si.issueAbstract, issue.issueRecommendation=si.issueRecommendation, issue.friority=si.friority, issue.replaceStore=si.replaceStore
        , issue.ruleGuid=si.ruleGuid, issue.snippetId=si.snippetId, issue.contextId=si.contextId, issue.category=si.category, issue.url=si.url, issue.source=si.source, issue.sourceContext=si.sourceContext, issue.sink=si.sink
        , issue.sinkContext=si.sinkContext, issue.sourceFile=si.sourceFile, issue.audienceSet=si.audienceSet, issue.owasp2004=si.owasp2004, issue.owasp2007=si.owasp2007, issue.cwe=si.cwe
        , issue.findingGuid = si.findingGuid, issue.remediationConstant=si.remediationConstant,issue.likelihood=si.likelihood,issue.impact=si.impact, issue.accuracy=si.accuracy
        , issue.sans25=si.sans25, issue.wasc=si.wasc, issue.stig=si.stig, issue.pci11=si.pci11, issue.pci12=si.pci12, issue.rtaCovered=si.rtaCovered,issue.probability=si.probability
		, issue.requestIdentifier=si.requestIdentifier, issue.requestHeader=si.requestHeader, issue.requestParameter=si.requestParameter, issue.requestBody=si.requestBody, issue.requestMethod=si.requestMethod
		, issue.cookie=si.cookie, issue.httpVersion=si.httpVersion, issue.attackPayload=si.attackPayload, issue.attackType=si.attackType, issue.response=si.response, issue.triggerDefinition=si.triggerDefinition, issue.triggerString=si.triggerString
		, issue.triggerDisplayText=si.triggerDisplayText, issue.secondaryRequest=si.secondaryRequest, issue.sourceLine=si.sourceLine, issue.mappedCategory=si.mappedCategory, issue.owasp2010=si.owasp2010, issue.fisma=si.fisma, issue.sans2010=si.sans2010
        WHERE issue.projectVersion_Id = p_projectVersion_Id AND issue.engineType= p_engineType AND si.issueInstanceId=issue.issueInstanceId AND si.scan_id= p_scan_id AND issue.scanStatus='REMOVED' AND
        issue.lastScan_id = scan.id and scan.startDate < p_scanDate;

END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE updateScanIssueIds(p_scan_id INT,p_projectVersion_Id INT, p_engineType varchar(20))BEGIN
        UPDATE scan_issue si, issue issue SET si.issue_id=issue.id
        WHERE issue.projectVersion_Id = p_projectVersion_Id AND issue.engineType= p_engineType
        AND si.issueInstanceId=issue.issueInstanceId AND si.scan_id= p_scan_id;

END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE migrateScanIssueIds(p_scan_id INT,p_projectVersion_Id INT, p_engineType varchar(20))BEGIN
        UPDATE scan_issue si, issue issue SET si.issue_id=issue.id
        WHERE issue.projectVersion_Id = p_projectVersion_Id AND issue.engineType= p_engineType
        AND si.issueInstanceId=issue.tempInstanceId AND si.scan_id= p_scan_id;

END//
DELIMITER ;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Custom SQL (x2)', 'EXECUTED', 'dbF360Mysql_3.0.0.xml', 'f360Mysql_3.0.0', '2.0.1', '3:7642608e9cbd6da2d362881971463f3f', 13);

-- Changeset dbF360Mssql_3.0.0.xml::f360Mssql_3.0.0::hp::(Checksum: 3:3c335330e14e9489ea3d044814345c6e)
INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Custom SQL', 'MARK_RAN', 'dbF360Mssql_3.0.0.xml', 'f360Mssql_3.0.0', '2.0.1', '3:3c335330e14e9489ea3d044814345c6e', 14);

-- Changeset dbF360Oracle_3.0.0.xml::f360Oracle_3.0.0::hp::(Checksum: 3:d19f76cd05148b66bfcb7712a7ba2809)
INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Custom SQL, Create Procedure (x5), Custom SQL', 'MARK_RAN', 'dbF360Oracle_3.0.0.xml', 'f360Oracle_3.0.0', '2.0.1', '3:d19f76cd05148b66bfcb7712a7ba2809', 15);

-- Changeset dbF360Db2_3.1.0.xml::f360Db2_3.1.0::hp::(Checksum: 3:e74eabfbc46f9b496382850d8698dded)
INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Custom SQL', 'MARK_RAN', 'dbF360Db2_3.1.0.xml', 'f360Db2_3.1.0', '2.0.1', '3:e74eabfbc46f9b496382850d8698dded', 16);

-- Changeset dbF360Derby_3.1.0.xml::f360Derby_3.1.0::hp::(Checksum: 3:0b2e391a58e13250224fda9c61ae3f22)
INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Custom SQL', 'MARK_RAN', 'dbF360Derby_3.1.0.xml', 'f360Derby_3.1.0', '2.0.1', '3:0b2e391a58e13250224fda9c61ae3f22', 17);

-- Changeset dbF360Mysql_3.1.0.xml::f360Mysql_3.1.0::hp::(Checksum: 3:1b71ae765d9c633db7514917d31b9823)
ALTER TABLE runtimeapplication ADD eventState VARCHAR(20);

UPDATE runtimeapplication SET eventState = 'UPDATED';

DROP INDEX RE_DATE ON runtimeevent;

CREATE INDEX RE_RA ON runtimeevent(runtimeApplication_id);

ALTER TABLE sourcefilemap MODIFY crossRef LONGBLOB;

ALTER TABLE projectversion ADD tracesOutOfDate CHAR(1) DEFAULT 'N';

UPDATE projectversion SET tracesOutOfDate = 'Y';

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Custom SQL', 'EXECUTED', 'dbF360Mysql_3.1.0.xml', 'f360Mysql_3.1.0', '2.0.1', '3:1b71ae765d9c633db7514917d31b9823', 18);

-- Changeset dbF360Mssql_3.1.0.xml::f360Mssql_3.1.0::hp::(Checksum: 3:51178bbade0a6cebced1889fe894f00f)
INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Custom SQL', 'MARK_RAN', 'dbF360Mssql_3.1.0.xml', 'f360Mssql_3.1.0', '2.0.1', '3:51178bbade0a6cebced1889fe894f00f', 19);

-- Changeset dbF360Oracle_3.1.0.xml::f360Oracle_3.1.0::hp::(Checksum: 3:2cc7fbec05d9cda4733c01fc2a737da3)
INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Custom SQL', 'MARK_RAN', 'dbF360Oracle_3.1.0.xml', 'f360Oracle_3.1.0', '2.0.1', '3:2cc7fbec05d9cda4733c01fc2a737da3', 20);

-- Changeset dbF360_3.2.0.xml::f360_3.2.0_0::hp::(Checksum: 3:64e12505977954036d72a515afdc960f)
ALTER TABLE `permission` ADD `userOnly` CHAR(1);

ALTER TABLE `permissiontemplate` DROP COLUMN `sortOrder`;

ALTER TABLE `permissiontemplate` DROP COLUMN `userOnly`;

ALTER TABLE `permissiontemplate` ADD `guid` VARCHAR(255);

ALTER TABLE `permissiontemplate` ADD `description` VARCHAR(2000);

ALTER TABLE `permissiontemplate` ADD `allApplicationRole` CHAR(1) DEFAULT 'N';

ALTER TABLE `permissiontemplate` ADD `objectVersion` INT;

ALTER TABLE `permissiontemplate` ADD `publishVersion` INT;

UPDATE `permissiontemplate` SET `guid` = 'admin', `name` = 'Administrator' WHERE name='admin';

UPDATE `permissiontemplate` SET `guid` = 'securitylead', `name` = 'Security Lead' WHERE name='securitylead';

UPDATE `permissiontemplate` SET `guid` = 'manager', `name` = 'Manager' WHERE name='manager';

UPDATE `permissiontemplate` SET `guid` = 'developer', `name` = 'Developer' WHERE name='developer';

UPDATE `permissiontemplate` SET `objectVersion` = 1, `publishVersion` = 1;

ALTER TABLE `projectversion` ADD `obfuscatedId` VARCHAR(255);

ALTER TABLE `projectversion` ADD `businessAttrOutstanding` CHAR(1);

ALTER TABLE `projectversion` ADD `technicalAttrOutstanding` CHAR(1);

ALTER TABLE `projectversion` ADD `creationState` VARCHAR(64);

UPDATE `projectversion` SET `businessAttrOutstanding` = 'N', `technicalAttrOutstanding` = 'N';

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Add Column, Drop Column (x2), Add Column, Update Data (x5), Add Column (x4), Update Data', 'EXECUTED', 'dbF360_3.2.0.xml', 'f360_3.2.0_0', '2.0.1', '3:64e12505977954036d72a515afdc960f', 21);

-- Changeset dbF360_3.2.0.xml::f360_3.2.0_1::hp::(Checksum: 3:7ebc070111a58c7db93f0e1b0622890b)
CREATE TABLE `permissiongroup` (`id` INT AUTO_INCREMENT  NOT NULL, `guid` VARCHAR(255) NOT NULL, `name` VARCHAR(255) NOT NULL, `description` VARCHAR(2000), `assignByDefault` CHAR(1) DEFAULT 'N', `objectVersion` INT, `publishVersion` INT, CONSTRAINT `PK_PERMISSIONGROUP` PRIMARY KEY (`id`)) engine innodb;

CREATE TABLE `pg_permission` (`pg_id` INT NOT NULL, `permission_id` INT NOT NULL, CONSTRAINT `PK_PG_PERMISSION` PRIMARY KEY (`pg_id`, `permission_id`)) engine innodb;

CREATE TABLE `pt_pg` (`pt_id` INT NOT NULL, `pg_id` INT NOT NULL, CONSTRAINT `PK_PT_PG` PRIMARY KEY (`pt_id`, `pg_id`)) engine innodb;

CREATE TABLE `permissiongroup_dependants` (`permissionGroup_id` INT NOT NULL, `dependsOn_id` INT NOT NULL, CONSTRAINT `PK_PERMISSIONGROUP_DEPENDANTS` PRIMARY KEY (`permissionGroup_id`, `dependsOn_id`)) engine innodb;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Create Table (x4)', 'EXECUTED', 'dbF360_3.2.0.xml', 'f360_3.2.0_1', '2.0.1', '3:7ebc070111a58c7db93f0e1b0622890b', 22);

-- Changeset dbF360_3.2.0.xml::f360_3.2.0_2::hp::(Checksum: 3:87dd4fb9f4c415fbcab472fcbbfc402a)
CREATE UNIQUE INDEX `pt_guid_idx` ON `permissiontemplate`(`guid`);

CREATE UNIQUE INDEX `pg_guid_idx` ON `permissiongroup`(`guid`);

CREATE UNIQUE INDEX `pg_name_idx` ON `permissiongroup`(`name`);

ALTER TABLE `pg_permission` ADD CONSTRAINT `RefPGPerPG` FOREIGN KEY (`pg_id`) REFERENCES `permissiongroup` (`id`) ON DELETE CASCADE;

ALTER TABLE `pg_permission` ADD CONSTRAINT `RefPGPerPer` FOREIGN KEY (`permission_id`) REFERENCES `permission` (`id`) ON DELETE CASCADE;

ALTER TABLE `pt_pg` ADD CONSTRAINT `RefPTPG_PT` FOREIGN KEY (`pt_id`) REFERENCES `permissiontemplate` (`id`) ON DELETE CASCADE;

ALTER TABLE `pt_pg` ADD CONSTRAINT `RefPTPG_PG` FOREIGN KEY (`pg_id`) REFERENCES `permissiongroup` (`id`) ON DELETE CASCADE;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Create Index (x3), Add Foreign Key Constraint (x4)', 'EXECUTED', 'dbF360_3.2.0.xml', 'f360_3.2.0_2', '2.0.1', '3:87dd4fb9f4c415fbcab472fcbbfc402a', 23);

-- Changeset dbF360_3.4.0.xml::f360_3.4.0_0::hp::(Checksum: 3:ccba3749333641cf583696fd52280149)
CREATE TABLE `bugtrackerconfig` (`id` INT AUTO_INCREMENT  NOT NULL, `identifier` VARCHAR(255) NOT NULL, `value` VARCHAR(255), `projectVersionId` INT NOT NULL, CONSTRAINT `PK_BUGTRACKERCONFIG` PRIMARY KEY (`id`)) engine innodb;

CREATE TABLE `bug` (`id` INT AUTO_INCREMENT  NOT NULL, `externalBugId` VARCHAR(255) NOT NULL, CONSTRAINT `PK_BUG` PRIMARY KEY (`id`)) engine innodb;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Create Table (x2)', 'EXECUTED', 'dbF360_3.4.0.xml', 'f360_3.4.0_0', '2.0.1', '3:ccba3749333641cf583696fd52280149', 24);

-- Changeset dbF360_3.4.0.xml::f360_3.4.0_1::hp::(Checksum: 3:f1ce02554d5284c297d1def852159444)
ALTER TABLE `projectversion` ADD `bugTrackerPluginId` VARCHAR(255);

ALTER TABLE `issue` ADD `bug_id` INT;

ALTER TABLE `bugtrackerconfig` ADD CONSTRAINT `fk_bugtc_projectversion` FOREIGN KEY (`projectVersionId`) REFERENCES `projectversion` (`id`);

ALTER TABLE `issue` ADD CONSTRAINT `fk_issue_bug` FOREIGN KEY (`bug_id`) REFERENCES `bug` (`id`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Add Column (x2), Add Foreign Key Constraint (x2)', 'EXECUTED', 'dbF360_3.4.0.xml', 'f360_3.4.0_1', '2.0.1', '3:f1ce02554d5284c297d1def852159444', 25);

-- Changeset dbF360_3.4.0.xml::f360_3.4.0_2::hp::(Checksum: 3:cfd08e57e94e8e78f2565db753a9e704)
ALTER TABLE `issue` ADD `pci20` VARCHAR(120);

ALTER TABLE `scan_issue` ADD `pci20` VARCHAR(120);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Add Column (x2)', 'EXECUTED', 'dbF360_3.4.0.xml', 'f360_3.4.0_2', '2.0.1', '3:cfd08e57e94e8e78f2565db753a9e704', 26);

-- Changeset dbF360_3.4.0.xml::f360_3.4.0_3::hp::(Checksum: 3:889c9e988c8d04d15453e28efd6cb33e)
ALTER TABLE `issue` ADD `attackTriggerDefinition` MEDIUMBLOB;

ALTER TABLE `issue` ADD `vulnerableParameter` VARCHAR(100);

ALTER TABLE `issue` ADD `reproStepDefinition` MEDIUMBLOB;

ALTER TABLE `issue` ADD `stackTrace` MEDIUMTEXT;

ALTER TABLE `issue` ADD `stackTraceTriggerDisplayText` VARCHAR(255);

ALTER TABLE `scan_issue` ADD `attackTriggerDefinition` MEDIUMBLOB;

ALTER TABLE `scan_issue` ADD `vulnerableParameter` VARCHAR(100);

ALTER TABLE `scan_issue` ADD `reproStepDefinition` MEDIUMBLOB;

ALTER TABLE `scan_issue` ADD `stackTrace` MEDIUMTEXT;

ALTER TABLE `scan_issue` ADD `stackTraceTriggerDisplayText` VARCHAR(255);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Add Column (x2)', 'EXECUTED', 'dbF360_3.4.0.xml', 'f360_3.4.0_3', '2.0.1', '3:889c9e988c8d04d15453e28efd6cb33e', 27);

-- Changeset dbF360_3.4.0.xml::f360_3.4.0_4::hp::(Checksum: 3:6aee33264bf3182b068304a3a95bed8e)
CREATE TABLE `auditattachment` (`id` INT AUTO_INCREMENT  NOT NULL, `guid` VARCHAR(255) NOT NULL, `issue_id` INT NOT NULL, `documentInfo_id` INT NOT NULL, `attachmentType` VARCHAR(40) NOT NULL, `description` VARCHAR(2000), CONSTRAINT `PK_AUDITATTACHMENT` PRIMARY KEY (`id`)) engine innodb;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Create Table', 'EXECUTED', 'dbF360_3.4.0.xml', 'f360_3.4.0_4', '2.0.1', '3:6aee33264bf3182b068304a3a95bed8e', 28);

-- Changeset dbF360_3.4.0.xml::f360_3.4.0_5::hp::(Checksum: 3:563d8b76ffc1ebccec42900116a1d31f)
ALTER TABLE `auditattachment` ADD CONSTRAINT `RefIssueAuditAttach` FOREIGN KEY (`issue_id`) REFERENCES `issue` (`id`) ON DELETE CASCADE;

ALTER TABLE `auditattachment` ADD CONSTRAINT `RefDocInfoAuditAttach` FOREIGN KEY (`documentInfo_id`) REFERENCES `documentinfo` (`id`) ON DELETE CASCADE;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Add Foreign Key Constraint (x2)', 'EXECUTED', 'dbF360_3.4.0.xml', 'f360_3.4.0_5', '2.0.1', '3:563d8b76ffc1ebccec42900116a1d31f', 29);

-- Changeset dbF360_3.4.0.xml::f360_3.4.0_6::hp::(Checksum: 3:42dd37fb981cb84f623bc9d9a24a62cf)
ALTER TABLE `projectversion` ADD `attachmentsOutOfDate` CHAR(1) DEFAULT 'N';

UPDATE `projectversion` SET `attachmentsOutOfDate` = 'N';

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Add Column, Update Data', 'EXECUTED', 'dbF360_3.4.0.xml', 'f360_3.4.0_6', '2.0.1', '3:42dd37fb981cb84f623bc9d9a24a62cf', 30);

-- Changeset dbF360Mssql_3.4.0.xml::f360Mssql_3.4.0_1::hp::(Checksum: 3:ad6b4bde35256ef12b45f68a11a7cf41)
INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Custom SQL', 'MARK_RAN', 'dbF360Mssql_3.4.0.xml', 'f360Mssql_3.4.0_1', '2.0.1', '3:ad6b4bde35256ef12b45f68a11a7cf41', 31);

-- Changeset dbF360_3.4.0.xml::f360_3.4.0_8::hp::(Checksum: 3:dfe7e6200fca8266c1b73dde9e5753e1)
ALTER TABLE `agentcredential` ADD `tempContent` MEDIUMTEXT;

UPDATE `agentcredential` SET `tempContent` = action;

ALTER TABLE `agentcredential` DROP COLUMN `action`;

ALTER TABLE `agentcredential` ADD `action` MEDIUMTEXT;

UPDATE `agentcredential` SET `action` = tempContent;

ALTER TABLE `agentcredential` DROP COLUMN `tempContent`;

ALTER TABLE `artifact` ADD `tempMessages` MEDIUMTEXT;

UPDATE `artifact` SET `tempMessages` = messages;

ALTER TABLE `artifact` DROP COLUMN `messages`;

ALTER TABLE `artifact` ADD `messages` MEDIUMTEXT;

UPDATE `artifact` SET `messages` = tempMessages;

ALTER TABLE `artifact` DROP COLUMN `tempMessages`;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Add Column, Update Data, Drop Column, Add Column, Update Data, Drop Column, Add Column, Update Data, Drop Column, Add Column, Update Data, Drop Column', 'EXECUTED', 'dbF360_3.4.0.xml', 'f360_3.4.0_8', '2.0.1', '3:dfe7e6200fca8266c1b73dde9e5753e1', 32);

-- Changeset dbF360_3.5.0.xml::f360_3.5.0_0::hp::(Checksum: 3:6fb7a61d1c84a68dc5c71f11761bc639)
ALTER TABLE `bugtrackerconfig` ADD `tempProjectVersionId` INT;

UPDATE `bugtrackerconfig` SET `tempProjectVersionId` = projectVersionId;

ALTER TABLE `bugtrackerconfig` DROP FOREIGN KEY `fk_bugtc_projectversion`;

ALTER TABLE `bugtrackerconfig` DROP COLUMN `projectVersionId`;

ALTER TABLE `bugtrackerconfig` ADD `projectVersion_Id` INT NOT NULL DEFAULT 1;

UPDATE `bugtrackerconfig` SET `projectVersion_Id` = tempProjectVersionId;

ALTER TABLE `bugtrackerconfig` DROP COLUMN `tempProjectVersionId`;

ALTER TABLE `bugtrackerconfig` ADD CONSTRAINT `fk_bugtc_projectversion` FOREIGN KEY (`projectVersion_Id`) REFERENCES `projectversion` (`id`) ON DELETE CASCADE;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Add Column, Update Data, Drop Foreign Key Constraint, Drop Column, Add Column, Update Data, Drop Column, Add Foreign Key Constraint', 'EXECUTED', 'dbF360_3.5.0.xml', 'f360_3.5.0_0', '2.0.1', '3:6fb7a61d1c84a68dc5c71f11761bc639', 33);

-- Changeset dbF360_3.5.0.xml::f360_3.5.0_2::hp::(Checksum: 3:7f2abbee68e08fea499e72ee73dd0a31)
CREATE TABLE `projectversioncreation` (`projectVersion_id` INT NOT NULL, `previousProjectVersion_id` INT, `copyAnalysisProcessingRules` CHAR(1) DEFAULT 'N', `copyBugTrackerConfiguration` CHAR(1) DEFAULT 'N', `copyCurrentStateFpr` CHAR(1) DEFAULT 'N', `copyCustomTags` CHAR(1) DEFAULT 'N', `copyProjectVersionAttributes` CHAR(1) DEFAULT 'N', `copyUserAssignment` CHAR(1) DEFAULT 'N', CONSTRAINT `PK_PROJECTVERSIONCREATION` PRIMARY KEY (`projectVersion_id`)) engine innodb;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Create Table', 'EXECUTED', 'dbF360_3.5.0.xml', 'f360_3.5.0_2', '2.0.1', '3:7f2abbee68e08fea499e72ee73dd0a31', 34);

-- Changeset dbF360_3.5.0.xml::f360_3.5.0_3::hp::(Checksum: 3:827e9cf7fe04e3e8e8970774a298e02c)
ALTER TABLE `projectversioncreation` ADD CONSTRAINT `fk_pvcreate_projectversion` FOREIGN KEY (`projectVersion_id`) REFERENCES `projectversion` (`id`);

ALTER TABLE `projectversioncreation` ADD CONSTRAINT `fk_oldpvcreate_projectversion` FOREIGN KEY (`previousProjectVersion_id`) REFERENCES `projectversion` (`id`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Add Foreign Key Constraint (x2)', 'EXECUTED', 'dbF360_3.5.0.xml', 'f360_3.5.0_3', '2.0.1', '3:827e9cf7fe04e3e8e8970774a298e02c', 35);

-- Changeset dbF360_3.5.0.xml::f360_3.5.0_4::hp::(Checksum: 3:974510700f2b1397ddfcd125ed502ace)
ALTER TABLE `projectversion` ADD `projectTemplateModifiedTime` BIGINT;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Add Column', 'EXECUTED', 'dbF360_3.5.0.xml', 'f360_3.5.0_4', '2.0.1', '3:974510700f2b1397ddfcd125ed502ace', 36);

-- Changeset dbF360_3.5.0.xml::f360_3.5.0_5::hp::(Checksum: 3:5f41bcf7701faec417d9f32362cfd83f)
ALTER TABLE `issue` MODIFY `shortFileName` VARCHAR(500);

ALTER TABLE `scan_issue` MODIFY `shortFileName` VARCHAR(500);

ALTER TABLE `issue` MODIFY `sink` VARCHAR(2000);

ALTER TABLE `scan_issue` MODIFY `sink` VARCHAR(2000);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Modify data type (x4)', 'EXECUTED', 'dbF360_3.5.0.xml', 'f360_3.5.0_5', '2.0.1', '3:5f41bcf7701faec417d9f32362cfd83f', 37);

-- Changeset dbF360_3.5.0.xml::f360_3.5.0_6::hp::(Checksum: 3:de33ba3f6daa8a5bc7023673805a3240)
ALTER TABLE `issue` DROP FOREIGN KEY `fk_issue_bug`;

ALTER TABLE `issue` ADD CONSTRAINT `fk_issue_bug` FOREIGN KEY (`bug_id`) REFERENCES `bug` (`id`) ON DELETE CASCADE;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Drop Foreign Key Constraint, Add Foreign Key Constraint', 'EXECUTED', 'dbF360_3.5.0.xml', 'f360_3.5.0_6', '2.0.1', '3:de33ba3f6daa8a5bc7023673805a3240', 38);

-- Changeset dbF360_3.51.0.xml::f360_3.51.0_0::hp::(Checksum: 3:4f0e5c54ceeb014292c83700f17a4854)
ALTER TABLE `metavalue` ADD `dateValue` DATE;

ALTER TABLE `metavalue` ADD `integerValue` BIGINT;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Add Column (x2)', 'EXECUTED', 'dbF360_3.51.0.xml', 'f360_3.51.0_0', '2.0.1', '3:4f0e5c54ceeb014292c83700f17a4854', 39);

-- Changeset dbF360_3.6.0.xml::f360_3.6.0_0::hp::(Checksum: 3:0f242745880bee93157ec192d7298ded)
DROP VIEW `view_standards`;

DROP VIEW `defaultissueview`;

ALTER TABLE `issue` DROP COLUMN `cwe`;

ALTER TABLE `issue` DROP COLUMN `fisma`;

ALTER TABLE `issue` DROP COLUMN `owasp2004`;

ALTER TABLE `issue` DROP COLUMN `owasp2007`;

ALTER TABLE `issue` DROP COLUMN `owasp2010`;

ALTER TABLE `issue` DROP COLUMN `pci11`;

ALTER TABLE `issue` DROP COLUMN `pci12`;

ALTER TABLE `issue` DROP COLUMN `pci20`;

ALTER TABLE `issue` DROP COLUMN `sans2010`;

ALTER TABLE `issue` DROP COLUMN `sans25`;

ALTER TABLE `issue` DROP COLUMN `stig`;

ALTER TABLE `issue` DROP COLUMN `wasc`;

ALTER TABLE `scan_issue` DROP COLUMN `cwe`;

ALTER TABLE `scan_issue` DROP COLUMN `fisma`;

ALTER TABLE `scan_issue` DROP COLUMN `owasp2004`;

ALTER TABLE `scan_issue` DROP COLUMN `owasp2007`;

ALTER TABLE `scan_issue` DROP COLUMN `owasp2010`;

ALTER TABLE `scan_issue` DROP COLUMN `pci11`;

ALTER TABLE `scan_issue` DROP COLUMN `pci12`;

ALTER TABLE `scan_issue` DROP COLUMN `pci20`;

ALTER TABLE `scan_issue` DROP COLUMN `sans2010`;

ALTER TABLE `scan_issue` DROP COLUMN `sans25`;

ALTER TABLE `scan_issue` DROP COLUMN `stig`;

ALTER TABLE `scan_issue` DROP COLUMN `wasc`;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Drop View (x2), Drop Column (x24)', 'EXECUTED', 'dbF360_3.6.0.xml', 'f360_3.6.0_0', '2.0.1', '3:0f242745880bee93157ec192d7298ded', 40);

-- Changeset dbF360_3.6.0.xml::f360_3.6.0_1::hp::(Checksum: 3:adfb77aa90ec047edd5d33dc13228a2f)
CREATE TABLE `catpackexternallist` (`id` INT AUTO_INCREMENT  NOT NULL, `guid` VARCHAR(255) NOT NULL, `name` VARCHAR(255) NOT NULL, `description` VARCHAR(2000), `groupName` VARCHAR(255), `orderingInfo` INT, CONSTRAINT `PK_CATPACKEXTERNALLIST` PRIMARY KEY (`id`), UNIQUE (`guid`)) engine innodb;

CREATE TABLE `catpackshortcut` (`id` INT AUTO_INCREMENT  NOT NULL, `catPackExternalList_id` INT NOT NULL, `name` VARCHAR(255) NOT NULL, CONSTRAINT `PK_CATPACKSHORTCUT` PRIMARY KEY (`id`)) engine innodb;

CREATE TABLE `catpackexternalcategory` (`id` INT AUTO_INCREMENT  NOT NULL, `catPackExternalList_id` INT NOT NULL, `name` VARCHAR(255) NOT NULL, `description` VARCHAR(2000), `orderingInfo` INT, CONSTRAINT `PK_CATPACKEXTERNALCATEGORY` PRIMARY KEY (`id`)) engine innodb;

CREATE TABLE `catpacklookup` (`catPackExternalCategory_id` INT NOT NULL, `mappedCategory` VARCHAR(255) NOT NULL, `orderingInfo` INT, `fromExtension` CHAR(1) DEFAULT 'N', CONSTRAINT `PK_CATPACKLOOKUP` PRIMARY KEY (`catPackExternalCategory_id`, `mappedCategory`)) engine innodb;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Create Table (x4)', 'EXECUTED', 'dbF360_3.6.0.xml', 'f360_3.6.0_1', '2.0.1', '3:adfb77aa90ec047edd5d33dc13228a2f', 41);

-- Changeset dbF360_3.6.0.xml::f360_3.6.0_2::hp::(Checksum: 3:8dc451672138b14a3291eb446ff91426)
CREATE UNIQUE INDEX `catPackExtListName_idx` ON `catpackexternallist`(`name`);

CREATE UNIQUE INDEX `catPackExtCatNameExtListId_idx` ON `catpackexternalcategory`(`catPackExternalList_id`, `name`);

ALTER TABLE `catpackexternalcategory` ADD CONSTRAINT `catPackExtCatExtListId_FK` FOREIGN KEY (`catPackExternalList_id`) REFERENCES `catpackexternallist` (`id`) ON DELETE CASCADE;

CREATE UNIQUE INDEX `catPackShortcutName_idx` ON `catpackshortcut`(`name`);

ALTER TABLE `catpackshortcut` ADD CONSTRAINT `catPackShortcutExtListId_FK` FOREIGN KEY (`catPackExternalList_id`) REFERENCES `catpackexternallist` (`id`) ON DELETE CASCADE;

CREATE INDEX `catPackLookupMapCat_idx` ON `catpacklookup`(`mappedCategory`);

CREATE INDEX `catPackLookupExtCatId_idx` ON `catpacklookup`(`catPackExternalCategory_id`);

ALTER TABLE `catpacklookup` ADD CONSTRAINT `catPackLookupAltCatId_FK` FOREIGN KEY (`catPackExternalCategory_id`) REFERENCES `catpackexternalcategory` (`id`) ON DELETE CASCADE;

CREATE VIEW `baseIssueView` AS SELECT i.id, i.folder_id, i.issueInstanceId, i.fileName, i.shortFileName, i.severity, i.ruleGuid, i.confidence,
			i.kingdom, i.issueType, i.issueSubtype, i.analyzer, i.lineNumber, i.taintFlag, i.packageName, i.functionName,
			i.className, i.issueAbstract, i.issueRecommendation, i.friority, i.engineType, i.scanStatus, i.audienceSet,
			i.lastScan_id, i.replaceStore, i.snippetId, i.url, i.category, i.source, i.sourceContext, i.sourceFile, i.sink,
			i.sinkContext, i.userName,  i.revision, i.audited, i.auditedTime, i.suppressed, i.findingGuid, i.issueStatus,
			i.issueState, i.dynamicConfidence, i.remediationConstant, i.projectVersion_id projectVersion_id, i.hidden,
			i.likelihood, i.impact, i.accuracy, i.rtaCovered, i.probability, i.foundDate, i.removedDate, i.requestHeader,
			i.requestParameter, i.requestBody, i.attackPayload, i.attackType, i.response, i.triggerDefinition,
			i.triggerString, i.triggerDisplayText, i.secondaryRequest, i.sourceLine, i.requestMethod, i.httpVersion,
			i.cookie, i.mappedCategory, i.correlated
			FROM issue i;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Create Index (x2), Add Foreign Key Constraint, Create Index, Add Foreign Key Constraint, Create Index (x2), Add Foreign Key Constraint, Create View', 'EXECUTED', 'dbF360_3.6.0.xml', 'f360_3.6.0_2', '2.0.1', '3:8dc451672138b14a3291eb446ff91426', 42);

-- Changeset dbF360Derby_3.6.0.xml::f360_3.6.0_0::hp::(Checksum: 3:273e3a7f38092542df58e20e53112d64)
INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Custom SQL', 'MARK_RAN', 'dbF360Derby_3.6.0.xml', 'f360_3.6.0_0', '2.0.1', '3:273e3a7f38092542df58e20e53112d64', 43);

-- Changeset dbF360Db2_3.6.0.xml::f360Db2_3.6.0_0::hp::(Checksum: 3:1f093f64416dec88e8e15b77694480ad)
INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Custom SQL', 'MARK_RAN', 'dbF360Db2_3.6.0.xml', 'f360Db2_3.6.0_0', '2.0.1', '3:1f093f64416dec88e8e15b77694480ad', 44);

-- Changeset dbF360Db2_3.6.0.xml::f360Db2_3.6.0_1::hp::(Checksum: 3:27245ad040f245a6e9f7bcd46ddd9243)
INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Custom SQL (x2)', 'MARK_RAN', 'dbF360Db2_3.6.0.xml', 'f360Db2_3.6.0_1', '2.0.1', '3:27245ad040f245a6e9f7bcd46ddd9243', 45);

-- Changeset dbF360Mysql_3.6.0.xml::f360Mysql_3.6.0_0::hp::(Checksum: 3:4e2c07554d212d848c9a65de7850048d)
ALTER TABLE `analysisblob` ADD PRIMARY KEY (`projectVersion_id`, `engineType`, `issueInstanceId`);

DELIMITER //
CREATE FUNCTION getExternalCategories(mc VARCHAR(255), externalListName VARCHAR(255))RETURNS VARCHAR(1024) NOT DETERMINISTIC
READS SQL DATA
RETURN (SELECT group_concat(CASE ecl.fromExtension WHEN 'Y' THEN ec.name || '*' ELSE ec.name END ORDER BY ec.orderingInfo, ', ')
  FROM catpacklookup ecl, catpackexternalcategory ec
  WHERE ecl.catpackexternalcategory_id=ec.id
  AND ec.catpackexternallist_id=(SELECT id FROM catpackexternallist WHERE name=externalListName)
  AND ecl.mappedCategory = mc
  GROUP BY ecl.mappedCategory)//
DELIMITER ;

CREATE OR REPLACE VIEW defaultissueview AS
SELECT i.id, i.folder_id, i.issueInstanceId, i.fileName, i.shortFileName, i.severity, i.ruleGuid, i.confidence, i.kingdom, i.issueType, i.issueSubtype, i.analyzer,
i.lineNumber, i.taintFlag, i.packageName, i.functionName, i.className, i.issueAbstract, i.issueRecommendation, i.friority, i.engineType, i.scanStatus, 
i.audienceSet, i.lastScan_id, i.replaceStore, i.snippetId, i.url, i.category, i.source, i.sourceContext, i.sourceFile, i.sink, i.sinkContext, i.userName,  i.revision, i.audited, i.auditedTime, i.suppressed, i.findingGuid, i.issueStatus, i.issueState, i.dynamicConfidence, i.remediationConstant, i.projectVersion_id projectVersion_id, i.hidden, i.likelihood, i.impact, i.accuracy, i.rtaCovered, i.probability, i.foundDate, i.removedDate, i.requestHeader, i.requestParameter, i.requestBody, i.attackPayload, i.attackType, i.response, i.triggerDefinition, i.triggerString, i.triggerDisplayText, i.secondaryRequest, i.sourceLine, i.requestMethod, i.httpVersion, i.cookie, i.mappedCategory, i.correlated,
i.attackTriggerDefinition, i.vulnerableParameter, i.reproStepDefinition, i.stackTrace, i.stackTraceTriggerDisplayText, i.bug_id,
getExternalCategories(i.mappedCategory, 'OWASP Top 10 2004') AS owasp2004,
getExternalCategories(i.mappedCategory, 'OWASP Top 10 2007') AS owasp2007,
getExternalCategories(i.mappedCategory, 'OWASP Top 10 2010') AS owasp2010,
getExternalCategories(i.mappedCategory, 'CWE') AS cwe,
getExternalCategories(i.mappedCategory, 'SANS Top 25 2009') AS sans25,
getExternalCategories(i.mappedCategory, 'SANS Top 25 2010') AS sans2010,
getExternalCategories(i.mappedCategory, 'WASC 24 + 2') AS wasc,
getExternalCategories(i.mappedCategory, 'STIG 3') AS stig,
getExternalCategories(i.mappedCategory, 'PCI 1.1') AS pci11,
getExternalCategories(i.mappedCategory, 'PCI 1.2') AS pci12,
getExternalCategories(i.mappedCategory, 'PCI 2.0') AS pci20,
getExternalCategories(i.mappedCategory, 'FISMA') AS fisma
FROM issue i;

DROP PROCEDURE updateExistingWithLatest;

DROP PROCEDURE updateDeletedIssues;

DROP PROCEDURE updateRemovedWithUpload;

DELIMITER //
CREATE PROCEDURE updateExistingWithLatest(p_scan_id INT,p_projectVersion_Id INT, p_engineType varchar(20))BEGIN
        UPDATE issue issue, scan_issue si SET issue.lastScan_Id= si.scan_id
        , issue.shortFileName=si.shortFileName, issue.fileName=si.fileName, issue.severity=si.severity, issue.confidence=si.confidence, issue.kingdom=si.kingdom, issue.issueType=si.issueType
        , issue.issueSubtype=si.issueSubtype, issue.analyzer=si.analyzer, issue.engineType=si.engineType, issue.lineNumber=si.lineNumber, issue.taintFlag=si.taintFlag, issue.packageName=si.packageName
        , issue.functionName=si.functionName, issue.className=si.className, issue.issueAbstract=si.issueAbstract, issue.issueRecommendation=si.issueRecommendation, issue.friority=si.friority, issue.replaceStore=si.replaceStore
        , issue.ruleGuid=si.ruleGuid, issue.snippetId=si.snippetId, issue.contextId=si.contextId, issue.category=si.category, issue.url=si.url, issue.source=si.source, issue.sourceContext=si.sourceContext, issue.sink=si.sink
        , issue.sinkContext=si.sinkContext, issue.sourceFile=si.sourceFile, issue.audienceSet=si.audienceSet
        , issue.scanStatus = (CASE WHEN scanStatus='REMOVED' THEN 'REINTRODUCED' ELSE 'UPDATED' END)
        , issue.findingGuid = si.findingGuid, issue.remediationConstant=si.remediationConstant,issue.likelihood=si.likelihood,issue.impact=si.impact, issue.accuracy=si.accuracy
        , issue.rtaCovered=si.rtaCovered,issue.probability=si.probability
		, issue.requestIdentifier=si.requestIdentifier, issue.requestHeader=si.requestHeader, issue.requestParameter=si.requestParameter, issue.requestBody=si.requestBody, issue.requestMethod=si.requestMethod
		, issue.cookie=si.cookie, issue.httpVersion=si.httpVersion, issue.attackPayload=si.attackPayload, issue.attackType=si.attackType, issue.response=si.response, issue.triggerDefinition=si.triggerDefinition, issue.triggerString=si.triggerString
		, issue.triggerDisplayText=si.triggerDisplayText, issue.secondaryRequest=si.secondaryRequest, issue.sourceLine=si.sourceLine, issue.mappedCategory=si.mappedCategory
        WHERE issue.projectVersion_Id = p_projectVersion_Id AND issue.engineType= p_engineType AND si.issueInstanceId=issue.issueInstanceId AND si.scan_id= p_scan_id;

END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE updateDeletedIssues(p_scan_id INT,p_previous_scan_id INT, p_projectVersion_Id INT)BEGIN
        UPDATE issue issue, scan_issue si SET issue.lastScan_Id= si.scan_id
        , issue.shortFileName=si.shortFileName, issue.fileName=si.fileName, issue.severity=si.severity, issue.confidence=si.confidence, issue.kingdom=si.kingdom, issue.issueType=si.issueType
        , issue.issueSubtype=si.issueSubtype, issue.analyzer=si.analyzer, issue.engineType=si.engineType, issue.lineNumber=si.lineNumber, issue.taintFlag=si.taintFlag, issue.packageName=si.packageName
        , issue.functionName=si.functionName, issue.className=si.className, issue.issueAbstract=si.issueAbstract, issue.issueRecommendation=si.issueRecommendation, issue.friority=si.friority, issue.replaceStore=si.replaceStore
        , issue.ruleGuid=si.ruleGuid, issue.snippetId=si.snippetId, issue.contextId=si.contextId, issue.category=si.category, issue.url=si.url, issue.source=si.source, issue.sourceContext=si.sourceContext, issue.sink=si.sink
        , issue.sinkContext=si.sinkContext, issue.sourceFile=si.sourceFile, issue.audienceSet=si.audienceSet
        , issue.scanStatus = (CASE WHEN scanStatus='REMOVED' THEN 'REINTRODUCED' ELSE 'UPDATED' END)
        , issue.findingGuid = si.findingGuid, issue.remediationConstant=si.remediationConstant,issue.likelihood=si.likelihood,issue.impact=si.impact, issue.accuracy=si.accuracy
        , issue.rtaCovered=si.rtaCovered,issue.probability=si.probability
		, issue.requestIdentifier=si.requestIdentifier, issue.requestHeader=si.requestHeader, issue.requestParameter=si.requestParameter, issue.requestBody=si.requestBody, issue.requestMethod=si.requestMethod
		, issue.cookie=si.cookie, issue.httpVersion=si.httpVersion, issue.attackPayload=si.attackPayload, issue.attackType=si.attackType, issue.response=si.response, issue.triggerDefinition=si.triggerDefinition, issue.triggerString=si.triggerString
		, issue.triggerDisplayText=si.triggerDisplayText, issue.secondaryRequest=si.secondaryRequest, issue.sourceLine=si.sourceLine, issue.mappedCategory=si.mappedCategory
        WHERE issue.projectVersion_Id = p_projectVersion_Id AND issue.lastScan_id= p_scan_id AND si.issue_id=issue.id AND si.scan_id= p_previous_scan_id;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE updateRemovedWithUpload(p_scan_id INT,p_projectVersion_Id INT, p_engineType varchar(20), p_scanDate BIGINT)BEGIN
        UPDATE issue issue, scan_issue si, scan scan SET issue.lastScan_Id= si.scan_id
        , issue.shortFileName=si.shortFileName, issue.fileName=si.fileName, issue.severity=si.severity, issue.confidence=si.confidence, issue.kingdom=si.kingdom, issue.issueType=si.issueType
        , issue.issueSubtype=si.issueSubtype, issue.analyzer=si.analyzer, issue.engineType=si.engineType, issue.lineNumber=si.lineNumber, issue.taintFlag=si.taintFlag, issue.packageName=si.packageName
        , issue.functionName=si.functionName, issue.className=si.className, issue.issueAbstract=si.issueAbstract, issue.issueRecommendation=si.issueRecommendation, issue.friority=si.friority, issue.replaceStore=si.replaceStore
        , issue.ruleGuid=si.ruleGuid, issue.snippetId=si.snippetId, issue.contextId=si.contextId, issue.category=si.category, issue.url=si.url, issue.source=si.source, issue.sourceContext=si.sourceContext, issue.sink=si.sink
        , issue.sinkContext=si.sinkContext, issue.sourceFile=si.sourceFile, issue.audienceSet=si.audienceSet
        , issue.findingGuid = si.findingGuid, issue.remediationConstant=si.remediationConstant,issue.likelihood=si.likelihood,issue.impact=si.impact, issue.accuracy=si.accuracy
        , issue.rtaCovered=si.rtaCovered,issue.probability=si.probability
		, issue.requestIdentifier=si.requestIdentifier, issue.requestHeader=si.requestHeader, issue.requestParameter=si.requestParameter, issue.requestBody=si.requestBody, issue.requestMethod=si.requestMethod
		, issue.cookie=si.cookie, issue.httpVersion=si.httpVersion, issue.attackPayload=si.attackPayload, issue.attackType=si.attackType, issue.response=si.response, issue.triggerDefinition=si.triggerDefinition, issue.triggerString=si.triggerString
		, issue.triggerDisplayText=si.triggerDisplayText, issue.secondaryRequest=si.secondaryRequest, issue.sourceLine=si.sourceLine, issue.mappedCategory=si.mappedCategory
        WHERE issue.projectVersion_Id = p_projectVersion_Id AND issue.engineType= p_engineType AND si.issueInstanceId=issue.issueInstanceId AND si.scan_id= p_scan_id AND issue.scanStatus='REMOVED' AND
        issue.lastScan_id = scan.id and scan.startDate < p_scanDate;

END//
DELIMITER ;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Add Primary Key, Custom SQL (x3)', 'EXECUTED', 'dbF360Mysql_3.6.0.xml', 'f360Mysql_3.6.0_0', '2.0.1', '3:4e2c07554d212d848c9a65de7850048d', 46);

-- Changeset dbF360Mysql_3.6.0.xml::f360Mysql_3.6.0_1::hp::(Checksum: 3:d3e29492c9e6fbc1a969f1112a721f14)
-- Solves index creation issues for MySQL utf8_bin collation
ALTER TABLE `issue` ROW_FORMAT=DYNAMIC;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', 'Solves index creation issues for MySQL utf8_bin collation', NOW(), 'Custom SQL', 'EXECUTED', 'dbF360Mysql_3.6.0.xml', 'f360Mysql_3.6.0_1', '2.0.1', '3:d3e29492c9e6fbc1a969f1112a721f14', 47);

-- Changeset dbF360Mssql_3.6.0.xml::f360Mssql_3.6.0_0::hp::(Checksum: 3:b0b1c74e20aab2eda44d3b881faea42b)
INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Custom SQL (x2)', 'MARK_RAN', 'dbF360Mssql_3.6.0.xml', 'f360Mssql_3.6.0_0', '2.0.1', '3:b0b1c74e20aab2eda44d3b881faea42b', 48);

-- Changeset dbF360Oracle_3.6.0.xml::f360Oracle_3.6.0_0::hp::(Checksum: 3:b248e5b1dff2332045ec765f3c57b17e)
INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Create Procedure, Custom SQL (x2), Create Procedure (x3)', 'MARK_RAN', 'dbF360Oracle_3.6.0.xml', 'f360Oracle_3.6.0_0', '2.0.1', '3:b248e5b1dff2332045ec765f3c57b17e', 49);

-- Changeset dbF360_3.6.0.xml::f360_3.6.0_4::hp::(Checksum: 3:9fe667384d997cad0147f3ec4e0c00c3)
CREATE VIEW `view_standards` AS SELECT i.folder_id, i.id, i.issueInstanceId, i.fileName, i.shortFileName, i.severity, i.ruleGuid, i.confidence, i.kingdom, i.issueType, i.issueSubtype, i.analyzer, i.lineNumber, i.taintFlag, i.packageName, i.functionName, i.className, i.issueAbstract, i.issueRecommendation, i.friority, i.engineType, i.scanStatus, i.audienceSet, i.lastScan_id, i.replaceStore, i.snippetId, i.url, i.category, i.source, i.sourceContext, i.sourceFile, i.sink, i.sinkContext, i.userName, i.owasp2004, i.owasp2007, i.cwe, i.revision, i.audited, i.auditedTime, i.suppressed, i.findingGuid, i.issueStatus, i.issueState, i.dynamicConfidence, i.remediationConstant, i.projectVersion_id, i.hidden, i.likelihood, i.impact, i.accuracy, i.wasc, i.sans25 AS sans2009, i.stig, i.pci11, i.pci12, i.rtaCovered, i.probability, i.foundDate, i.removedDate, i.requestHeader, i.requestParameter, i.requestBody, i.attackPayload, i.attackType, i.attackTriggerDefinition, i.response, i.triggerDefinition, i.triggerString, i.triggerDisplayText, i.secondaryRequest, i.sourceLine, i.requestMethod, i.httpVersion, i.cookie, i.mappedCategory, i.owasp2010, i.fisma AS fips200, i.sans2010, i.correlated, i.pci20, i.vulnerableParameter, i.reproStepDefinition, i.stackTrace, i.stackTraceTriggerDisplayText
			from defaultissueview i
			where i.hidden='N' and i.suppressed='N' and i.scanStatus <> 'REMOVED' AND ((i.owasp2010 IS NOT NULL and upper(i.owasp2010) <> 'NONE') OR (i.fisma IS NOT NULL AND upper(i.fisma) <> 'NONE') OR (i.sans25 IS NOT NULL AND upper(i.sans25) <> 'NONE') OR (i.sans2010 IS NOT NULL AND upper(i.sans2010) <> 'NONE') OR (i.pci20 IS NOT NULL AND upper(i.pci20) <> 'NONE'));

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Create View', 'EXECUTED', 'dbF360_3.6.0.xml', 'f360_3.6.0_4', '2.0.1', '3:9fe667384d997cad0147f3ec4e0c00c3', 50);

-- Changeset dbF360_3.6.0.xml::f360_3.6.0_5::hp::(Checksum: 3:020dc74b4f1dd86ec5921c7ba866d9e5)
UPDATE `issue` SET `mappedCategory` = category WHERE mappedCategory is null;

UPDATE `scan_issue` SET `mappedCategory` = category WHERE mappedCategory is null;

CREATE INDEX `issue_mappedCategory_idx` ON `issue`(`projectVersion_id`, `mappedCategory`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Update Data (x2), Create Index', 'EXECUTED', 'dbF360_3.6.0.xml', 'f360_3.6.0_5', '2.0.1', '3:020dc74b4f1dd86ec5921c7ba866d9e5', 51);

-- Changeset dbF360_3.6.0.xml::f360_3.6.0_6::hp::(Checksum: 3:72160e16683961c50646acca97dbb918)
ALTER TABLE `issuecache` ADD CONSTRAINT `fk_issuecache_issue` FOREIGN KEY (`issue_id`) REFERENCES `issue` (`id`) ON DELETE CASCADE;

CREATE INDEX `analysisblob_pvid_iid` ON `analysisblob`(`projectVersion_id`, `issueInstanceId`);

CREATE INDEX `issue_summary_idx` ON `issue`(`projectVersion_id`, `suppressed`, `hidden`, `scanStatus`, `friority`, `engineType`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Add Foreign Key Constraint, Create Index (x2)', 'EXECUTED', 'dbF360_3.6.0.xml', 'f360_3.6.0_6', '2.0.1', '3:72160e16683961c50646acca97dbb918', 52);

-- Changeset dbF360_3.6.0.xml::f360_3.6.0_7::hp::(Checksum: 3:a8b132bbcf3dc1c0216032397364870a)
ALTER TABLE `issuecache` DROP COLUMN `issueInstanceId`;

DROP INDEX `viewIssueIndex` ON `issuecache`;

DROP INDEX `IssueCacheAltKey` ON `issuecache`;

ALTER TABLE `issuecache` MODIFY `projectVersion_id` INT NOT NULL;

ALTER TABLE `issuecache` MODIFY `folder_id` INT NOT NULL;

ALTER TABLE `issuecache` MODIFY `hidden` CHAR(1) NOT NULL;

ALTER TABLE `issuecache` DROP PRIMARY KEY;

ALTER TABLE `issuecache` ADD PRIMARY KEY (`projectVersion_id`, `filterSet_id`, `issue_id`, `hidden`, `folder_id`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Drop Column, Drop Index (x2), Add Not-Null Constraint (x3), Drop Primary Key, Add Primary Key', 'EXECUTED', 'dbF360_3.6.0.xml', 'f360_3.6.0_7', '2.0.1', '3:a8b132bbcf3dc1c0216032397364870a', 53);

-- Changeset dbF360_3.6.0.xml::f360_3.6.0_8::hp::(Checksum: 3:f89e0c41c7406e2e8703aaaafbb82d43)
ALTER TABLE `variable` ADD `folderName` VARCHAR(80) NOT NULL DEFAULT 'All';

CREATE TABLE `projecttemplatefolder` (`projectTemplate_id` INT NOT NULL, `folderName` VARCHAR(80) NOT NULL, CONSTRAINT `PK_PROJECTTEMPLATEFOLDER` PRIMARY KEY (`projectTemplate_id`, `folderName`));

ALTER TABLE `projecttemplatefolder` ADD CONSTRAINT `fk_ptf_projecttemplate` FOREIGN KEY (`projectTemplate_id`) REFERENCES `projecttemplate` (`id`) ON DELETE CASCADE;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Add Column, Create Table, Add Foreign Key Constraint', 'EXECUTED', 'dbF360_3.6.0.xml', 'f360_3.6.0_8', '2.0.1', '3:f89e0c41c7406e2e8703aaaafbb82d43', 54);

-- Changeset dbF360_3.6.0.xml::f360_3.6.0_9::hp::(Checksum: 3:66969b24d8f4633e6337e9e8b10919bc)
ALTER TABLE `projectversion` ADD `siteId` VARCHAR(255);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Add Column', 'EXECUTED', 'dbF360_3.6.0.xml', 'f360_3.6.0_9', '2.0.1', '3:66969b24d8f4633e6337e9e8b10919bc', 55);

-- Changeset dbF360_3.6.0.xml::f360_3.6.0_10::hp::(Checksum: 3:e6d9ad999e0f24238cb634fc0700903d)
ALTER TABLE `auditattachment` ADD `updateTime` DATETIME;

ALTER TABLE `auditattachment` ADD `deleted` CHAR(1) DEFAULT 'N';

UPDATE `auditattachment` SET `deleted` = 'N' WHERE deleted IS NULL;

ALTER TABLE `auditattachment` MODIFY `deleted` CHAR(1) NOT NULL;

UPDATE `auditattachment` SET `updateTime` = (select d.uploadDate from documentinfo d where documentInfo_id = d.id);

ALTER TABLE `auditattachment` MODIFY `updateTime` DATETIME NOT NULL;

ALTER TABLE `auditattachment` MODIFY `documentInfo_id` INT NULL;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Add Column, Add Not-Null Constraint, Update Data, Add Not-Null Constraint, Drop Not-Null Constraint', 'EXECUTED', 'dbF360_3.6.0.xml', 'f360_3.6.0_10', '2.0.1', '3:e6d9ad999e0f24238cb634fc0700903d', 56);

-- Changeset dbF360_3.6.0.xml::f360_3.6.11.1::hp::(Checksum: 3:910ccae5b4754887893c31298c6676db)
ALTER TABLE `report_projectversion` DROP FOREIGN KEY `RefSavedRepPV`;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Drop Foreign Key Constraint', 'EXECUTED', 'dbF360_3.6.0.xml', 'f360_3.6.11.1', '2.0.1', '3:910ccae5b4754887893c31298c6676db', 57);

-- Changeset dbF360_3.6.0.xml::f360_3.6.11.2::hp::(Checksum: 3:02eed3df0f79b5fc3302dba873fa15d8)
INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Drop Foreign Key Constraint', 'MARK_RAN', 'dbF360_3.6.0.xml', 'f360_3.6.11.2', '2.0.1', '3:02eed3df0f79b5fc3302dba873fa15d8', 58);

-- Changeset dbF360_3.6.0.xml::f360_3.6.0_12_fix::hp::(Checksum: 3:9046683a96d980652e9af2a9715eeddf)
INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Delete Data', 'MARK_RAN', 'dbF360_3.6.0.xml', 'f360_3.6.0_12_fix', '2.0.1', '3:9046683a96d980652e9af2a9715eeddf', 59);

-- Changeset dbF360_3.6.0.xml::f360_3.6.0_12::hp::(Checksum: 3:8eb5e595ceaeaebf3b7699e26236db66)
ALTER TABLE `report_projectversion` DROP PRIMARY KEY;

ALTER TABLE `report_projectversion` ADD `tempApplicationEntity_id` INT;

UPDATE `report_projectversion` SET `tempApplicationEntity_id` = projectVersion_id;

ALTER TABLE `report_projectversion` DROP COLUMN `projectVersion_id`;

ALTER TABLE `report_projectversion` ADD `applicationEntity_id` INT;

UPDATE `report_projectversion` SET `applicationEntity_id` = tempApplicationEntity_id;

ALTER TABLE `report_projectversion` MODIFY `applicationEntity_id` INT NOT NULL;

ALTER TABLE `report_projectversion` DROP COLUMN `tempApplicationEntity_id`;

ALTER TABLE `report_projectversion` RENAME `report_applicationentity`;

ALTER TABLE `report_applicationentity` ADD PRIMARY KEY (`savedReport_id`, `applicationEntity_id`);

ALTER TABLE `report_applicationentity` ADD CONSTRAINT `rpae_ae` FOREIGN KEY (`applicationEntity_id`) REFERENCES `applicationentity` (`id`) ON DELETE CASCADE;

ALTER TABLE `report_applicationentity` ADD CONSTRAINT `RefSavedRepPV` FOREIGN KEY (`savedReport_id`) REFERENCES `savedreport` (`id`) ON DELETE CASCADE;

UPDATE `permission` SET `name` = 'PERM_APPLICATION_ENTITY_REPORT_VIEW' WHERE name='PERM_PROJECT_VERSION_REPORT_VIEW';

UPDATE `permission` SET `name` = 'PERM_APPLICATION_ENTITY_REPORT_DELETE' WHERE name='PERM_PROJECT_VERSION_REPORT_DELETE';

UPDATE `permission` SET `name` = 'PERM_APPLICATION_ENTITY_REPORT_VIEW_ALL' WHERE name='PERM_PROJECT_VERSION_REPORT_VIEW_ALL';

UPDATE `permission` SET `name` = 'PERM_APPLICATION_ENTITY_REPORT_DELETE_ALL' WHERE name='PERM_PROJECT_VERSION_REPORT_DELETE_ALL';

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Drop Primary Key, Add Column, Update Data, Drop Column, Add Column, Update Data, Add Not-Null Constraint, Drop Column, Rename Table, Add Primary Key, Add Foreign Key Constraint (x2), Update Data (x4)', 'EXECUTED', 'dbF360_3.6.0.xml', 'f360_3.6.0_12', '2.0.1', '3:8eb5e595ceaeaebf3b7699e26236db66', 60);

-- Changeset dbF360_3.6.0.xml::f360_3.6.0_13::hp::(Checksum: 3:b42da2523a24f20d0c8ad79b6feac120)
ALTER TABLE `issue` MODIFY `triggerDefinition` LONGBLOB;

ALTER TABLE `issue` MODIFY `attackTriggerDefinition` LONGBLOB;

ALTER TABLE `issue` MODIFY `reproStepDefinition` LONGBLOB;

ALTER TABLE `scan_issue` MODIFY `triggerDefinition` LONGBLOB;

ALTER TABLE `scan_issue` MODIFY `attackTriggerDefinition` LONGBLOB;

ALTER TABLE `scan_issue` MODIFY `reproStepDefinition` LONGBLOB;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Modify data type (x6)', 'EXECUTED', 'dbF360_3.6.0.xml', 'f360_3.6.0_13', '2.0.1', '3:b42da2523a24f20d0c8ad79b6feac120', 61);

-- Changeset dbF360_3.6.0.xml::f360_3.6.0_14::hp::(Checksum: 3:eb2be29a4fbd1c816303b7d95a761f36)
CREATE TABLE `dynamicscan` (`id` INT AUTO_INCREMENT  NOT NULL, `status` VARCHAR(255), `submitter` VARCHAR(255), `requestedDate` DATETIME, `lastUpdateDate` DATETIME, `projectVersion_id` INT NOT NULL, `objectVersion` INT, CONSTRAINT `PK_DYNAMICSCAN` PRIMARY KEY (`id`));

ALTER TABLE `dynamicscan` ADD CONSTRAINT `ds_pv_fk` FOREIGN KEY (`projectVersion_id`) REFERENCES `projectversion` (`id`) ON DELETE CASCADE;

CREATE TABLE `dynamicscanparameter` (`id` INT AUTO_INCREMENT  NOT NULL, `metaDef_id` INT NOT NULL, `textValue` VARCHAR(2000), `booleanValue` CHAR(1), `dynamicScan_id` INT, `fileValueDocumentInfo_id` INT, `dateValue` DATE, `integerValue` BIGINT, `objectVersion` INT, CONSTRAINT `PK_DYNAMICSCANPARAMETER` PRIMARY KEY (`id`));

ALTER TABLE `dynamicscanparameter` ADD CONSTRAINT `dsp_docInfo_fk` FOREIGN KEY (`fileValueDocumentInfo_id`) REFERENCES `documentinfo` (`id`) ON DELETE CASCADE;

ALTER TABLE `dynamicscanparameter` ADD CONSTRAINT `dsp_mdef_fk` FOREIGN KEY (`metaDef_id`) REFERENCES `metadef` (`id`);

ALTER TABLE `dynamicscanparameter` ADD CONSTRAINT `dsp_ds_fk` FOREIGN KEY (`dynamicScan_id`) REFERENCES `dynamicscan` (`id`) ON DELETE CASCADE;

CREATE TABLE `dynamicscanparamselection` (`dynamicScanParam_id` INT NOT NULL, `metaOption_id` INT NOT NULL);

ALTER TABLE `dynamicscanparamselection` ADD PRIMARY KEY (`dynamicScanParam_id`, `metaOption_id`);

ALTER TABLE `dynamicscanparamselection` ADD CONSTRAINT `dsps_dsp_fk` FOREIGN KEY (`dynamicScanParam_id`) REFERENCES `dynamicscanparameter` (`id`) ON DELETE CASCADE;

ALTER TABLE `dynamicscanparamselection` ADD CONSTRAINT `dsps_mop_fk` FOREIGN KEY (`metaOption_id`) REFERENCES `metaoption` (`id`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Create Table, Add Foreign Key Constraint, Create Table, Add Foreign Key Constraint (x3), Create Table, Add Primary Key, Add Foreign Key Constraint (x2)', 'EXECUTED', 'dbF360_3.6.0.xml', 'f360_3.6.0_14', '2.0.1', '3:eb2be29a4fbd1c816303b7d95a761f36', 62);

-- Changeset dbF360_3.6.0.xml::f360_3.6.0_15::hp::(Checksum: 3:9c822d8acc965dc81eece40e75ff735a)
ALTER TABLE `f360global` ADD `instanceGuid` VARCHAR(2000);

ALTER TABLE `f360global` ADD `wieInstanceGuid` VARCHAR(2000);

ALTER TABLE `f360global` ADD `wieInstanceUrl` VARCHAR(2000);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Add Column', 'EXECUTED', 'dbF360_3.6.0.xml', 'f360_3.6.0_15', '2.0.1', '3:9c822d8acc965dc81eece40e75ff735a', 63);

-- Changeset dbF360_3.7.0.xml::f360_3.7.0_0::hp::(Checksum: 3:e7364e06e950007122c6bb7423fd1574)
DROP VIEW `baseIssueView`;

DROP VIEW `view_standards`;

DROP VIEW `defaultissueview`;

ALTER TABLE `issue` ADD `stackTraceTriggerDisplay_temp` MEDIUMTEXT;

ALTER TABLE `scan_issue` ADD `stackTraceTriggerDisplay_temp` MEDIUMTEXT;

UPDATE `issue` SET `stackTraceTriggerDisplay_temp` = stackTraceTriggerDisplayText;

UPDATE `scan_issue` SET `stackTraceTriggerDisplay_temp` = stackTraceTriggerDisplayText;

ALTER TABLE `issue` DROP COLUMN `stackTraceTriggerDisplayText`;

ALTER TABLE `scan_issue` DROP COLUMN `stackTraceTriggerDisplayText`;

ALTER TABLE `issue` ADD `stackTraceTriggerDisplayText` MEDIUMTEXT;

ALTER TABLE `scan_issue` ADD `stackTraceTriggerDisplayText` MEDIUMTEXT;

UPDATE `issue` SET `stackTraceTriggerDisplayText` = stackTraceTriggerDisplay_temp;

UPDATE `scan_issue` SET `stackTraceTriggerDisplayText` = stackTraceTriggerDisplay_temp;

ALTER TABLE `issue` DROP COLUMN `stackTraceTriggerDisplay_temp`;

ALTER TABLE `scan_issue` DROP COLUMN `stackTraceTriggerDisplay_temp`;

CREATE VIEW `baseIssueView` AS SELECT i.id, i.folder_id, i.issueInstanceId, i.fileName, i.shortFileName, i.severity, i.ruleGuid, i.confidence,
			i.kingdom, i.issueType, i.issueSubtype, i.analyzer, i.lineNumber, i.taintFlag, i.packageName, i.functionName,
			i.className, i.issueAbstract, i.issueRecommendation, i.friority, i.engineType, i.scanStatus, i.audienceSet,
			i.lastScan_id, i.replaceStore, i.snippetId, i.url, i.category, i.source, i.sourceContext, i.sourceFile, i.sink,
			i.sinkContext, i.userName,  i.revision, i.audited, i.auditedTime, i.suppressed, i.findingGuid, i.issueStatus,
			i.issueState, i.dynamicConfidence, i.remediationConstant, i.projectVersion_id projectVersion_id, i.hidden,
			i.likelihood, i.impact, i.accuracy, i.rtaCovered, i.probability, i.foundDate, i.removedDate, i.requestHeader,
			i.requestParameter, i.requestBody, i.attackPayload, i.attackType, i.response, i.triggerDefinition,
			i.triggerString, i.triggerDisplayText, i.secondaryRequest, i.sourceLine, i.requestMethod, i.httpVersion,
			i.cookie, i.mappedCategory, i.correlated
			FROM issue i;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Drop View (x3), Add Column (x2), Update Data (x2), Drop Column (x2), Add Column (x2), Update Data (x2), Drop Column (x2), Create View', 'EXECUTED', 'dbF360_3.7.0.xml', 'f360_3.7.0_0', '2.0.1', '3:e7364e06e950007122c6bb7423fd1574', 64);

-- Changeset dbF360Derby_3.7.0.xml::f360_3.7.0_0::hp::(Checksum: 3:4d8816787bc79723ce2eaa1825717aa5)
INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Custom SQL', 'MARK_RAN', 'dbF360Derby_3.7.0.xml', 'f360_3.7.0_0', '2.0.1', '3:4d8816787bc79723ce2eaa1825717aa5', 65);

-- Changeset dbF360Db2_3.7.0.xml::f360Db2_3.7.0_0::hp::(Checksum: 3:852cac7ef91eb371c5a25f3f4855a007)
INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Custom SQL (x3)', 'MARK_RAN', 'dbF360Db2_3.7.0.xml', 'f360Db2_3.7.0_0', '2.0.1', '3:852cac7ef91eb371c5a25f3f4855a007', 66);

-- Changeset dbF360Mysql_3.7.0.xml::f360Mysql_3.7.0_0::hp::(Checksum: 3:faed68675fc2caef4b175e761b8eeb4a)
DROP FUNCTION getExternalCategories;

DELIMITER //
CREATE FUNCTION getExternalCategories(mc VARCHAR(255), externalListGuid VARCHAR(255))		    RETURNS VARCHAR(1024) NOT DETERMINISTIC
		    READS SQL DATA
		    RETURN (SELECT group_concat(CASE ecl.fromExtension WHEN 'Y' THEN ec.name || '*' ELSE ec.name END ORDER BY ec.orderingInfo, ', ')
		    FROM catpacklookup ecl, catpackexternalcategory ec
		    WHERE ecl.catpackexternalcategory_id=ec.id
		    AND ec.catpackexternallist_id=(SELECT id FROM catpackexternallist WHERE guid=externalListGuid)
		    AND ecl.mappedCategory = mc
		    GROUP BY ecl.mappedCategory)//
DELIMITER ;

CREATE OR REPLACE VIEW defaultissueview AS
		    SELECT i.id, i.folder_id, i.issueInstanceId, i.fileName, i.shortFileName, i.severity, i.ruleGuid, i.confidence, i.kingdom, i.issueType, i.issueSubtype, i.analyzer,
		    i.lineNumber, i.taintFlag, i.packageName, i.functionName, i.className, i.issueAbstract, i.issueRecommendation, i.friority, i.engineType, i.scanStatus,
		    i.audienceSet, i.lastScan_id, i.replaceStore, i.snippetId, i.url, i.category, i.source, i.sourceContext, i.sourceFile, i.sink, i.sinkContext, i.userName,  i.revision, i.audited, i.auditedTime, i.suppressed, i.findingGuid, i.issueStatus, i.issueState, i.dynamicConfidence, i.remediationConstant, i.projectVersion_id projectVersion_id, i.hidden, i.likelihood, i.impact, i.accuracy, i.rtaCovered, i.probability, i.foundDate, i.removedDate, i.requestHeader, i.requestParameter, i.requestBody, i.attackPayload, i.attackType, i.response, i.triggerDefinition, i.triggerString, i.triggerDisplayText, i.secondaryRequest, i.sourceLine, i.requestMethod, i.httpVersion, i.cookie, i.mappedCategory, i.correlated,
		    i.attackTriggerDefinition, i.vulnerableParameter, i.reproStepDefinition, i.stackTrace, i.stackTraceTriggerDisplayText, i.bug_id,
		    getExternalCategories(i.mappedCategory, '771C470C-9274-4580-8556-C023E4D3ADB4') AS OWASP2004,
		    getExternalCategories(i.mappedCategory, '1EB1EC0E-74E6-49A0-BCE5-E6603802987A') AS OWASP2007,
		    getExternalCategories(i.mappedCategory, 'FDCECA5E-C2A8-4BE8-BB26-76A8ECD0ED59') AS OWASP2010,
		    getExternalCategories(i.mappedCategory, '3ADB9EE4-5761-4289-8BD3-CBFCC593EBBC') AS CWE,
		    getExternalCategories(i.mappedCategory, '939EF193-507A-44E2-ABB7-C00B2168B6D8') AS SANS25,
		    getExternalCategories(i.mappedCategory, '72688795-4F7B-484C-88A6-D4757A6121CA') AS SANS2010,
		    getExternalCategories(i.mappedCategory, '9DC61E7F-1A48-4711-BBFD-E9DFF537871F') AS WASC,
		    getExternalCategories(i.mappedCategory, 'F2FA57EA-5AAA-4DDE-90A5-480BE65CE7E7') AS STIG,
		    getExternalCategories(i.mappedCategory, '58E2C21D-C70F-4314-8994-B859E24CF855') AS STIG34,
		    getExternalCategories(i.mappedCategory, 'CBDB9D4D-FC20-4C04-AD58-575901CAB531') AS PCI11,
		    getExternalCategories(i.mappedCategory, '57940BDB-99F0-48BF-BF2E-CFC42BA035E5') AS PCI12,
		    getExternalCategories(i.mappedCategory, '8970556D-7F9F-4EA7-8033-9DF39D68FF3E') AS PCI20,
		    getExternalCategories(i.mappedCategory, 'B40F9EE0-3824-4879-B9FE-7A789C89307C') AS FISMA
		    FROM issue i;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Custom SQL (x3)', 'EXECUTED', 'dbF360Mysql_3.7.0.xml', 'f360Mysql_3.7.0_0', '2.0.1', '3:faed68675fc2caef4b175e761b8eeb4a', 67);

-- Changeset dbF360Mssql_3.7.0.xml::f360Mssql_3.7.0_0::hp::(Checksum: 3:711421e4c13b711e04016726f0c6efff)
INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Custom SQL', 'MARK_RAN', 'dbF360Mssql_3.7.0.xml', 'f360Mssql_3.7.0_0', '2.0.1', '3:711421e4c13b711e04016726f0c6efff', 68);

-- Changeset dbF360Oracle_3.7.0.xml::f360Oracle_3.7.0_0::hp::(Checksum: 3:05916fd3584067ff6c843dbd8c17f245)
INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Create Procedure, Custom SQL', 'MARK_RAN', 'dbF360Oracle_3.7.0.xml', 'f360Oracle_3.7.0_0', '2.0.1', '3:05916fd3584067ff6c843dbd8c17f245', 69);

-- Changeset dbF360_3.7.0.xml::f360_3.7.0_1::hp::(Checksum: 3:72603896c35a09ad4020f8e433eed811)
CREATE VIEW `view_standards` AS SELECT i.folder_id, i.id, i.issueInstanceId, i.fileName, i.shortFileName, i.severity, i.ruleGuid, i.confidence, i.kingdom, i.issueType, i.issueSubtype, i.analyzer, i.lineNumber, i.taintFlag, i.packageName, i.functionName, i.className, i.issueAbstract, i.issueRecommendation, i.friority, i.engineType, i.scanStatus, i.audienceSet, i.lastScan_id, i.replaceStore, i.snippetId, i.url, i.category, i.source, i.sourceContext, i.sourceFile, i.sink, i.sinkContext, i.userName, i.owasp2004, i.owasp2007, i.cwe, i.revision, i.audited, i.auditedTime, i.suppressed, i.findingGuid, i.issueStatus, i.issueState, i.dynamicConfidence, i.remediationConstant, i.projectVersion_id, i.hidden, i.likelihood, i.impact, i.accuracy, i.wasc, i.sans25 AS sans2009, i.stig, i.pci11, i.pci12, i.rtaCovered, i.probability, i.foundDate, i.removedDate, i.requestHeader, i.requestParameter, i.requestBody, i.attackPayload, i.attackType, i.attackTriggerDefinition, i.response, i.triggerDefinition, i.triggerString, i.triggerDisplayText, i.secondaryRequest, i.sourceLine, i.requestMethod, i.httpVersion, i.cookie, i.mappedCategory, i.owasp2010, i.fisma AS fips200, i.sans2010, i.correlated, i.pci20, i.vulnerableParameter, i.reproStepDefinition, i.stackTrace, i.stackTraceTriggerDisplayText
				from defaultissueview i
				where i.hidden='N' and i.suppressed='N' and i.scanStatus <> 'REMOVED' AND ((i.owasp2010 IS NOT NULL and upper(i.owasp2010) <> 'NONE') OR (i.fisma IS NOT NULL AND upper(i.fisma) <> 'NONE') OR (i.sans25 IS NOT NULL AND upper(i.sans25) <> 'NONE') OR (i.sans2010 IS NOT NULL AND upper(i.sans2010) <> 'NONE') OR (i.pci20 IS NOT NULL AND upper(i.pci20) <> 'NONE'));

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Create View', 'EXECUTED', 'dbF360_3.7.0.xml', 'f360_3.7.0_1', '2.0.1', '3:72603896c35a09ad4020f8e433eed811', 70);

-- Changeset dbF360_3.7.0.xml::f360_3.7.0_2::hp::(Checksum: 3:cb1d6520eaf7f5a436e74dc3a05d67f9)
INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Custom SQL', 'MARK_RAN', 'dbF360_3.7.0.xml', 'f360_3.7.0_2', '2.0.1', '3:cb1d6520eaf7f5a436e74dc3a05d67f9', 71);

-- Changeset dbF360_3.7.0.xml::f360_3.7.0_3::hp::(Checksum: 3:a8ee2bff200fefd7a2cedc73330603ef)
UPDATE `permissiontemplate` SET `allApplicationRole` = 'N' WHERE allApplicationRole IS NULL;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Update Data', 'EXECUTED', 'dbF360_3.7.0.xml', 'f360_3.7.0_3', '2.0.1', '3:a8ee2bff200fefd7a2cedc73330603ef', 72);

-- Changeset dbF360_3.8.0.xml::f360_3.8.0_0::hp::(Checksum: 3:971852ad4ec469a7cbe5fa3d13b9075c)
DROP VIEW `baseIssueView`;

ALTER TABLE `issue` ADD `manual` VARCHAR(1);

ALTER TABLE `scan_issue` ADD `manual` VARCHAR(1);

CREATE VIEW `baseIssueView` AS SELECT i.id, i.folder_id, i.issueInstanceId, i.fileName, i.shortFileName, i.severity, i.ruleGuid, i.confidence,
			i.kingdom, i.issueType, i.issueSubtype, i.analyzer, i.lineNumber, i.taintFlag, i.packageName, i.functionName,
			i.className, i.issueAbstract, i.issueRecommendation, i.friority, i.engineType, i.scanStatus, i.audienceSet,
			i.lastScan_id, i.replaceStore, i.snippetId, i.url, i.category, i.source, i.sourceContext, i.sourceFile, i.sink,
			i.sinkContext, i.userName,  i.revision, i.audited, i.auditedTime, i.suppressed, i.findingGuid, i.issueStatus,
			i.issueState, i.dynamicConfidence, i.remediationConstant, i.projectVersion_id projectVersion_id, i.hidden,
			i.likelihood, i.impact, i.accuracy, i.rtaCovered, i.probability, i.foundDate, i.removedDate, i.requestHeader,
			i.requestParameter, i.requestBody, i.attackPayload, i.attackType, i.response, i.triggerDefinition,
			i.triggerString, i.triggerDisplayText, i.secondaryRequest, i.sourceLine, i.requestMethod, i.httpVersion,
			i.cookie, i.mappedCategory, i.correlated, i.manual
			FROM issue i;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Drop View, Add Column (x2), Create View', 'EXECUTED', 'dbF360_3.8.0.xml', 'f360_3.8.0_0', '2.0.1', '3:971852ad4ec469a7cbe5fa3d13b9075c', 73);

-- Changeset dbF360_3.8.0.xml::f360_3.8.0_1::hp::(Checksum: 3:448e05bd0a76fbd9bcbde4ea12c96731)
DROP VIEW `baseIssueView`;

CREATE VIEW `baseIssueView` AS SELECT i.id, i.folder_id, i.issueInstanceId, i.fileName, i.shortFileName, i.severity, i.ruleGuid, i.confidence,
			i.kingdom, i.issueType, i.issueSubtype, i.analyzer, i.lineNumber, i.taintFlag, i.packageName, i.functionName,
			i.className, i.issueAbstract, i.issueRecommendation, i.friority, i.engineType, i.scanStatus, i.audienceSet,
			i.lastScan_id, i.replaceStore, i.snippetId, i.url, i.category, i.source, i.sourceContext, i.sourceFile, i.sink,
			i.sinkContext, i.userName,  i.revision, i.audited, i.auditedTime, i.suppressed, i.findingGuid, i.issueStatus,
			i.issueState, i.dynamicConfidence, i.remediationConstant, i.projectVersion_id projectVersion_id, i.hidden,
			i.likelihood, i.impact, i.accuracy, i.rtaCovered, i.probability, i.foundDate, i.removedDate, i.requestHeader,
			i.requestParameter, i.requestBody, i.attackPayload, i.attackType, i.response, i.triggerDefinition,
			i.triggerString, i.triggerDisplayText, i.secondaryRequest, i.sourceLine, i.requestMethod, i.httpVersion,
			i.cookie, i.mappedCategory, i.correlated, i.manual
			FROM issue i;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Drop View, Create View', 'EXECUTED', 'dbF360_3.8.0.xml', 'f360_3.8.0_1', '2.0.1', '3:448e05bd0a76fbd9bcbde4ea12c96731', 74);

-- Changeset dbF360_3.8.0.xml::f360_3.8.0_2::hp::(Checksum: 3:3e8828a71adcbc267f792010c452481c)
CREATE TABLE `systemsetting` (`id` INT AUTO_INCREMENT  NOT NULL, `name` VARCHAR(255) NOT NULL, `settingType` VARCHAR(255) NOT NULL, `objectVersion` INT NOT NULL, CONSTRAINT `PK_SYSTEMSETTING` PRIMARY KEY (`id`));

ALTER TABLE `systemsetting` ADD CONSTRAINT `uq_systemSetting` UNIQUE (`name`);

CREATE TABLE `systemsettingvalue` (`id` INT AUTO_INCREMENT  NOT NULL, `systemSetting_id` INT NOT NULL, `objectVersion` INT NOT NULL, CONSTRAINT `PK_SYSTEMSETTINGVALUE` PRIMARY KEY (`id`));

ALTER TABLE `systemsettingvalue` ADD CONSTRAINT `systemSettingValueRef` FOREIGN KEY (`systemSetting_id`) REFERENCES `systemsetting` (`id`) ON DELETE CASCADE;

ALTER TABLE `systemsettingvalue` ADD CONSTRAINT `uq_systemSettingValue` UNIQUE (`systemSetting_id`);

CREATE TABLE `systemsettingshortstringvalue` (`systemSettingValue_id` INT NOT NULL, `stringValue` VARCHAR(255), CONSTRAINT `PK_SYSSETSHORTSTRVALUE` PRIMARY KEY (`systemSettingValue_id`));

ALTER TABLE `systemsettingshortstringvalue` ADD CONSTRAINT `systemSettingStringValueRef` FOREIGN KEY (`systemSettingValue_id`) REFERENCES `systemsettingvalue` (`id`) ON DELETE CASCADE;

CREATE TABLE `systemsettinglongstringvalue` (`systemSettingValue_id` INT NOT NULL, `stringValue` VARCHAR(255), CONSTRAINT `PK_SYSSETLONGSTRINGVALUE` PRIMARY KEY (`systemSettingValue_id`));

ALTER TABLE `systemsettinglongstringvalue` ADD CONSTRAINT `sysSetLongStringValueRef` FOREIGN KEY (`systemSettingValue_id`) REFERENCES `systemsettingvalue` (`id`) ON DELETE CASCADE;

CREATE TABLE `systemsettingbooleanvalue` (`systemSettingValue_id` INT NOT NULL, `booleanValue` CHAR(1), CONSTRAINT `PK_SYSSETBOOLEANVALUE` PRIMARY KEY (`systemSettingValue_id`));

ALTER TABLE `systemsettingbooleanvalue` ADD CONSTRAINT `sysSetBooleanValueRef` FOREIGN KEY (`systemSettingValue_id`) REFERENCES `systemsettingvalue` (`id`) ON DELETE CASCADE;

CREATE TABLE `systemsettingfilevalue` (`systemSettingValue_id` INT NOT NULL, `fileValue` MEDIUMBLOB, `fileName` VARCHAR(255), CONSTRAINT `PK_SYSSETFILEVALUE` PRIMARY KEY (`systemSettingValue_id`));

ALTER TABLE `systemsettingfilevalue` ADD CONSTRAINT `sysSetFileValueRef` FOREIGN KEY (`systemSettingValue_id`) REFERENCES `systemsettingvalue` (`id`) ON DELETE CASCADE;

CREATE TABLE `systemsettingmultichoiceoption` (`id` INT AUTO_INCREMENT  NOT NULL, `setting_id` INT NOT NULL, `sortOrder` INT, `optionValue` VARCHAR(255), `objectVersion` INT NOT NULL, CONSTRAINT `PK_SYSSETMULTICHOICEOPTION` PRIMARY KEY (`id`));

ALTER TABLE `systemsettingmultichoiceoption` ADD CONSTRAINT `sysSetMultiChoiceOptionSetRef` FOREIGN KEY (`setting_id`) REFERENCES `systemsetting` (`id`) ON DELETE CASCADE;

CREATE TABLE `systemsettingmultichoicevalue` (`systemSettingValue_id` INT NOT NULL, `selectedOption_id` INT, CONSTRAINT `PK_SYSSETMULTICHOICEVALUE` PRIMARY KEY (`systemSettingValue_id`));

ALTER TABLE `systemsettingmultichoicevalue` ADD CONSTRAINT `sysSetMultiChoiceValOptRef` FOREIGN KEY (`selectedOption_id`) REFERENCES `systemsettingmultichoiceoption` (`id`) ON DELETE CASCADE;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Create Table, Add Unique Constraint, Create Table, Add Foreign Key Constraint, Add Unique Constraint, Create Table, Add Foreign Key Constraint, Create Table, Add Foreign Key Constraint, Create Table, Add Foreign Key Constraint, Create Table, Add Foreig...', 'EXECUTED', 'dbF360_3.8.0.xml', 'f360_3.8.0_2', '2.0.1', '3:3e8828a71adcbc267f792010c452481c', 75);

-- Changeset dbF360_3.8.0.xml::f360_3.8.0_3::hp::(Checksum: 3:4e779f888449221de20a785c499e0d06)
ALTER TABLE `fortifyuser` ADD `userType` VARCHAR(32);

UPDATE `fortifyuser` SET `userType` = 'LOCAL';

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Add Column, Update Data', 'EXECUTED', 'dbF360_3.8.0.xml', 'f360_3.8.0_3', '2.0.1', '3:4e779f888449221de20a785c499e0d06', 76);

-- Changeset dbF360_3.8.0.xml::f360_3.8.0_4::hp::(Checksum: 3:4adaab48a94755b3cb76b6eec5957de4)
CREATE TABLE `bbstemplate` (`id` INT AUTO_INCREMENT  NOT NULL, `guid` VARCHAR(255) NOT NULL, `name` VARCHAR(255) NOT NULL, `issueSelectionFilter` VARCHAR(255) NOT NULL, `objectVersion` INT, `publishVersion` INT, CONSTRAINT `bbstemplate_pk` PRIMARY KEY (`id`), CONSTRAINT `bbstemplate_guid_key` UNIQUE (`guid`));

CREATE TABLE `bbstemplateissuegrouping` (`bbsTemplate_id` INT NOT NULL, `attributeName` VARCHAR(255) NOT NULL, CONSTRAINT `bbstig_pk` PRIMARY KEY (`bbsTemplate_id`, `attributeName`));

CREATE TABLE `bbstrategy` (`id` INT AUTO_INCREMENT  NOT NULL, `projectVersion_id` INT NOT NULL, `issueSelectionFilter` VARCHAR(255) NOT NULL, CONSTRAINT `bbstrategy_pk` PRIMARY KEY (`id`), CONSTRAINT `bbstrategy_pvid_key` UNIQUE (`projectVersion_id`));

CREATE TABLE `bbstrategyissuegrouping` (`bbStrategy_id` INT NOT NULL, `attributeName` VARCHAR(255) NOT NULL, CONSTRAINT `bbsig_pk` PRIMARY KEY (`bbStrategy_id`, `attributeName`));

CREATE TABLE `bbstrategyparametervalue` (`id` INT AUTO_INCREMENT  NOT NULL, `bbStrategy_id` INT NOT NULL, `parameterIdentifier` VARCHAR(255) NOT NULL, `parameterValue` VARCHAR(255), `sortOrder` INT NOT NULL, CONSTRAINT `bbsav_pk` PRIMARY KEY (`id`));

CREATE TABLE `bugstatemgmtconfig` (`id` INT AUTO_INCREMENT  NOT NULL, `projectVersion_id` INT NOT NULL, `username` VARCHAR(255), `password` VARCHAR(255), CONSTRAINT `bugstatemgmtconfig_pk` PRIMARY KEY (`id`), CONSTRAINT `bugstatemgmtconfig_pvid_key` UNIQUE (`projectVersion_id`));

ALTER TABLE `bbstemplateissuegrouping` ADD CONSTRAINT `RefBBST_BBSTIG` FOREIGN KEY (`bbsTemplate_id`) REFERENCES `bbstemplate` (`id`) ON DELETE CASCADE;

ALTER TABLE `bbstrategyissuegrouping` ADD CONSTRAINT `RefBBS_BBSIG` FOREIGN KEY (`bbStrategy_id`) REFERENCES `bbstrategy` (`id`) ON DELETE CASCADE;

ALTER TABLE `bbstrategyparametervalue` ADD CONSTRAINT `RefBBS_BBSAV` FOREIGN KEY (`bbStrategy_id`) REFERENCES `bbstrategy` (`id`) ON DELETE CASCADE;

ALTER TABLE `bbstrategy` ADD CONSTRAINT `RefBBS_PV` FOREIGN KEY (`projectVersion_id`) REFERENCES `projectversion` (`id`) ON DELETE CASCADE;

ALTER TABLE `bbstrategyparametervalue` ADD CONSTRAINT `bbstrategyav_id_name_key` UNIQUE (`bbStrategy_id`, `parameterIdentifier`);

ALTER TABLE `bugstatemgmtconfig` ADD CONSTRAINT `Refbugstatemgmt_PV` FOREIGN KEY (`projectVersion_id`) REFERENCES `projectversion` (`id`) ON DELETE CASCADE;

ALTER TABLE `projectversion` ADD `batchBugEnabled` CHAR(1) DEFAULT 'N';

ALTER TABLE `projectversion` ADD `bugStateManagementEnabled` CHAR(1) DEFAULT 'N';

UPDATE `projectversion` SET `batchBugEnabled` = 'N', `bugStateManagementEnabled` = 'N';

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Create Table (x6), Add Foreign Key Constraint (x4), Add Unique Constraint, Add Foreign Key Constraint, Add Column, Update Data', 'EXECUTED', 'dbF360_3.8.0.xml', 'f360_3.8.0_4', '2.0.1', '3:4adaab48a94755b3cb76b6eec5957de4', 77);

-- Changeset dbF360_3.8.0.xml::f360_3.8.0_5::hp::(Checksum: 3:ba78a9d55b08749cc870aa82b2a5fa7e)
ALTER TABLE `issue` DROP FOREIGN KEY `fk_issue_bug`;

ALTER TABLE `issue` ADD CONSTRAINT `fk_issue_bug` FOREIGN KEY (`bug_id`) REFERENCES `bug` (`id`) ON DELETE SET NULL;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Drop Foreign Key Constraint, Add Foreign Key Constraint', 'EXECUTED', 'dbF360_3.8.0.xml', 'f360_3.8.0_5', '2.0.1', '3:ba78a9d55b08749cc870aa82b2a5fa7e', 78);

-- Changeset dbF360_3.8.0.xml::f360_3.8.0_6::hp::(Checksum: 3:c596e19a3b84694d19e0e49b3fc7e5d3)
CREATE INDEX `RTEA_DOCINFIID_IND` ON `runtimeeventarchive`(`documentInfo_id`);

CREATE INDEX `AUDIT_ATT_DOCINFIID_IND` ON `auditattachment`(`documentInfo_id`);

CREATE INDEX `DYN_SCAN_PARAM_DOCINFIID_IND` ON `dynamicscanparameter`(`fileValueDocumentInfo_id`);

CREATE INDEX `ARTIFACT_DOCINFIID_IND` ON `artifact`(`documentInfo_id`);

CREATE INDEX `DOCARTIFACT_DOCINFIID_IND` ON `documentartifact`(`documentInfo_id`);

CREATE INDEX `PROJECTTEMPLATE_DOCINFIID_IND` ON `projecttemplate`(`documentInfo_id`);

CREATE INDEX `RULEPACK_DOCINFIID_IND` ON `rulepack`(`documentInfo_id`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Create Index (x7)', 'EXECUTED', 'dbF360_3.8.0.xml', 'f360_3.8.0_6', '2.0.1', '3:c596e19a3b84694d19e0e49b3fc7e5d3', 79);

-- Changeset dbF360_3.8.0.xml::f360_3.8.0_7::hp::(Checksum: 3:324010376184c57c2db21213d84efeae)
CREATE INDEX `ISSUE_BUG_IND` ON `issue`(`bug_id`);

CREATE INDEX `PRJVERSIONCRTN_PRJVERSION_IND` ON `projectversioncreation`(`previousProjectVersion_id`);

CREATE INDEX `ACTIVITYINSTANCE_ACTIVITY_IND` ON `activityinstance`(`activity_id`);

CREATE INDEX `ALERTHISTORY_ALERT_IND` ON `alerthistory`(`alert_id`);

CREATE INDEX `HOST_CONTROLLER_IND` ON `host`(`controller_id`);

CREATE INDEX `RUNTIMEEVENT_HOST_IND` ON `runtimeevent`(`host_id`);

CREATE INDEX `AUDITATTACHMENT_ISSUE_IND` ON `auditattachment`(`issue_id`);

CREATE INDEX `CNTRLLR_CNTRLLRKEYKEEPER_IND` ON `controller`(`controllerKeyKeeper_id`);

CREATE INDEX `MSRMNTINSTANCE_MSRMNT_IND` ON `measurementinstance`(`measurement_id`);

CREATE INDEX `PRJSTATEACTIVITY_MSRMNT_IND` ON `projectstateactivity`(`measurement_id`);

CREATE INDEX `PRJSTATEAI_MSRMNT_IND` ON `projectstateai`(`measurement_id`);

CREATE INDEX `METADEF_METADEF_IND` ON `metadef`(`parent_id`);

CREATE INDEX `PYLOADENTRY_PYLOADARTIFACT_IND` ON `payloadentry`(`artifact_id`);

CREATE INDEX `PYLOADMSG_PYLOADARTIFACT_IND` ON `payloadmessage`(`artifact_id`);

CREATE INDEX `CRRLTNRESULT_PRJVERSION_IND` ON `correlationresult`(`projectVersion_id`);

CREATE INDEX `DYNASSESSMENT_PRJVERSION_IND` ON `dynamicassessment`(`projectVersion_id`);

CREATE INDEX `PYLOADARTIFACT_PRJVERSION_IND` ON `payloadartifact`(`projectVersion_id`);

CREATE INDEX `SAVEDEVIDENCE_PRJTVERSION_IND` ON `savedevidence`(`projectVersion_id`);

CREATE INDEX `SAVEDREPORT_RPRTDEFINITION_IND` ON `savedreport`(`reportDefinition_id`);

CREATE INDEX `REQTEMPLTINSTANCE_REQTMPLT_IND` ON `requirementtemplateinstance`(`requirementTemplate_id`);

CREATE INDEX `CONEVENTHNDLR_RUNTIMECFG_IND` ON `consoleeventhandler`(`runtimeConfiguration_id`);

CREATE INDEX `FEDERATION_RUNTIMECFG_IND` ON `federation`(`runtimeConfiguration_id`);

CREATE INDEX `RUNTIMESETTING_RUNTIMECFG_IND` ON `runtimesetting`(`runtimeConfiguration_id`);

CREATE INDEX `PREF_PAGE_USERPREFERENCE_IND` ON `pref_page`(`pref_id`);

CREATE INDEX `QRTZ_TRGGRS_QRTZ_JOB_DTLS_IND` ON `QRTZ_TRIGGERS`(`JOB_NAME`, `JOB_GROUP`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Create Index (x25)', 'EXECUTED', 'dbF360_3.8.0.xml', 'f360_3.8.0_7', '2.0.1', '3:324010376184c57c2db21213d84efeae', 80);

-- Changeset dbF360_3.8.0.xml::f360_3.8.0_8::hp::(Checksum: 3:81fb0a5baa2a7a59315078959095fe66)
INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Custom SQL', 'MARK_RAN', 'dbF360_3.8.0.xml', 'f360_3.8.0_8', '2.0.1', '3:81fb0a5baa2a7a59315078959095fe66', 81);

-- Changeset dbF360_3.8.0.xml::f360_3.8.0_9::hp::(Checksum: 3:5e4b40caa086d6157e6602510167c9cd)
ALTER TABLE `bugtrackerconfig` ADD `tempProjectVersionId` INT;

UPDATE `bugtrackerconfig` SET `tempProjectVersionId` = projectVersion_Id;

ALTER TABLE `bugtrackerconfig` MODIFY `projectVersion_Id` INT NULL;

ALTER TABLE `bugtrackerconfig` DROP FOREIGN KEY `fk_bugtc_projectversion`;

ALTER TABLE `bugtrackerconfig` DROP COLUMN `projectVersion_Id`;

ALTER TABLE `bugtrackerconfig` ADD `projectVersion_id` INT NOT NULL DEFAULT 1;

UPDATE `bugtrackerconfig` SET `projectVersion_id` = tempProjectVersionId;

ALTER TABLE `bugtrackerconfig` DROP COLUMN `tempProjectVersionId`;

ALTER TABLE `bugtrackerconfig` ADD CONSTRAINT `fk_bugtc_projectversion` FOREIGN KEY (`projectVersion_id`) REFERENCES `projectversion` (`id`) ON DELETE CASCADE;

CREATE INDEX `BUGTRACKER_CFG_PRJVERSION_IND` ON `bugtrackerconfig`(`projectVersion_id`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Add Column, Update Data, Drop Not-Null Constraint, Drop Foreign Key Constraint, Drop Column, Add Column, Update Data, Drop Column, Add Foreign Key Constraint, Create Index', 'EXECUTED', 'dbF360_3.8.0.xml', 'f360_3.8.0_9', '2.0.1', '3:5e4b40caa086d6157e6602510167c9cd', 82);

-- Changeset dbF360_3.8.0.xml::f360_3.8.0_11::hp::(Checksum: 3:7d7aa615613d0b06cc567e660a1223c8)
CREATE TABLE `batchbugsubmission` (`batchId` VARCHAR(255) NOT NULL, `sequence` INT NOT NULL, `projectVersion_id` INT NOT NULL, `bugSubmission` MEDIUMBLOB NOT NULL, CONSTRAINT `batchbugsubmission_pk` PRIMARY KEY (`batchId`, `sequence`));

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Create Table', 'EXECUTED', 'dbF360_3.8.0.xml', 'f360_3.8.0_11', '2.0.1', '3:7d7aa615613d0b06cc567e660a1223c8', 83);

-- Changeset dbF360_3.9.0.xml::f360_3.9.0_1::hp_i::(Checksum: 3:3c70fa7cec648888a48ce7f87f0f0506)
CREATE INDEX `FK_idx_auditvalue_issue` ON `auditvalue`(`issue_id`);

CREATE INDEX `FK_idx_issuecache_issue` ON `issuecache`(`issue_id`);

CREATE INDEX `FK_idx_fprscan_artifact` ON `fpr_scan`(`artifact_id`);

CREATE INDEX `FK_idx_pvrule_ruledesc` ON `projectversion_rule`(`rule_id`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_i', '', NOW(), 'Create Index (x4)', 'EXECUTED', 'dbF360_3.9.0.xml', 'f360_3.9.0_1', '2.0.1', '3:3c70fa7cec648888a48ce7f87f0f0506', 84);

-- Changeset dbF360_3.9.0.xml::f360_3.9.0_2::hp_i::(Checksum: 3:2202df336016e72a9aee24059f050f96)
CREATE INDEX `FK_idx_dynamicscan_pv` ON `dynamicscan`(`projectVersion_id`);

CREATE INDEX `FK_idx_finding_pv` ON `finding`(`projectVersion_id`);

CREATE INDEX `FK_idx_foldercountcache_pv` ON `foldercountcache`(`projectVersion_id`);

CREATE INDEX `FK_idx_personaassignment_pv` ON `personaassignment`(`projectVersion_id`);

CREATE INDEX `FK_idx_prefpv_pv` ON `pref_projectversion`(`projectVersion_id`);

CREATE INDEX `FK_idx_pvattr_pv` ON `projectversion_attr`(`projectVersion_id`);

CREATE INDEX `FK_idx_pvdependency_childpv` ON `projectversiondependency`(`childProjectVersion_id`);

CREATE INDEX `FK_idx_pvdependency_parentpv` ON `projectversiondependency`(`parentProjectVersion_id`);

CREATE INDEX `FK_idx_rtcomment_pv` ON `requirementtemplatecomment`(`projectVersion_id`);

CREATE INDEX `FK_idx_rtsignoff_pv` ON `requirementtemplatesignoff`(`projectVersion_id`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_i', '', NOW(), 'Create Index (x10)', 'EXECUTED', 'dbF360_3.9.0.xml', 'f360_3.9.0_2', '2.0.1', '3:2202df336016e72a9aee24059f050f96', 85);

-- Changeset dbF360_3.9.0.xml::f360_3.9.0_3::hp_i::(Checksum: 3:65080f1ab4af4e12e272de66d4df1cd5)
CREATE INDEX `FK_idx_timelapseevent_ai` ON `timelapse_event`(`activityInstance_id`);

CREATE INDEX `FK_idx_dynscanparam_dynscan` ON `dynamicscanparameter`(`dynamicScan_id`);

CREATE INDEX `FK_idx_dynscanparam_metadef` ON `dynamicscanparameter`(`metaDef_id`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_i', '', NOW(), 'Create Index (x3)', 'EXECUTED', 'dbF360_3.9.0.xml', 'f360_3.9.0_3', '2.0.1', '3:65080f1ab4af4e12e272de66d4df1cd5', 86);

-- Changeset dbF360Db2_3.9.0.xml::f360Db2_3.9.0_0::hp_i::(Checksum: 3:fc6564b6f7daca9fc8bb0905044b43a1)
INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_i', '', NOW(), 'Custom SQL (x2)', 'MARK_RAN', 'dbF360Db2_3.9.0.xml', 'f360Db2_3.9.0_0', '2.0.1', '3:fc6564b6f7daca9fc8bb0905044b43a1', 87);

-- Changeset dbF360Mysql_3.9.0.xml::f360Mysql_3.9.0_0::hp_i::(Checksum: 3:21569284bf7192f4dbbba1fee55307d4)
DROP PROCEDURE updateScanIssueIds;

DELIMITER //
CREATE PROCEDURE updateScanIssueIds                (p_scan_id INT,
                 p_projectVersion_Id INT
                )
            BEGIN
                UPDATE scan_issue si, issue SET si.issue_id=issue.id
                WHERE issue.projectVersion_id = p_projectVersion_Id
                  AND issue.engineType = si.engineType
                  AND si.issueInstanceId = issue.issueInstanceId
                  AND si.scan_id = p_scan_id;
            END//
DELIMITER ;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_i', '', NOW(), 'Custom SQL (x2)', 'EXECUTED', 'dbF360Mysql_3.9.0.xml', 'f360Mysql_3.9.0_0', '2.0.1', '3:21569284bf7192f4dbbba1fee55307d4', 88);

-- Changeset dbF360Mssql_3.9.0.xml::f360Mssql_3.9.0_0::hp_i::(Checksum: 3:cf494fd19983c168a9be929a584570b3)
INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_i', '', NOW(), 'Custom SQL', 'MARK_RAN', 'dbF360Mssql_3.9.0.xml', 'f360Mssql_3.9.0_0', '2.0.1', '3:cf494fd19983c168a9be929a584570b3', 89);

-- Changeset dbF360Oracle_3.9.0.xml::f360Oracle_3.9.0_0::hp_i::(Checksum: 3:b6d5681450abf7d3b91ac3ace3c101e9)
INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_i', '', NOW(), 'Create Procedure', 'MARK_RAN', 'dbF360Oracle_3.9.0.xml', 'f360Oracle_3.9.0_0', '2.0.1', '3:b6d5681450abf7d3b91ac3ace3c101e9', 90);

-- Changeset dbF360_3.9.0.xml::f360_3.9.0_4::hp_i::(Checksum: 3:97c51687f72a68c767075a4b85167e83)
ALTER TABLE `sourcefilemap` DROP PRIMARY KEY;

ALTER TABLE `sourcefilemap` ADD PRIMARY KEY (`scan_id`, `filePath`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_i', '', NOW(), 'Drop Primary Key, Add Primary Key', 'EXECUTED', 'dbF360_3.9.0.xml', 'f360_3.9.0_4', '2.0.1', '3:97c51687f72a68c767075a4b85167e83', 91);

-- Changeset dbF360_3.9.0.xml::f360_3.9.0_5::hp_i::(Checksum: 3:f0600b9cfec4ec3e22d7190c37ad6781)
CREATE INDEX `FK_idx_measurementvar_var` ON `measurement_variable`(`variable_id`);

CREATE INDEX `FK_idx_measurehist_measure` ON `measurementhistory`(`measurement_id`);

CREATE INDEX `FK_idx_varinstance_ai` ON `variableinstance`(`ai_id`);

CREATE INDEX `FK_idx_varhistory_var` ON `variablehistory`(`variable_id`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_i', '', NOW(), 'Create Index (x4)', 'EXECUTED', 'dbF360_3.9.0.xml', 'f360_3.9.0_5', '2.0.1', '3:f0600b9cfec4ec3e22d7190c37ad6781', 92);

-- Changeset dbF360_3.9.0.xml::f360_3.9.0_6::hp_i::(Checksum: 3:029ab7176aac3046d8ebe08d4fbdf437)
ALTER TABLE `f360global` ADD `wieServiceUser` VARCHAR(100);

ALTER TABLE `f360global` ADD `wieServicePassword` VARCHAR(100);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_i', '', NOW(), 'Add Column', 'EXECUTED', 'dbF360_3.9.0.xml', 'f360_3.9.0_6', '2.0.1', '3:029ab7176aac3046d8ebe08d4fbdf437', 93);

-- Changeset dbF360_3.9.0.xml::f360_3.9.0_7::hp_i::(Checksum: 3:de5fd844c6ea195bd28e11e11903292e)
ALTER TABLE `analysisblob` DROP PRIMARY KEY;

DELETE FROM `analysisblob`  WHERE projectVersion_id NOT IN (SELECT id FROM projectversion);

ALTER TABLE `analysisblob` ADD PRIMARY KEY (`projectVersion_id`, `engineType`, `issueInstanceId`);

ALTER TABLE `analysisblob` ADD CONSTRAINT `fk_analysisblob_pv` FOREIGN KEY (`projectVersion_id`) REFERENCES `projectversion` (`id`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_i', '', NOW(), 'Drop Primary Key, Delete Data, Add Primary Key, Add Foreign Key Constraint', 'EXECUTED', 'dbF360_3.9.0.xml', 'f360_3.9.0_7', '2.0.1', '3:de5fd844c6ea195bd28e11e11903292e', 94);

-- Changeset dbF360_3.9.0.xml::f360_3.9.0_8::hp_i::(Checksum: 3:a8b2246cddb5159cd2b89687752cf331)
DELETE FROM `scan_issue`  WHERE scan_id NOT IN (SELECT id FROM scan);

ALTER TABLE `scan_issue` ADD CONSTRAINT `fk_scanissue_scan` FOREIGN KEY (`scan_id`) REFERENCES `scan` (`id`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_i', '', NOW(), 'Delete Data, Add Foreign Key Constraint', 'EXECUTED', 'dbF360_3.9.0.xml', 'f360_3.9.0_8', '2.0.1', '3:a8b2246cddb5159cd2b89687752cf331', 95);

-- Changeset dbF360_3.9.0.xml::f360_3.9.0_9_pre::hp_i::(Checksum: 3:723ea89d985cc7ff0a0a3ce4fd6266be)
ALTER TABLE `artifact` DROP FOREIGN KEY `RefPVArti`;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_i', '', NOW(), 'Drop Foreign Key Constraint', 'EXECUTED', 'dbF360_3.9.0.xml', 'f360_3.9.0_9_pre', '2.0.1', '3:723ea89d985cc7ff0a0a3ce4fd6266be', 96);

-- Changeset dbF360_3.9.0.xml::f360_3.9.0_9::hp_i::(Checksum: 3:61c24f475ba6c9ca7f18900072ae4d01)
DROP INDEX `artifact_proj` ON `artifact`;

CREATE INDEX `artifact_proj_purged` ON `artifact`(`projectVersion_id`, `purged`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_i', '', NOW(), 'Drop Index, Create Index', 'EXECUTED', 'dbF360_3.9.0.xml', 'f360_3.9.0_9', '2.0.1', '3:61c24f475ba6c9ca7f18900072ae4d01', 97);

-- Changeset dbF360_3.9.0.xml::f360_3.9.0_9_post::hp_i::(Checksum: 3:5feff5d3946dd50be47193558fa65f8f)
ALTER TABLE `artifact` ADD CONSTRAINT `RefPVArti` FOREIGN KEY (`projectVersion_id`) REFERENCES `projectversion` (`id`) ON DELETE CASCADE;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_i', '', NOW(), 'Add Foreign Key Constraint', 'EXECUTED', 'dbF360_3.9.0.xml', 'f360_3.9.0_9_post', '2.0.1', '3:5feff5d3946dd50be47193558fa65f8f', 98);

-- Changeset dbF360_3.9.0.xml::f360_3.9.0_10::hp_i::(Checksum: 3:537f21248117d4af4e0d58b0f7635ab7)
CREATE INDEX `IX_issue_folder_update` ON `issue`(`projectVersion_id`, `id`);

CREATE INDEX `IX_issue_conf_sev` ON `issue`(`projectVersion_id`, `confidence`, `severity`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_i', '', NOW(), 'Create Index (x2)', 'EXECUTED', 'dbF360_3.9.0.xml', 'f360_3.9.0_10', '2.0.1', '3:537f21248117d4af4e0d58b0f7635ab7', 99);

-- Changeset dbF360_3.9.0.xml::f360_3.9.0_11::hp_i::(Checksum: 3:e6cf1a13e9d40f069c2384ab68a51e2a)
CREATE INDEX `IX_issue_removeddate` ON `issue`(`projectVersion_id`, `removedDate`, `id`);

DROP INDEX `scanissueidkey` ON `scan_issue`;

CREATE INDEX `scanissueidkey` ON `scan_issue`(`scan_id`, `issue_id`, `engineType`, `issueInstanceId`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_i', '', NOW(), 'Create Index, Drop Index, Create Index', 'EXECUTED', 'dbF360_3.9.0.xml', 'f360_3.9.0_11', '2.0.1', '3:e6cf1a13e9d40f069c2384ab68a51e2a', 100);

-- Changeset dbF360_4.0.0.xml::f360_4.0.0_4::hp_main::(Checksum: 3:d41d8cd98f00b204e9800998ecf8427e)
INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Empty', 'EXECUTED', 'dbF360_4.0.0.xml', 'f360_4.0.0_4', '2.0.1', '3:d41d8cd98f00b204e9800998ecf8427e', 101);

-- Changeset dbF360_4.0.0.xml::f360_4.0.0_5::hp_main::(Checksum: 3:17660152cc9ed38f038127da943e1b84)
ALTER TABLE `scan_issue` ADD `projectVersion_id` INT;

ALTER TABLE `scan_issue` ADD `all_lob_hash` INT;

ALTER TABLE `scan_issue` ADD `sibling` INT;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Add Column (x3)', 'EXECUTED', 'dbF360_4.0.0.xml', 'f360_4.0.0_5', '2.0.1', '3:17660152cc9ed38f038127da943e1b84', 102);

-- Changeset dbF360Db2_4.0.0_scan_issue_id.xml::f360Db2_4.0.0_0::hp::(Checksum: 3:7ed3f0b4926d2bd9645e078fc056f094)
INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Drop Primary Key, Custom SQL (x5), Add Primary Key', 'MARK_RAN', 'dbF360Db2_4.0.0_scan_issue_id.xml', 'f360Db2_4.0.0_0', '2.0.1', '3:7ed3f0b4926d2bd9645e078fc056f094', 103);

-- Changeset dbF360Derby_4.0.0_scan_issue_id.xml::f360Derby_4.0.0_0::hp::(Checksum: 3:e17baaca417f944a57ae2cd200e56128)
INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Drop Primary Key, Custom SQL (x2), Drop Table, Rename Table, Add Foreign Key Constraint', 'MARK_RAN', 'dbF360Derby_4.0.0_scan_issue_id.xml', 'f360Derby_4.0.0_0', '2.0.1', '3:e17baaca417f944a57ae2cd200e56128', 104);

-- Changeset dbF360Oracle_4.0.0_scan_issue_id.xml::f360Oracle_4.0.0_0::hp::(Checksum: 3:8392a90aceef1e8c27bd9c76e4888567)
INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Drop Primary Key, Add Column, Add Primary Key', 'MARK_RAN', 'dbF360Oracle_4.0.0_scan_issue_id.xml', 'f360Oracle_4.0.0_0', '2.0.1', '3:8392a90aceef1e8c27bd9c76e4888567', 105);

-- Changeset dbF360Mssql_4.0.0_scan_issue_id.xml::f360Mssql_4.0.0_0::hp::(Checksum: 3:f331efe06bb4aafe7376d5e2f00fb244)
INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Drop Primary Key, Custom SQL', 'MARK_RAN', 'dbF360Mssql_4.0.0_scan_issue_id.xml', 'f360Mssql_4.0.0_0', '2.0.1', '3:f331efe06bb4aafe7376d5e2f00fb244', 106);

-- Changeset dbF360Mssql_4.0.0_scan_issue_id.xml::f360Mssql_4.0.0_1::hp::(Checksum: 3:8c2d654bea43fb7f9b554a06950516ad)
INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Custom SQL', 'MARK_RAN', 'dbF360Mssql_4.0.0_scan_issue_id.xml', 'f360Mssql_4.0.0_1', '2.0.1', '3:8c2d654bea43fb7f9b554a06950516ad', 107);

-- Changeset dbF360Mysql_4.0.0_scan_issue_id.xml::f360Mysql_4.0.0_0::hp::(Checksum: 3:d5a42077e84b1b097bfc5eceb64b1b69)
ALTER TABLE `scan_issue` DROP FOREIGN KEY `fk_scanissue_scan`;

ALTER TABLE `scan_issue` DROP PRIMARY KEY;

alter table scan_issue add id Int NOT NULL AUTO_INCREMENT key;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Drop Foreign Key Constraint, Drop Primary Key, Custom SQL', 'EXECUTED', 'dbF360Mysql_4.0.0_scan_issue_id.xml', 'f360Mysql_4.0.0_0', '2.0.1', '3:d5a42077e84b1b097bfc5eceb64b1b69', 108);

-- Changeset dbF360_4.0.0.xml::f360_4.0.0_6::hp_main::(Checksum: 3:f08a9ae7a1bfc22d2962380608175845)
CREATE INDEX `ScanIssueIssueIdKey` ON `scan_issue`(`issue_id`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Create Index', 'EXECUTED', 'dbF360_4.0.0.xml', 'f360_4.0.0_6', '2.0.1', '3:f08a9ae7a1bfc22d2962380608175845', 109);

-- Changeset dbF360_4.0.0.xml::f360_4.0.0_7::hp_main::(Checksum: 3:4d02224e75d8ef96b4b3c40814c9bdc5)
ALTER TABLE `scan_issue` MODIFY `scan_id` INT NULL;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Drop Not-Null Constraint', 'EXECUTED', 'dbF360_4.0.0.xml', 'f360_4.0.0_7', '2.0.1', '3:4d02224e75d8ef96b4b3c40814c9bdc5', 110);

-- Changeset dbF360_4.0.0.xml::f360_4.0.0_8::hp_main::(Checksum: 3:636f0cb4b8843ed60c2277890dc4fb14)
CREATE TABLE `scan_issue_link` (`scan_id` INT NOT NULL, `scan_issue_id` INT NOT NULL, CONSTRAINT `PK_SCAN_ISSUE_LINK` PRIMARY KEY (`scan_id`, `scan_issue_id`));

ALTER TABLE `scan_issue_link` ADD CONSTRAINT `fk_scan_issue_link_scan` FOREIGN KEY (`scan_id`) REFERENCES `scan` (`id`);

ALTER TABLE `scan_issue_link` ADD CONSTRAINT `fk_scan_issue_link_issue` FOREIGN KEY (`scan_issue_id`) REFERENCES `scan_issue` (`id`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Create Table, Add Foreign Key Constraint (x2)', 'EXECUTED', 'dbF360_4.0.0.xml', 'f360_4.0.0_8', '2.0.1', '3:636f0cb4b8843ed60c2277890dc4fb14', 111);

-- Changeset dbF360Derby_4.0.0.xml::f360Derby_4.0.0_1::hp::(Checksum: 3:65531b114e70746708cb2f18f05df973)
INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Custom SQL', 'MARK_RAN', 'dbF360Derby_4.0.0.xml', 'f360Derby_4.0.0_1', '2.0.1', '3:65531b114e70746708cb2f18f05df973', 112);

-- Changeset dbF360Db2_4.0.0.xml::f360Db2_4.0.0_1::hp::(Checksum: 3:65531b114e70746708cb2f18f05df973)
INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Custom SQL', 'MARK_RAN', 'dbF360Db2_4.0.0.xml', 'f360Db2_4.0.0_1', '2.0.1', '3:65531b114e70746708cb2f18f05df973', 113);

-- Changeset dbF360Mysql_4.0.0.xml::f360Mysql_4.0.0_1::hp::(Checksum: 3:65531b114e70746708cb2f18f05df973)
update scan_issue set projectVersion_id = (select projectVersion_id from issue i where i.id = scan_issue.issue_id);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Custom SQL', 'EXECUTED', 'dbF360Mysql_4.0.0.xml', 'f360Mysql_4.0.0_1', '2.0.1', '3:65531b114e70746708cb2f18f05df973', 114);

-- Changeset dbF360Mysql_4.0.0.xml::f360Mysql_4.0.0_2::hp::(Checksum: 3:a3603dcaff71eb33febdcfbba47bddda)
DROP TABLE `QRTZ_JOB_LISTENERS`;

DROP TABLE `QRTZ_TRIGGER_LISTENERS`;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Drop Table (x2), Drop All Foreign Key Constraints (x4)', 'EXECUTED', 'dbF360Mysql_4.0.0.xml', 'f360Mysql_4.0.0_2', '2.0.1', '3:a3603dcaff71eb33febdcfbba47bddda', 115);

-- Changeset dbF360Mysql_4.0.0.xml::f360Mysql_4.0.0_3::hp::(Checksum: 3:9a98600ee19dd4d09eaf2f2b09f70704)
ALTER TABLE `scan_issue` MODIFY `likelihood` decimal(8,3);

ALTER TABLE `issue` MODIFY `likelihood` decimal(8,3);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Modify data type (x2)', 'EXECUTED', 'dbF360Mysql_4.0.0.xml', 'f360Mysql_4.0.0_3', '2.0.1', '3:9a98600ee19dd4d09eaf2f2b09f70704', 116);

-- Changeset dbF360Mssql_4.0.0.xml::f360Mssql_4.0.0_1::hp::(Checksum: 3:65531b114e70746708cb2f18f05df973)
INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Custom SQL', 'MARK_RAN', 'dbF360Mssql_4.0.0.xml', 'f360Mssql_4.0.0_1', '2.0.1', '3:65531b114e70746708cb2f18f05df973', 117);

-- Changeset dbF360Oracle_4.0.0.xml::f360Oracle_4.0.0_1::hp::(Checksum: 3:65531b114e70746708cb2f18f05df973)
INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Custom SQL', 'MARK_RAN', 'dbF360Oracle_4.0.0.xml', 'f360Oracle_4.0.0_1', '2.0.1', '3:65531b114e70746708cb2f18f05df973', 118);

-- Changeset dbF360_4.0.0.xml::f360_4.0.0_9::hp_main::(Checksum: 3:9e584041c830a1f10d97ed7093c5c12a)
DROP VIEW `baseIssueView`;

CREATE VIEW `baseissueview` AS SELECT i.id, i.folder_id, i.issueInstanceId, i.fileName, i.shortFileName, i.severity, i.ruleGuid, i.confidence,
			i.kingdom, i.issueType, i.issueSubtype, i.analyzer, i.lineNumber, i.taintFlag, i.packageName, i.functionName,
			i.className, i.issueAbstract, i.issueRecommendation, i.friority, i.engineType, i.scanStatus, i.audienceSet,
			i.lastScan_id, i.replaceStore, i.snippetId, i.url, i.category, i.source, i.sourceContext, i.sourceFile, i.sink,
			i.sinkContext, i.userName,  i.revision, i.audited, i.auditedTime, i.suppressed, i.findingGuid, i.issueStatus,
			i.issueState, i.dynamicConfidence, i.remediationConstant, i.projectVersion_id projectVersion_id, i.hidden,
			i.likelihood, i.impact, i.accuracy, i.rtaCovered, i.probability, i.foundDate, i.removedDate, i.requestHeader,
			i.requestParameter, i.requestBody, i.attackPayload, i.attackType, i.response, i.triggerDefinition,
			i.triggerString, i.triggerDisplayText, i.secondaryRequest, i.sourceLine, i.requestMethod, i.httpVersion,
			i.cookie, i.mappedCategory, i.correlated, i.manual
			FROM issue i;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Drop View, Create View', 'EXECUTED', 'dbF360_4.0.0.xml', 'f360_4.0.0_9', '2.0.1', '3:9e584041c830a1f10d97ed7093c5c12a', 119);

-- Changeset dbF360_4.0.0.xml::f360_4.0.0_10::hp_main::(Checksum: 3:03568865a5c203b0da21677469d4f9c5)
CREATE TABLE `tmp_scan_issue` (`scan_id` INT NOT NULL, `scan_issue_id` INT NOT NULL, `issue_id` INT);

ALTER TABLE `tmp_scan_issue` ADD CONSTRAINT `uq_tmp_scan_issue` UNIQUE (`scan_id`, `scan_issue_id`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Create Table, Add Unique Constraint', 'EXECUTED', 'dbF360_4.0.0.xml', 'f360_4.0.0_10', '2.0.1', '3:03568865a5c203b0da21677469d4f9c5', 120);

-- Changeset dbF360_4.0.0.xml::f360_4.0.0_11::hp_main::(Checksum: 3:b243ff3e24d0a80a0c91db62d91e3f1a)
CREATE TABLE `id_table` (`session_id` INT NOT NULL, `id` INT NOT NULL);

CREATE INDEX `idx_id_table_session_id` ON `id_table`(`session_id`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Create Table, Create Index', 'EXECUTED', 'dbF360_4.0.0.xml', 'f360_4.0.0_11', '2.0.1', '3:b243ff3e24d0a80a0c91db62d91e3f1a', 121);

-- Changeset dbF360_4.0.0.xml::f360_4.0.0_12::hp_main::(Checksum: 3:57d627ae1c013033e7cc7c0df0bd3707)
CREATE VIEW `scanissueview` AS SELECT sil.scan_id, sil.scan_issue_id, si.issue_id, si.issueInstanceId, s.startDate, s.engineType, s.projectVersion_id
			FROM scan s
			INNER JOIN scan_issue_link sil ON sil.scan_id = s.id
			INNER JOIN scan_issue si ON si.id = sil.scan_issue_id;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Create View', 'EXECUTED', 'dbF360_4.0.0.xml', 'f360_4.0.0_12', '2.0.1', '3:57d627ae1c013033e7cc7c0df0bd3707', 122);

-- Changeset dbF360_4.0.0.xml::f360_4.0.0_13::hp_main::(Checksum: 3:d3159ca8a7cd3acce3d7aa674d091aa2)
ALTER TABLE `scan` DROP FOREIGN KEY `RefPVScan`;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Drop Foreign Key Constraint', 'EXECUTED', 'dbF360_4.0.0.xml', 'f360_4.0.0_13', '2.0.1', '3:d3159ca8a7cd3acce3d7aa674d091aa2', 123);

-- Changeset dbF360_4.0.0.xml::f360_4.0.0_14::hp_main::(Checksum: 3:fd9892d73547f050f9fa5ad2d457c1a0)
DROP INDEX `scan_proj_date` ON `scan`;

CREATE INDEX `scan_proj_date` ON `scan`(`projectVersion_id`, `engineType`, `startDate`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Drop Index, Create Index', 'EXECUTED', 'dbF360_4.0.0.xml', 'f360_4.0.0_14', '2.0.1', '3:fd9892d73547f050f9fa5ad2d457c1a0', 124);

-- Changeset dbF360_4.0.0.xml::f360_4.0.0_15::hp_main::(Checksum: 3:36d308460f06d3f76194f5a39ca30bca)
ALTER TABLE `scan` ADD CONSTRAINT `RefPVScan` FOREIGN KEY (`projectVersion_id`) REFERENCES `projectversion` (`id`) ON DELETE CASCADE;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Add Foreign Key Constraint', 'EXECUTED', 'dbF360_4.0.0.xml', 'f360_4.0.0_15', '2.0.1', '3:36d308460f06d3f76194f5a39ca30bca', 125);

-- Changeset dbF360_4.0.0.xml::f360_4.0.0_16::hp_main::(Checksum: 3:3befb80ec4bf1d77b859e7bcb81bdb9a)
CREATE INDEX `idx_scan_issue_link_si_id` ON `scan_issue_link`(`scan_issue_id`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Create Index', 'EXECUTED', 'dbF360_4.0.0.xml', 'f360_4.0.0_16', '2.0.1', '3:3befb80ec4bf1d77b859e7bcb81bdb9a', 126);

-- Changeset dbF360_4.0.0.xml::f360_4.0.0_17::hp_main::(Checksum: 3:5769dc9befcfe1cc4db902cf70829523)
ALTER TABLE `QRTZ_JOB_DETAILS` DROP COLUMN `IS_VOLATILE`;

ALTER TABLE `QRTZ_TRIGGERS` DROP COLUMN `IS_VOLATILE`;

ALTER TABLE `QRTZ_FIRED_TRIGGERS` DROP COLUMN `IS_VOLATILE`;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Drop Column (x3)', 'EXECUTED', 'dbF360_4.0.0.xml', 'f360_4.0.0_17', '2.0.1', '3:5769dc9befcfe1cc4db902cf70829523', 127);

-- Changeset dbF360_4.0.0.xml::f360_4.0.0_18::hp_main::(Checksum: 3:78c22a5e30aa9aa693a8d094a5e652cf)
ALTER TABLE `QRTZ_JOB_DETAILS` ADD `IS_NONCONCURRENT` VARCHAR(1);

UPDATE `QRTZ_JOB_DETAILS` SET `IS_NONCONCURRENT` = IS_STATEFUL;

ALTER TABLE `QRTZ_JOB_DETAILS` ADD `IS_UPDATE_DATA` VARCHAR(1);

UPDATE `QRTZ_JOB_DETAILS` SET `IS_UPDATE_DATA` = IS_STATEFUL;

ALTER TABLE `QRTZ_JOB_DETAILS` DROP COLUMN `IS_STATEFUL`;

ALTER TABLE `QRTZ_FIRED_TRIGGERS` ADD `IS_NONCONCURRENT` VARCHAR(1);

UPDATE `QRTZ_FIRED_TRIGGERS` SET `IS_NONCONCURRENT` = IS_STATEFUL;

ALTER TABLE `QRTZ_FIRED_TRIGGERS` ADD `IS_UPDATE_DATA` VARCHAR(1);

UPDATE `QRTZ_FIRED_TRIGGERS` SET `IS_UPDATE_DATA` = IS_STATEFUL;

ALTER TABLE `QRTZ_FIRED_TRIGGERS` DROP COLUMN `IS_STATEFUL`;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Add Column (x2), Drop Column, Add Column (x2), Drop Column', 'EXECUTED', 'dbF360_4.0.0.xml', 'f360_4.0.0_18', '2.0.1', '3:78c22a5e30aa9aa693a8d094a5e652cf', 128);

-- Changeset dbF360_4.0.0.xml::f360_4.0.0_19::hp_main::(Checksum: 3:727927fea29c1ab310f07dd9b7ae3dc8)
ALTER TABLE `QRTZ_BLOB_TRIGGERS` ADD `SCHED_NAME` VARCHAR(120) NOT NULL DEFAULT 'scheduler';

ALTER TABLE `QRTZ_CALENDARS` ADD `SCHED_NAME` VARCHAR(120) NOT NULL DEFAULT 'scheduler';

ALTER TABLE `QRTZ_CRON_TRIGGERS` ADD `SCHED_NAME` VARCHAR(120) NOT NULL DEFAULT 'scheduler';

ALTER TABLE `QRTZ_FIRED_TRIGGERS` ADD `SCHED_NAME` VARCHAR(120) NOT NULL DEFAULT 'scheduler';

ALTER TABLE `QRTZ_JOB_DETAILS` ADD `SCHED_NAME` VARCHAR(120) NOT NULL DEFAULT 'scheduler';

ALTER TABLE `QRTZ_LOCKS` ADD `SCHED_NAME` VARCHAR(120) NOT NULL DEFAULT 'scheduler';

ALTER TABLE `QRTZ_PAUSED_TRIGGER_GRPS` ADD `SCHED_NAME` VARCHAR(120) NOT NULL DEFAULT 'scheduler';

ALTER TABLE `QRTZ_SCHEDULER_STATE` ADD `SCHED_NAME` VARCHAR(120) NOT NULL DEFAULT 'scheduler';

ALTER TABLE `QRTZ_SIMPLE_TRIGGERS` ADD `SCHED_NAME` VARCHAR(120) NOT NULL DEFAULT 'scheduler';

ALTER TABLE `QRTZ_TRIGGERS` ADD `SCHED_NAME` VARCHAR(120) NOT NULL DEFAULT 'scheduler';

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Add Column (x10)', 'EXECUTED', 'dbF360_4.0.0.xml', 'f360_4.0.0_19', '2.0.1', '3:727927fea29c1ab310f07dd9b7ae3dc8', 129);

-- Changeset dbF360_4.0.0.xml::f360_4.0.0_20::hp_main::(Checksum: 3:7e5d5b0fb9e9e3665e5871523c908004)
ALTER TABLE `QRTZ_JOB_DETAILS` DROP PRIMARY KEY;

ALTER TABLE `QRTZ_FIRED_TRIGGERS` DROP PRIMARY KEY;

ALTER TABLE `QRTZ_BLOB_TRIGGERS` DROP PRIMARY KEY;

ALTER TABLE `QRTZ_CRON_TRIGGERS` DROP PRIMARY KEY;

ALTER TABLE `QRTZ_SIMPLE_TRIGGERS` DROP PRIMARY KEY;

ALTER TABLE `QRTZ_CALENDARS` DROP PRIMARY KEY;

ALTER TABLE `QRTZ_LOCKS` DROP PRIMARY KEY;

ALTER TABLE `QRTZ_PAUSED_TRIGGER_GRPS` DROP PRIMARY KEY;

ALTER TABLE `QRTZ_SCHEDULER_STATE` DROP PRIMARY KEY;

ALTER TABLE `QRTZ_TRIGGERS` DROP PRIMARY KEY;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Drop Primary Key (x10)', 'EXECUTED', 'dbF360_4.0.0.xml', 'f360_4.0.0_20', '2.0.1', '3:7e5d5b0fb9e9e3665e5871523c908004', 130);

-- Changeset dbF360_4.0.0.xml::f360_4.0.0_21::hp_main::(Checksum: 3:ed254e1be1bf9feff11ed9e5cffd0f80)
ALTER TABLE `QRTZ_JOB_DETAILS` ADD PRIMARY KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`);

ALTER TABLE `QRTZ_TRIGGERS` ADD PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`);

ALTER TABLE `QRTZ_TRIGGERS` ADD CONSTRAINT `qrtz_triggers_job_name_fkey` FOREIGN KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) REFERENCES `QRTZ_JOB_DETAILS` (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`);

ALTER TABLE `QRTZ_BLOB_TRIGGERS` ADD PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`);

ALTER TABLE `QRTZ_BLOB_TRIGGERS` ADD CONSTRAINT `qrtz_blobtrig_trig_name_fkey` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `QRTZ_TRIGGERS` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`);

ALTER TABLE `QRTZ_CRON_TRIGGERS` ADD PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`);

ALTER TABLE `QRTZ_CRON_TRIGGERS` ADD CONSTRAINT `qrtz_crontrig_trig_name_fkey` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `QRTZ_TRIGGERS` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`);

ALTER TABLE `QRTZ_SIMPLE_TRIGGERS` ADD PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`);

ALTER TABLE `QRTZ_SIMPLE_TRIGGERS` ADD CONSTRAINT `qrtz_simpletrig_trig_name_fkey` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `QRTZ_TRIGGERS` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`);

ALTER TABLE `QRTZ_FIRED_TRIGGERS` ADD PRIMARY KEY (`SCHED_NAME`, `ENTRY_ID`);

ALTER TABLE `QRTZ_CALENDARS` ADD PRIMARY KEY (`SCHED_NAME`, `CALENDAR_NAME`);

ALTER TABLE `QRTZ_LOCKS` ADD PRIMARY KEY (`SCHED_NAME`, `LOCK_NAME`);

ALTER TABLE `QRTZ_PAUSED_TRIGGER_GRPS` ADD PRIMARY KEY (`SCHED_NAME`, `TRIGGER_GROUP`);

ALTER TABLE `QRTZ_SCHEDULER_STATE` ADD PRIMARY KEY (`SCHED_NAME`, `INSTANCE_NAME`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Add Primary Key (x2), Add Foreign Key Constraint, Add Primary Key, Add Foreign Key Constraint, Add Primary Key, Add Foreign Key Constraint, Add Primary Key, Add Foreign Key Constraint, Add Primary Key (x5)', 'EXECUTED', 'dbF360_4.0.0.xml', 'f360_4.0.0_21', '2.0.1', '3:ed254e1be1bf9feff11ed9e5cffd0f80', 131);

-- Changeset dbF360_4.0.0.xml::f360_4.0.0_22::hp_main::(Checksum: 3:22206fa2459ab55f51186ca92a2876c5)
CREATE TABLE `QRTZ_SIMPROP_TRIGGERS` (`SCHED_NAME` VARCHAR(120) NOT NULL, `TRIGGER_NAME` VARCHAR(200) NOT NULL, `TRIGGER_GROUP` VARCHAR(200) NOT NULL, `STR_PROP_1` VARCHAR(512), `STR_PROP_2` VARCHAR(512), `STR_PROP_3` VARCHAR(512), `INT_PROP_1` INT, `INT_PROP_2` INT, `LONG_PROP_1` BIGINT, `LONG_PROP_2` BIGINT, `DEC_PROP_1` decimal(13,4), `DEC_PROP_2` decimal(13,4), `BOOL_PROP_1` VARCHAR(1), `BOOL_PROP_2` VARCHAR(1));

ALTER TABLE `QRTZ_SIMPROP_TRIGGERS` ADD PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`);

ALTER TABLE `QRTZ_SIMPROP_TRIGGERS` ADD CONSTRAINT `qrtz_simprop_triggers_fk` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `QRTZ_TRIGGERS` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Create Table, Add Primary Key, Add Foreign Key Constraint', 'EXECUTED', 'dbF360_4.0.0.xml', 'f360_4.0.0_22', '2.0.1', '3:22206fa2459ab55f51186ca92a2876c5', 132);

-- Changeset dbF360_4.0.0.xml::f360_4.0.0_23::hp_main::(Checksum: 3:3e0def425ec8827ad425b44b762af7d1)
CREATE INDEX `idx_qrtz_ft_inst_job_req_rcvry` ON `QRTZ_FIRED_TRIGGERS`(`SCHED_NAME`, `INSTANCE_NAME`, `REQUESTS_RECOVERY`);

CREATE INDEX `idx_qrtz_ft_jg` ON `QRTZ_FIRED_TRIGGERS`(`SCHED_NAME`, `JOB_GROUP`);

CREATE INDEX `idx_qrtz_ft_j_g` ON `QRTZ_FIRED_TRIGGERS`(`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`);

CREATE INDEX `idx_qrtz_ft_tg` ON `QRTZ_FIRED_TRIGGERS`(`SCHED_NAME`, `TRIGGER_GROUP`);

CREATE INDEX `idx_qrtz_ft_trig_inst_name` ON `QRTZ_FIRED_TRIGGERS`(`SCHED_NAME`, `INSTANCE_NAME`);

CREATE INDEX `idx_qrtz_ft_t_g` ON `QRTZ_FIRED_TRIGGERS`(`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`);

CREATE INDEX `idx_qrtz_j_grp` ON `QRTZ_JOB_DETAILS`(`SCHED_NAME`, `JOB_GROUP`);

CREATE INDEX `idx_qrtz_j_req_recovery` ON `QRTZ_JOB_DETAILS`(`SCHED_NAME`, `REQUESTS_RECOVERY`);

CREATE INDEX `idx_qrtz_t_c` ON `QRTZ_TRIGGERS`(`SCHED_NAME`, `CALENDAR_NAME`);

CREATE INDEX `idx_qrtz_t_g` ON `QRTZ_TRIGGERS`(`SCHED_NAME`, `TRIGGER_GROUP`);

CREATE INDEX `idx_qrtz_t_jg` ON `QRTZ_TRIGGERS`(`SCHED_NAME`, `JOB_GROUP`);

CREATE INDEX `idx_qrtz_t_NEXT_FIRE_TIME` ON `QRTZ_TRIGGERS`(`SCHED_NAME`, `NEXT_FIRE_TIME`);

CREATE INDEX `idx_qrtz_t_nft_misfire` ON `QRTZ_TRIGGERS`(`SCHED_NAME`, `MISFIRE_INSTR`, `NEXT_FIRE_TIME`);

CREATE INDEX `idx_qrtz_t_nft_st` ON `QRTZ_TRIGGERS`(`SCHED_NAME`, `TRIGGER_STATE`, `NEXT_FIRE_TIME`);

CREATE INDEX `idx_qrtz_t_nft_st_misfire` ON `QRTZ_TRIGGERS`(`SCHED_NAME`, `MISFIRE_INSTR`, `NEXT_FIRE_TIME`, `TRIGGER_STATE`);

CREATE INDEX `idx_qrtz_t_nft_st_misfire_grp` ON `QRTZ_TRIGGERS`(`SCHED_NAME`, `MISFIRE_INSTR`, `NEXT_FIRE_TIME`, `TRIGGER_GROUP`, `TRIGGER_STATE`);

CREATE INDEX `idx_qrtz_t_n_g_state` ON `QRTZ_TRIGGERS`(`SCHED_NAME`, `TRIGGER_GROUP`, `TRIGGER_STATE`);

CREATE INDEX `idx_qrtz_t_n_state` ON `QRTZ_TRIGGERS`(`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`, `TRIGGER_STATE`);

CREATE INDEX `idx_qrtz_t_state` ON `QRTZ_TRIGGERS`(`SCHED_NAME`, `TRIGGER_STATE`);

CREATE INDEX `idx_qrtz_t_j` ON `QRTZ_TRIGGERS`(`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Create Index (x20)', 'EXECUTED', 'dbF360_4.0.0.xml', 'f360_4.0.0_23', '2.0.1', '3:3e0def425ec8827ad425b44b762af7d1', 133);

-- Changeset dbF360_4.0.0.xml::f360_4.0.0_24::hp_main::(Checksum: 3:cc4b0ba9a2091116a22393e49ec28a68)
ALTER TABLE `artifact` ADD `lastCompletedStep` INT NOT NULL DEFAULT 0;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Add Column', 'EXECUTED', 'dbF360_4.0.0.xml', 'f360_4.0.0_24', '2.0.1', '3:cc4b0ba9a2091116a22393e49ec28a68', 134);

-- Changeset dbF360_4.0.0.xml::f360_4.0.0_25::hp_main::(Checksum: 3:92cc9b9dd85168c9a8989f689d95fad8)
UPDATE `QRTZ_JOB_DETAILS` SET `REQUESTS_RECOVERY` = '1' WHERE JOB_NAME = 'JOB_ARTIFACTUPLOAD' AND JOB_GROUP = 'JOBGROUP_ARTIFACTUPLOAD';

UPDATE `QRTZ_JOB_DETAILS` SET `REQUESTS_RECOVERY` = '1' WHERE JOB_NAME = 'JOB_SOURCEUPLOAD' AND JOB_GROUP = 'JOBGROUP_SOURCEUPLOAD';

UPDATE `QRTZ_JOB_DETAILS` SET `REQUESTS_RECOVERY` = '1' WHERE JOB_NAME = 'JOB_ARTIFACTPURGE' AND JOB_GROUP = 'JOBGROUP_ARTIFACTPURGE';

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Update Data (x3)', 'EXECUTED', 'dbF360_4.0.0.xml', 'f360_4.0.0_25', '2.0.1', '3:92cc9b9dd85168c9a8989f689d95fad8', 135);

-- Changeset dbF360_4.0.0.xml::f360_4.0.0_26::hp_main::(Checksum: 3:124b399b16d813ceb25f3083985a3f02)
ALTER TABLE `projectversion` ADD CONSTRAINT `project_projectversion_fkey` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Add Foreign Key Constraint', 'EXECUTED', 'dbF360_4.0.0.xml', 'f360_4.0.0_26', '2.0.1', '3:124b399b16d813ceb25f3083985a3f02', 136);

-- Changeset dbF360_4.0.0.xml::f360_4.0.0_27::hp_main::(Checksum: 3:670c54d7c2bbb5a68acd97eedef1d51c)
ALTER TABLE `iidmigration` ADD `engineType` VARCHAR(20) NOT NULL DEFAULT 'SCA';

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Add Column', 'EXECUTED', 'dbF360_4.0.0.xml', 'f360_4.0.0_27', '2.0.1', '3:670c54d7c2bbb5a68acd97eedef1d51c', 137);

-- Changeset dbF360_4.0.0.xml::f360_4.0.0_28::hp_main::(Checksum: 3:c82a83d92cb8e8042a5382666e015bb0)
ALTER TABLE `scan_issue` MODIFY `source` VARCHAR(4000);

ALTER TABLE `scan_issue` MODIFY `sink` VARCHAR(4000);

ALTER TABLE `issue` MODIFY `source` VARCHAR(4000);

ALTER TABLE `issue` MODIFY `sink` VARCHAR(4000);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Modify data type (x4)', 'EXECUTED', 'dbF360_4.0.0.xml', 'f360_4.0.0_28', '2.0.1', '3:c82a83d92cb8e8042a5382666e015bb0', 138);

-- Changeset dbF360_4.0.0.xml::f360_4.0.0_29::hp_main::(Checksum: 3:c356fdd9970c26eb0519a2f6c37dfd9d)
CREATE INDEX `IssueLastScanIdUpdateInd` ON `issue`(`projectVersion_id`, `engineType`, `id`);

DROP INDEX `tempInstanceId_Key` ON `issue`;

ALTER TABLE `scan_issue_link` DROP FOREIGN KEY `fk_scan_issue_link_scan`;

ALTER TABLE `scan_issue_link` DROP FOREIGN KEY `fk_scan_issue_link_issue`;

CREATE INDEX `ScanIssueLinkScanIdInd` ON `scan_issue_link`(`scan_id`);

CREATE INDEX `IssueUpdScanStatusRemDateInd` ON `issue`(`projectVersion_id`, `engineType`, `lastScan_id`);

CREATE INDEX `IssueUpdateFoundDateInd` ON `issue`(`projectVersion_id`, `engineType`, `foundDate`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Create Index, Drop Index, Drop Foreign Key Constraint (x2), Create Index (x3)', 'EXECUTED', 'dbF360_4.0.0.xml', 'f360_4.0.0_29', '2.0.1', '3:c356fdd9970c26eb0519a2f6c37dfd9d', 139);

-- Changeset dbF360_4.0.0.xml::f360_4.0.0_30::hp_main::(Checksum: 3:55090e600d6b1f2c27b5aee227aa549a)
ALTER TABLE `iidmigration` ADD `status` VARCHAR(20);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Add Column', 'EXECUTED', 'dbF360_4.0.0.xml', 'f360_4.0.0_30', '2.0.1', '3:55090e600d6b1f2c27b5aee227aa549a', 140);

-- Changeset dbF360_4.0.0.xml::f360_4.0.0_31::hp_main::(Checksum: 3:3860338a6744028f54c378f7f62c1367)
CREATE INDEX `IssueCorrelatedUpdInd` ON `issue`(`projectVersion_id`, `id`, `correlated`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Create Index', 'EXECUTED', 'dbF360_4.0.0.xml', 'f360_4.0.0_31', '2.0.1', '3:3860338a6744028f54c378f7f62c1367', 141);

-- Changeset dbF360_4.0.0.xml::f360_4.0.0_32::hp_main::(Checksum: 3:b9b255579ac524cedffe8e0ed7a9dcd3)
UPDATE `QRTZ_JOB_DETAILS` SET `JOB_CLASS_NAME` = 'com.fortify.manager.BLL.jobs.ReportJob' WHERE JOB_NAME='JOB_REPORT';

UPDATE `QRTZ_JOB_DETAILS` SET `JOB_CLASS_NAME` = 'com.fortify.manager.BLL.jobs.ArtifactUploadJob' WHERE JOB_NAME='JOB_ARTIFACTUPLOAD';

UPDATE `QRTZ_JOB_DETAILS` SET `JOB_CLASS_NAME` = 'com.fortify.manager.BLL.jobs.SourceArchiveUploadJob' WHERE JOB_NAME='JOB_SOURCEUPLOAD';

UPDATE `QRTZ_JOB_DETAILS` SET `JOB_CLASS_NAME` = 'com.fortify.manager.BLL.jobs.HistoricalSnapshotJob' WHERE JOB_NAME='JOB_HISTORICALSNAPSHOT';

UPDATE `QRTZ_JOB_DETAILS` SET `JOB_CLASS_NAME` = 'com.fortify.manager.BLL.runtime.jobs.ReapplyRuntimeApplicationAssignmentRulesJob' WHERE JOB_NAME='JOB_REAPPLYRUNTIMEASSIGNMENT';

UPDATE `QRTZ_JOB_DETAILS` SET `JOB_CLASS_NAME` = 'com.fortify.manager.BLL.jobs.ArtifactDeleteJob' WHERE JOB_NAME='JOB_ARTIFACTDELETE';

UPDATE `QRTZ_JOB_DETAILS` SET `JOB_CLASS_NAME` = 'com.fortify.manager.BLL.jobs.ArtifactPurgeJob' WHERE JOB_NAME='JOB_ARTIFACTPURGE';

UPDATE `QRTZ_JOB_DETAILS` SET `JOB_CLASS_NAME` = 'com.fortify.manager.BLL.jobs.RefreshFilterSetFolderJob' WHERE JOB_NAME='JOB_REFRESHFILTERSETFOLDER';

UPDATE `QRTZ_JOB_DETAILS` SET `JOB_CLASS_NAME` = 'com.fortify.manager.BLL.jobs.RefreshAnalysisTraceJob' WHERE JOB_NAME='JOB_REFRESHANALYSISTRACE';

UPDATE `QRTZ_JOB_DETAILS` SET `JOB_CLASS_NAME` = 'com.fortify.manager.BLL.jobs.AlertReminderJob' WHERE JOB_NAME='AlertReminder';

UPDATE `QRTZ_JOB_DETAILS` SET `JOB_CLASS_NAME` = 'com.fortify.manager.BLL.jobs.LdapCacheRefreshJob' WHERE JOB_NAME='LdapCacheRefresh';

UPDATE `QRTZ_JOB_DETAILS` SET `JOB_CLASS_NAME` = 'com.fortify.manager.BLL.jobs.LdapCacheRefreshJob' WHERE JOB_NAME='JOB_LDAPMANUALREFRESH';

UPDATE `QRTZ_JOB_DETAILS` SET `JOB_CLASS_NAME` = 'com.fortify.manager.BLL.jobs.BatchBugSubmissionJob' WHERE JOB_NAME='JOB_BATCHBUGSUBMISSION';

UPDATE `QRTZ_JOB_DETAILS` SET `JOB_CLASS_NAME` = 'com.fortify.manager.BLL.jobs.BugStateManagementJob' WHERE JOB_NAME='JOB_BUGSTATEMANAGEMENT';

UPDATE `QRTZ_JOB_DETAILS` SET `JOB_CLASS_NAME` = 'com.fortify.manager.BLL.jobs.OrphanedDocInfoCleanupJob' WHERE JOB_NAME='OrphanedDocInfoCleanup';

UPDATE `QRTZ_JOB_DETAILS` SET `JOB_CLASS_NAME` = 'com.fortify.manager.BLL.jobs.ProjectVersionCopyJob' WHERE JOB_NAME='JOB_PROJECTVERSIONCOPY';

UPDATE `QRTZ_JOB_DETAILS` SET `JOB_CLASS_NAME` = 'com.fortify.manager.BLL.jobs.ProjectVersionCreateInWIEJob' WHERE JOB_NAME='JOB_PROJECTVERSIONCREATEINWIE';

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Update Data (x17)', 'EXECUTED', 'dbF360_4.0.0.xml', 'f360_4.0.0_32', '2.0.1', '3:b9b255579ac524cedffe8e0ed7a9dcd3', 142);

-- Changeset dbF360_4.0.0.xml::f360_4.0.0_33::hp_main::(Checksum: 3:f023b9fef3751a73eea3ce3e8f667fc2)
CREATE INDEX `IssueScanStatusUpdInd` ON `issue`(`projectVersion_id`, `engineType`, `id`, `scanStatus`, `lastScan_id`, `removedDate`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Create Index', 'EXECUTED', 'dbF360_4.0.0.xml', 'f360_4.0.0_33', '2.0.1', '3:f023b9fef3751a73eea3ce3e8f667fc2', 143);

-- Changeset dbF360_4.1.0.xml::f360_4.1.0_1::hp_main::(Checksum: 3:705ac69c67b24a78e1a669562f52c33a)
ALTER TABLE `sourcefilemap` ADD `matchingPath` VARCHAR(255);

CREATE INDEX `SourceFileScanMatchPathInd` ON `sourcefilemap`(`scan_id`, `matchingPath`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Add Column, Create Index', 'EXECUTED', 'dbF360_4.1.0.xml', 'f360_4.1.0_1', '2.0.1', '3:705ac69c67b24a78e1a669562f52c33a', 144);

-- Changeset dbF360_4.1.0.xml::f360_4.1.0_2::hp_main::(Checksum: 3:85d177d207138d328e31101a5441a4ad)
CREATE INDEX `AuditValueAttrGuidValueInd` ON `auditvalue`(`attrGuid`, `attrValue`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Create Index', 'EXECUTED', 'dbF360_4.1.0.xml', 'f360_4.1.0_2', '2.0.1', '3:85d177d207138d328e31101a5441a4ad', 145);

-- Changeset dbF360_4.1.0.xml::f360_4.1.0_3::hp::(Checksum: 3:d41d8cd98f00b204e9800998ecf8427e)
INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Empty', 'EXECUTED', 'dbF360_4.1.0.xml', 'f360_4.1.0_3', '2.0.1', '3:d41d8cd98f00b204e9800998ecf8427e', 146);

-- Changeset dbF360_4.1.0.xml::f360_4.1.0_4::hp_main::(Checksum: 3:c1f08f5d7a87fd3beaae7f09a5127c63)
ALTER TABLE `finding` MODIFY `guid` VARCHAR(255);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Modify data type', 'EXECUTED', 'dbF360_4.1.0.xml', 'f360_4.1.0_4', '2.0.1', '3:c1f08f5d7a87fd3beaae7f09a5127c63', 147);

-- Changeset dbF360_4.1.0.xml::f360_4.1.0_5::hp_main::(Checksum: 3:8ef19e371ab17d5b021780c82bedfe73)
ALTER TABLE `filterset` DROP FOREIGN KEY `RefPVFilterSet`;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Drop Foreign Key Constraint', 'EXECUTED', 'dbF360_4.1.0.xml', 'f360_4.1.0_5', '2.0.1', '3:8ef19e371ab17d5b021780c82bedfe73', 148);

-- Changeset dbF360_4.1.0.xml::f360_4.1.0_6::hp_main::(Checksum: 3:962ab7d35941f898245cb92e884864fe)
DROP INDEX `filterset_altkey_1` ON `filterset`;

delete from filterset where projectVersion_id is null;

ALTER TABLE `filterset` MODIFY `projectVersion_id` INT NOT NULL;

CREATE INDEX `filterset_altkey_1` ON `filterset`(`projectVersion_id`, `guid`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Drop Index, Custom SQL, Add Not-Null Constraint, Create Index', 'EXECUTED', 'dbF360_4.1.0.xml', 'f360_4.1.0_6', '2.0.1', '3:962ab7d35941f898245cb92e884864fe', 149);

-- Changeset dbF360_4.1.0.xml::f360_4.1.0_7::hp_main::(Checksum: 3:0cdd39c8805da4af176be50db84f6a71)
ALTER TABLE `filterset` ADD CONSTRAINT `RefPVFilterSet` FOREIGN KEY (`projectVersion_id`) REFERENCES `projectversion` (`id`) ON DELETE CASCADE;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Add Foreign Key Constraint', 'EXECUTED', 'dbF360_4.1.0.xml', 'f360_4.1.0_7', '2.0.1', '3:0cdd39c8805da4af176be50db84f6a71', 150);

-- Changeset dbF360_4.1.0.xml::f360_4.1.0_8::hp_main::(Checksum: 3:d370dfb8c9129fd2225c28fdf6888dab)
CREATE TABLE `scanerror` (`id` INT AUTO_INCREMENT  NOT NULL, `scan_id` INT NOT NULL, `errorCode` VARCHAR(20), `errorDescription` VARCHAR(4000), CONSTRAINT `ScanErrorPk` PRIMARY KEY (`id`));

ALTER TABLE `scanerror` ADD CONSTRAINT `RefScanErrorToScan` FOREIGN KEY (`scan_id`) REFERENCES `scan` (`id`) ON DELETE CASCADE;

CREATE UNIQUE INDEX `scanerror_altkey` ON `scanerror`(`scan_id`, `id`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Create Table, Add Foreign Key Constraint, Create Index', 'EXECUTED', 'dbF360_4.1.0.xml', 'f360_4.1.0_8', '2.0.1', '3:d370dfb8c9129fd2225c28fdf6888dab', 151);

-- Changeset dbF360_4.1.0.xml::f360_4.1.0_9::hp_main::(Checksum: 3:54b4061c195ad963cf65da46764bd9b7)
ALTER TABLE `rulepack` ADD `locale` VARCHAR(2);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Add Column', 'EXECUTED', 'dbF360_4.1.0.xml', 'f360_4.1.0_9', '2.0.1', '3:54b4061c195ad963cf65da46764bd9b7', 152);

-- Changeset dbF360_4.1.0.xml::f360_4.1.0_11::hp_main::(Checksum: 3:86e21c63a3359ddb8fe002a68786d09d)
CREATE TABLE `reportparameteroption` (`id` INT AUTO_INCREMENT  NOT NULL, `reportParameter_id` INT, `value` VARCHAR(100), `displayName` VARCHAR(255), `description` VARCHAR(2000), `defaultValue` CHAR(1) DEFAULT 'N' NOT NULL, `valueorder` INT, CONSTRAINT `ReportParameterOptionPk` PRIMARY KEY (`id`));

ALTER TABLE `reportparameteroption` ADD CONSTRAINT `ReportParameterOptionFk` FOREIGN KEY (`reportParameter_id`) REFERENCES `reportparameter` (`id`) ON DELETE CASCADE;

ALTER TABLE `reportparameter` MODIFY `dataType` VARCHAR(30);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Create Table, Add Foreign Key Constraint, Modify data type', 'EXECUTED', 'dbF360_4.1.0.xml', 'f360_4.1.0_11', '2.0.1', '3:86e21c63a3359ddb8fe002a68786d09d', 153);

-- Changeset dbF360_4.1.0.xml::f360_4.1.0_12::hp_main::(Checksum: 3:c95b393f19f5220397a3937d70806dac)
CREATE INDEX `RepParOptionRepParIdKey` ON `reportparameteroption`(`reportParameter_id`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Create Index', 'EXECUTED', 'dbF360_4.1.0.xml', 'f360_4.1.0_12', '2.0.1', '3:c95b393f19f5220397a3937d70806dac', 154);

-- Changeset dbF360_4.1.0.xml::f360_4.1.0_14::hp_main::(Checksum: 3:950396b40c994bd86f8dfba3658b4821)
DROP INDEX `idx_id_table_session_id` ON `id_table`;

DROP TABLE `id_table`;

CREATE TABLE `id_table` (`session_date` BIGINT NOT NULL, `session_id` INT NOT NULL, `id` INT NOT NULL);

CREATE INDEX `idx_id_table_session_date_id` ON `id_table`(`session_date`, `session_id`, `id`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Drop Index, Drop Table, Create Table, Create Index', 'EXECUTED', 'dbF360_4.1.0.xml', 'f360_4.1.0_14', '2.0.1', '3:950396b40c994bd86f8dfba3658b4821', 155);

-- Changeset dbF360_4.1.0.xml::f360_4.1.0_15::hp_main::(Checksum: 3:cf5622ccf188bbde85943d4a0993bd3e)
CREATE TABLE `pv_id_table` (`session_date` BIGINT NOT NULL, `session_id` INT NOT NULL, `id` INT NOT NULL);

CREATE INDEX `idx_pvid_table_session_date_id` ON `pv_id_table`(`session_date`, `session_id`, `id`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Create Table, Create Index', 'EXECUTED', 'dbF360_4.1.0.xml', 'f360_4.1.0_15', '2.0.1', '3:cf5622ccf188bbde85943d4a0993bd3e', 156);

-- Changeset dbF360Mssql_4.1.0.xml::f360Mssql_4.1.0_0::hp::(Checksum: 3:d41d8cd98f00b204e9800998ecf8427e)
INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Empty', 'EXECUTED', 'dbF360Mssql_4.1.0.xml', 'f360Mssql_4.1.0_0', '2.0.1', '3:d41d8cd98f00b204e9800998ecf8427e', 157);

-- Changeset dbF360Mssql_4.1.0.xml::f360Mssql_4.1.0_1::hp::(Checksum: 3:346446295b1952c44f9f07ffa573d810)
INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Drop Primary Key, Modify data type, Add Primary Key', 'MARK_RAN', 'dbF360Mssql_4.1.0.xml', 'f360Mssql_4.1.0_1', '2.0.1', '3:346446295b1952c44f9f07ffa573d810', 158);

-- Changeset dbF360_4.2.0.xml::f360_4.2.0_1::hp_main::(Checksum: 3:2eca095520ca6dca4d5dff995ac53936)
ALTER TABLE `scan` ADD `uploadStatus` VARCHAR(20) DEFAULT 'UNPROCESSED';

UPDATE `scan` SET `uploadStatus` = 'PROCESSED';

ALTER TABLE `scan` MODIFY `uploadStatus` VARCHAR(20) NOT NULL;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Add Column, Update Data, Add Not-Null Constraint', 'EXECUTED', 'dbF360_4.2.0.xml', 'f360_4.2.0_1', '2.0.1', '3:2eca095520ca6dca4d5dff995ac53936', 159);

-- Changeset dbF360_4.2.0.xml::f360_4.2.0_2::hp_main::(Checksum: 3:610da7c7a03f67ddc9909e415456be46)
ALTER TABLE `issuecache` DROP PRIMARY KEY;

ALTER TABLE `issuecache` ADD PRIMARY KEY (`projectVersion_id`, `filterSet_id`, `issue_id`);

ALTER TABLE `issuecache` MODIFY `folder_id` INT NULL;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Drop Primary Key, Add Primary Key, Drop Not-Null Constraint', 'EXECUTED', 'dbF360_4.2.0.xml', 'f360_4.2.0_2', '2.0.1', '3:610da7c7a03f67ddc9909e415456be46', 160);

-- Changeset dbF360_4.2.0.xml::f360_4.2.0_3::hp_main::(Checksum: 3:9b90aebe82dece1df39a9ea7a560b29e)
INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Drop Index', 'MARK_RAN', 'dbF360_4.2.0.xml', 'f360_4.2.0_3', '2.0.1', '3:9b90aebe82dece1df39a9ea7a560b29e', 161);

-- Changeset dbF360_4.2.0.xml::f360_4.2.0_4::hp_main::(Checksum: 3:558ad8a6c170f32c8e05ba5c15bb94f4)
DROP INDEX `analysisblob_pvid_iid` ON `analysisblob`;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Drop Index', 'EXECUTED', 'dbF360_4.2.0.xml', 'f360_4.2.0_4', '2.0.1', '3:558ad8a6c170f32c8e05ba5c15bb94f4', 162);

-- Changeset dbF360_4.2.0.xml::f360_4.2.0_5::hp_main::(Checksum: 3:00be35705512f3a9538c626a73cdaa23)
DROP INDEX `ScanIssueLinkScanIdInd` ON `scan_issue_link`;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Drop Index', 'EXECUTED', 'dbF360_4.2.0.xml', 'f360_4.2.0_5', '2.0.1', '3:00be35705512f3a9538c626a73cdaa23', 163);

-- Changeset dbF360_4.2.0.xml::f360_4.2.0_6a::hp_main::(Checksum: 3:b58015302d565d63bdbcbd4f0c569e2e)
DROP INDEX `scanissueidkey` ON `scan_issue`;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Drop Index', 'EXECUTED', 'dbF360_4.2.0.xml', 'f360_4.2.0_6a', '2.0.1', '3:b58015302d565d63bdbcbd4f0c569e2e', 164);

-- Changeset dbF360_4.2.0.xml::f360_4.2.0_6b::hp_main::(Checksum: 3:f2f457677fc1e8fc48a6b3bbfff5f884)
CREATE INDEX `IX_scanissue_issue` ON `scan_issue`(`scan_id`, `issue_id`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Create Index', 'EXECUTED', 'dbF360_4.2.0.xml', 'f360_4.2.0_6b', '2.0.1', '3:f2f457677fc1e8fc48a6b3bbfff5f884', 165);

-- Changeset dbF360_4.2.0.xml::f360_4.2.0_7::hp_main::(Checksum: 3:8eea4f7dd406a97cd916ca5767e12921)
CREATE INDEX `IX_issuecache_hidden` ON `issuecache`(`filterSet_id`, `projectVersion_id`, `hidden`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Create Index', 'EXECUTED', 'dbF360_4.2.0.xml', 'f360_4.2.0_7', '2.0.1', '3:8eea4f7dd406a97cd916ca5767e12921', 166);

-- Changeset dbF360_4.2.0.xml::f360_4.2.0_8a::hp_main::(Checksum: 3:c2f3195f749aa82e883c69ede6e8b66b)
DROP INDEX `issue_summary_idx` ON `issue`;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Drop Index', 'EXECUTED', 'dbF360_4.2.0.xml', 'f360_4.2.0_8a', '2.0.1', '3:c2f3195f749aa82e883c69ede6e8b66b', 167);

-- Changeset dbF360_4.2.0.xml::f360_4.2.0_8b::hp_main::(Checksum: 3:3d00d6d246da5dc57331e1cef4e099e7)
CREATE INDEX `IX_issue_visibilityAndStatus` ON `issue`(`projectVersion_id`, `suppressed`, `hidden`, `scanStatus`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Create Index', 'EXECUTED', 'dbF360_4.2.0.xml', 'f360_4.2.0_8b', '2.0.1', '3:3d00d6d246da5dc57331e1cef4e099e7', 168);

-- Changeset dbF360_4.2.0.xml::f360_4.2.0_9::hp_main::(Checksum: 3:87e31ebf4c5ff00ffdca5d174897a4ae)
CREATE UNIQUE INDEX `scanissue_alt_key` ON `scan_issue`(`scan_id`, `issueInstanceId`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Create Index', 'EXECUTED', 'dbF360_4.2.0.xml', 'f360_4.2.0_9', '2.0.1', '3:87e31ebf4c5ff00ffdca5d174897a4ae', 169);

-- Changeset dbF360_4.2.0.xml::f360_4.2.0.10::hp_main::(Checksum: 3:09d34d8c7813d5214949a575aa413fbb)
ALTER TABLE `issue` ADD `minVirtualCallConfidence` FLOAT NOT NULL DEFAULT 1;

ALTER TABLE `scan_issue` ADD `minVirtualCallConfidence` FLOAT NOT NULL DEFAULT 1;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Add Column (x2)', 'EXECUTED', 'dbF360_4.2.0.xml', 'f360_4.2.0.10', '2.0.1', '3:09d34d8c7813d5214949a575aa413fbb', 170);

-- Changeset dbF360_4.2.0.xml::f360_4.2.0.11::hp_main::(Checksum: 3:1fc1ad3d05e553148e5e5660f668f5d0)
UPDATE `permissiontemplate` SET `allApplicationRole` = 'Y' WHERE guid='admin';

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Update Data', 'EXECUTED', 'dbF360_4.2.0.xml', 'f360_4.2.0.11', '2.0.1', '3:1fc1ad3d05e553148e5e5660f668f5d0', 171);

-- Changeset dbF360_4.2.0.xml::f360_4.2.0_12::hp_main::(Checksum: 3:5e75d8522e432413093daa66996ce390)
ALTER TABLE `projecttemplate` ADD `obsolete` VARCHAR(1) NOT NULL DEFAULT 'N';

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Add Column', 'EXECUTED', 'dbF360_4.2.0.xml', 'f360_4.2.0_12', '2.0.1', '3:5e75d8522e432413093daa66996ce390', 172);

-- Changeset dbF360_4.2.0.xml::f360_4.2.0_12b::hp_main::(Checksum: 3:ade7ed205ad039bb7305fbde8aa0a8d5)
UPDATE `projecttemplate` SET `obsolete` = 'Y' WHERE guid in (
	'Classic-Priority_Project-Template',
	'Fortify-LowRisk-Project-Template',
	'Fortify-LowRisk3rdParty-Project-Template',
	'Fortify-HighRisk-Project-Template'
);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Update Data', 'EXECUTED', 'dbF360_4.2.0.xml', 'f360_4.2.0_12b', '2.0.1', '3:ade7ed205ad039bb7305fbde8aa0a8d5', 173);

-- Changeset dbF360_4.2.0.xml::f360_4.2.0_13::hp_spyglass::(Checksum: 3:27148ab75b34295e8dbc606320739292)
DROP TABLE `dynamicassessment`;

DROP TABLE `assessmentsite`;

DROP TABLE `payloadentry`;

DROP TABLE `payloadmessage`;

DROP TABLE `payloadartifact`;

DROP TABLE `publishaction`;

DROP TABLE `publishedreport`;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_spyglass', '', NOW(), 'Drop Table (x7)', 'EXECUTED', 'dbF360_4.2.0.xml', 'f360_4.2.0_13', '2.0.1', '3:27148ab75b34295e8dbc606320739292', 174);

-- Changeset dbF360_4.2.0.xml::f360_4.2.0_14::hp_spyglass::(Checksum: 3:1804404d001a70127e0a7bd9e4654d56)
ALTER TABLE `project` ADD `projectTemplate_id` INT;

ALTER TABLE `project` ADD CONSTRAINT `RefProjectProjTemplate` FOREIGN KEY (`projectTemplate_id`) REFERENCES `projecttemplate` (`id`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_spyglass', '', NOW(), 'Add Column, Add Foreign Key Constraint', 'EXECUTED', 'dbF360_4.2.0.xml', 'f360_4.2.0_14', '2.0.1', '3:1804404d001a70127e0a7bd9e4654d56', 175);

-- Changeset dbF360_4.2.0.xml::f360_4.2.0_15::hp_spyglass::(Checksum: 3:98b4ab32edd57e04a28fdef02908e761)
CREATE TABLE `project_user` (`project_id` INT NOT NULL, `userName` VARCHAR(255) NOT NULL, CONSTRAINT `PK_PROJECT_USER` PRIMARY KEY (`project_id`, `userName`)) engine innodb;

CREATE TABLE `projectpersonaassignment` (`project_id` INT NOT NULL, `persona_id` INT NOT NULL, `userName` VARCHAR(255) NOT NULL, CONSTRAINT `PK_PROJECTPERSONAASSIGNMENT` PRIMARY KEY (`project_id`, `persona_id`)) engine innodb;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_spyglass', '', NOW(), 'Create Table (x2)', 'EXECUTED', 'dbF360_4.2.0.xml', 'f360_4.2.0_15', '2.0.1', '3:98b4ab32edd57e04a28fdef02908e761', 176);

-- Changeset dbF360_4.2.0.xml::f360_4.2.0_16::hp_spyglass::(Checksum: 3:bb261bc46bd8b1d6c0916d0d105fadfc)
ALTER TABLE `project_user` ADD CONSTRAINT `RefProjectUserProject` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`) ON DELETE CASCADE;

ALTER TABLE `projectpersonaassignment` ADD CONSTRAINT `RefPPAProject` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`) ON DELETE CASCADE;

ALTER TABLE `projectpersonaassignment` ADD CONSTRAINT `RefPPAPersona` FOREIGN KEY (`persona_id`) REFERENCES `persona` (`id`) ON DELETE CASCADE;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_spyglass', '', NOW(), 'Add Foreign Key Constraint (x3)', 'EXECUTED', 'dbF360_4.2.0.xml', 'f360_4.2.0_16', '2.0.1', '3:bb261bc46bd8b1d6c0916d0d105fadfc', 177);

-- Changeset dbF360_4.2.0.xml::f360_4.2.0_17::hp_spyglass::(Checksum: 3:0b641832c8a59cbff194dc4d83729a73)
CREATE TABLE `metavalueproject` (`id` INT AUTO_INCREMENT  NOT NULL, `metaDef_id` INT NOT NULL, `textValue` VARCHAR(2000), `booleanValue` CHAR(1), `objectVersion` INT, `dateValue` DATE, `integerValue` BIGINT, `project_id` INT NOT NULL, CONSTRAINT `MetaValueProjectPk` PRIMARY KEY (`id`)) engine innodb;

CREATE TABLE `metavalueselectionproject` (`projectMetaValue_id` INT NOT NULL, `metaOption_id` INT NOT NULL, CONSTRAINT `MetaValueSelectionProjectPk` PRIMARY KEY (`projectMetaValue_id`, `metaOption_id`)) engine innodb;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_spyglass', '', NOW(), 'Create Table (x2)', 'EXECUTED', 'dbF360_4.2.0.xml', 'f360_4.2.0_17', '2.0.1', '3:0b641832c8a59cbff194dc4d83729a73', 178);

-- Changeset dbF360_4.2.0.xml::f360_4.2.0_18::hp_spyglass::(Checksum: 3:988d329782c194c45b602be6aeb6fcd8)
ALTER TABLE `metavalueproject` ADD CONSTRAINT `RefMetaDefProjMVUniq` UNIQUE (`metaDef_id`, `project_id`);

ALTER TABLE `metavalueproject` ADD CONSTRAINT `RefMetaValProj` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`) ON DELETE CASCADE;

ALTER TABLE `metavalueproject` ADD CONSTRAINT `RefMetaValProjMetaDef` FOREIGN KEY (`metaDef_id`) REFERENCES `metadef` (`id`) ON DELETE CASCADE;

ALTER TABLE `metavalueselectionproject` ADD CONSTRAINT `RefMVProjSelMVProj` FOREIGN KEY (`projectMetaValue_id`) REFERENCES `metavalueproject` (`id`);

ALTER TABLE `metavalueselectionproject` ADD CONSTRAINT `RefMVProjSelMVOption` FOREIGN KEY (`metaOption_id`) REFERENCES `metaoption` (`id`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_spyglass', '', NOW(), 'Add Unique Constraint, Add Foreign Key Constraint (x4)', 'EXECUTED', 'dbF360_4.2.0.xml', 'f360_4.2.0_18', '2.0.1', '3:988d329782c194c45b602be6aeb6fcd8', 179);

-- Changeset dbF360_4.2.0.xml::f360_4.2.0_19::hp_spyglass::(Checksum: 3:ff40abc4e96780184af14a7d19c9de37)
CREATE INDEX `idx_variable_name` ON `variable`(`name`);

ALTER TABLE `projectversion` ADD `latestSnapshot_id` INT;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_spyglass', '', NOW(), 'Create Index, Add Column', 'EXECUTED', 'dbF360_4.2.0.xml', 'f360_4.2.0_19', '2.0.1', '3:ff40abc4e96780184af14a7d19c9de37', 180);

-- Changeset dbF360_4.2.0_config.xml::f360_4.2.0_config_1::hp::(Checksum: 3:01ca1e2166682a1d497aa741cc03d71c)
CREATE TABLE `configproperty` (`groupName` VARCHAR(100), `propertyName` VARCHAR(128), `propertyValue` VARCHAR(1024), `objectVersion` INT DEFAULT 1, `description` VARCHAR(2048), `appliedAfterRestarting` VARCHAR(1) DEFAULT 'Y', `propertyType` VARCHAR(15) DEFAULT 'STRING' NOT NULL, `valuesList` VARCHAR(4000), `groupSwitch` VARCHAR(1) DEFAULT 'N');

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Create Table', 'EXECUTED', 'dbF360_4.2.0_config.xml', 'f360_4.2.0_config_1', '2.0.1', '3:01ca1e2166682a1d497aa741cc03d71c', 181);

-- Changeset dbF360_4.2.0_config.xml::f360_4.2.0_config_2::hp::(Checksum: 3:5e0b80b4df507f3cdd06edbb05f42e54)
INSERT INTO `configproperty` (`description`, `groupName`, `propertyName`, `propertyType`, `propertyValue`) VALUES ('Inactive Session Timeout (minutes)', 'core', 'relative.session.timeout.minutes', 'INTEGER', '30');

INSERT INTO `configproperty` (`description`, `groupName`, `propertyName`, `propertyType`, `propertyValue`) VALUES ('Absolute Session Timeout (minutes)', 'core', 'absolute.session.timeout.minutes', 'INTEGER', '240');

INSERT INTO `configproperty` (`description`, `groupName`, `propertyName`, `propertyType`, `propertyValue`) VALUES ('Login Attempts before Lockout', 'core', 'authentication.max_failed_login_attempts', 'INTEGER', '3');

INSERT INTO `configproperty` (`description`, `groupName`, `propertyName`, `propertyType`, `propertyValue`) VALUES ('Days before password reset', 'core', 'authentication.days_password_valid', 'INTEGER', '30');

INSERT INTO `configproperty` (`description`, `groupName`, `propertyName`, `propertyType`, `propertyValue`) VALUES ('Lockout time (minutes)', 'core', 'authentication.minutes_user_frozen', 'INTEGER', '30');

INSERT INTO `configproperty` (`description`, `groupName`, `propertyName`, `propertyType`, `propertyValue`) VALUES ('Rulepack Update URL', 'core', 'rulepack.update.url', 'URL', 'https://update.fortify.com');

INSERT INTO `configproperty` (`description`, `groupName`, `propertyName`) VALUES ('Proxy for Rulepack Update', 'core', 'rulepack.update.proxy.host');

INSERT INTO `configproperty` (`description`, `groupName`, `propertyName`, `propertyType`) VALUES ('Proxy Port', 'core', 'rulepack.update.proxy.port', 'INTEGER');

INSERT INTO `configproperty` (`description`, `groupName`, `propertyName`) VALUES ('Proxy Username', 'core', 'rulepack.update.proxy.username');

INSERT INTO `configproperty` (`description`, `groupName`, `propertyName`, `propertyType`) VALUES ('Proxy Password', 'core', 'rulepack.update.proxy.password', 'ENCODEDHIDDEN');

INSERT INTO `configproperty` (`description`, `groupName`, `propertyName`) VALUES ('Locale for Rulepacks', 'core', 'rulepack.update.locale');

INSERT INTO `configproperty` (`description`, `groupName`, `propertyName`, `propertyType`, `propertyValue`) VALUES ('Maximum Events Per Security Scope Issue (the maximum number of events to store in the details of an issue when converting events to issues)', 'core', 'events.to.issues.max.events', 'INTEGER', '5');

INSERT INTO `configproperty` (`description`, `groupName`, `propertyName`, `propertyType`, `propertyValue`) VALUES ('Base URL for Runtime Event description server (it''s also used when converting events to issues)', 'core', 'runtime.event.description.url', 'URL', 'https://content.fortify.com/products/360/rta/descriptions/');

INSERT INTO `configproperty` (`description`, `groupName`, `propertyName`, `propertyType`, `propertyValue`) VALUES ('Display user first/last names and e-mails in user fields, along with login names', 'core', 'display.user.details', 'BOOLEAN', 'true');

INSERT INTO `configproperty` (`description`, `groupName`, `propertyName`, `propertyType`) VALUES ('User Administrator''s Email Address (for user account requests)', 'core', 'user.administrator.email', 'EMAIL');

INSERT INTO `configproperty` (`description`, `groupName`, `groupSwitch`, `propertyName`, `propertyType`, `propertyValue`) VALUES ('Enable CAS Integration', 'cas', 'Y', 'cas.enabled', 'BOOLEAN', 'false');

INSERT INTO `configproperty` (`description`, `groupName`, `propertyName`, `propertyType`, `propertyValue`) VALUES ('CAS Server URL', 'cas', 'cas.server.url', 'URL', 'http://localhost:8080/cas');

INSERT INTO `configproperty` (`description`, `groupName`, `propertyName`, `propertyType`, `propertyValue`) VALUES ('HP Software Security Center Location', 'cas', 'cas.f360.server.location', 'URL', 'http://localhost:8180/ssc');

INSERT INTO `configproperty` (`description`, `groupName`, `propertyName`, `propertyType`, `propertyValue`) VALUES ('CloudScan Controller URL', 'cloudscan', 'cloud.ctrl.url', 'URL', 'http://localhost:8080/cloud-ctrl');

INSERT INTO `configproperty` (`description`, `groupName`, `propertyName`, `propertyType`, `propertyValue`) VALUES ('CloudCtrl status polling enablement', 'cloudscan', 'cloud.ctrl.poll.enabled', 'BOOLEAN', 'false');

INSERT INTO `configproperty` (`description`, `groupName`, `propertyName`, `propertyType`, `propertyValue`) VALUES ('CloudCtrl polling period (seconds)', 'cloudscan', 'cloud.ctrl.poll.period', 'INTEGER', '120');

INSERT INTO `configproperty` (`description`, `groupName`, `propertyName`, `propertyValue`) VALUES ('SSC and CloudScan Controller Shared Secret', 'cloudscan', 'ssc.cloud.ctrl.secret', 'changeme');

INSERT INTO `configproperty` (`description`, `groupName`, `groupSwitch`, `propertyName`, `propertyType`, `propertyValue`) VALUES ('Enable Email for sending alerts', 'email', 'Y', 'email.enabled', 'BOOLEAN', 'false');

INSERT INTO `configproperty` (`description`, `groupName`, `propertyName`, `propertyValue`) VALUES ('SMTP Server', 'email', 'email.server', 'mail.example.com');

INSERT INTO `configproperty` (`description`, `groupName`, `propertyName`, `propertyType`, `propertyValue`) VALUES ('SMTP Server Port', 'email', 'email.server.port', 'INTEGER', '25');

INSERT INTO `configproperty` (`description`, `groupName`, `propertyName`, `propertyType`, `propertyValue`) VALUES ('From e-mail address', 'email', 'email.addr.from', 'EMAIL', 'fortifyserver@example.com');

INSERT INTO `configproperty` (`description`, `groupName`, `propertyName`, `propertyType`, `propertyValue`) VALUES ('SMTP username', 'email', 'email.server.username', 'ENCODED', 'AGAbY6O1qDV4p7lhkklU0S/k7O46SrqvJGAEUBsfus8h');

INSERT INTO `configproperty` (`description`, `groupName`, `propertyName`, `propertyType`, `propertyValue`) VALUES ('SMTP password', 'email', 'email.server.password', 'ENCODEDHIDDEN', 'AGAbY6O1qDV4p7lhkklU0S/k7O46SrqvJGAEUBsfus8h');

INSERT INTO `configproperty` (`description`, `groupName`, `propertyName`, `propertyValue`) VALUES ('Default encoding of the email content', 'email', 'email.default.encoding', 'UTF-8');

INSERT INTO `configproperty` (`description`, `groupName`, `groupSwitch`, `propertyName`, `propertyType`, `propertyValue`) VALUES ('Publish System Events to JMS', 'jms', 'Y', 'jms.publish.events', 'BOOLEAN', 'false');

INSERT INTO `configproperty` (`description`, `groupName`, `propertyName`, `propertyType`, `propertyValue`) VALUES ('Include username in JMS body', 'jms', 'jms.include.username', 'BOOLEAN', 'true');

INSERT INTO `configproperty` (`description`, `groupName`, `propertyName`, `propertyValue`) VALUES ('JMS Topic', 'jms', 'jms.topic', 'Fortify.Advisory.EventNotification');

INSERT INTO `configproperty` (`description`, `groupName`, `propertyName`, `propertyValue`) VALUES ('JMS Server URL', 'jms', 'jms.broker.url', 'tcp://127.0.0.1:61616');

INSERT INTO `configproperty` (`description`, `groupName`, `propertyName`, `propertyValue`) VALUES ('a comma-separated list of the daysOfWeek for the historical collection job to run.  * means run every day.  1 means Sunday, 2 means Monday, etc', 'scheduler', 'snapshot.daysOfWeek', '*');

INSERT INTO `configproperty` (`description`, `groupName`, `propertyName`, `propertyValue`) VALUES ('a comma-separated list of the hours of the day for the historical collection job to run.  * means run every hour.', 'scheduler', 'snapshot.hours', '0');

INSERT INTO `configproperty` (`description`, `groupName`, `propertyName`, `propertyValue`) VALUES ('a comma-separated list of the minutes of each hour for the historical collection job to run.  Do not run more than once every 5 minutes.', 'scheduler', 'snapshot.minutes', '0');

INSERT INTO `configproperty` (`description`, `groupName`, `groupSwitch`, `propertyName`, `propertyType`, `propertyValue`) VALUES ('Enable Runtime', 'runtime', 'Y', 'runtime.federation.enabled', 'BOOLEAN', 'false');

INSERT INTO `configproperty` (`description`, `groupName`, `propertyName`, `propertyType`, `propertyValue`) VALUES ('Port for Runtime federation', 'runtime', 'runtime.port', 'INTEGER', '10234');

INSERT INTO `configproperty` (`description`, `groupName`, `propertyName`, `propertyValue`) VALUES ('Email addresses (comma separated) to notify when a runtime configuration errors occurs', 'runtime', 'rtcontroller.sysadmin.email.addresses', 'noone@example.com');

INSERT INTO `configproperty` (`description`, `groupName`, `propertyName`, `propertyType`, `propertyValue`) VALUES ('Enforce strice sertificate checking', 'runtime', 'runtime.strict.certificate.checking', 'BOOLEAN', 'true');

INSERT INTO `configproperty` (`description`, `groupName`, `groupSwitch`, `propertyName`, `propertyType`, `propertyValue`) VALUES ('Enable SSO Integration. WARNING: Single-Sign-On should only be enabled for a locked-down HP Fortify Software Security Center instance, with Apache Agent capable of SSO authentication in front. The SSO-enabled Apache Agent should pass trusted HTTP headers to SSC. For more information, please refer to HP Fortify Software Security Center Deployment Guide', 'sso', 'Y', 'sso.enabled', 'BOOLEAN', 'false');

INSERT INTO `configproperty` (`description`, `groupName`, `propertyName`, `propertyValue`) VALUES ('HTTP Header for Username. NOTE: that the sso_header_username must always be used to retrieve the username from the SSO headers and this value must match the ldap.attribute.username property in ldap.properties', 'sso', 'sso.header.username', 'username');

INSERT INTO `configproperty` (`description`, `groupName`, `propertyName`, `propertyType`, `propertyValue`) VALUES ('Allow Token Authentication', 'webservices', 'allow.token.authentication', 'BOOLEAN', 'true');

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Insert Row (x43)', 'EXECUTED', 'dbF360_4.2.0_config.xml', 'f360_4.2.0_config_2', '2.0.1', '3:5e0b80b4df507f3cdd06edbb05f42e54', 182);

-- Changeset dbF360_4.2.0_config.xml::f360_4.2.0_config_3::hp::(Checksum: 3:be3e5e0410bbe10517011de75745e8db)
CREATE UNIQUE INDEX `idx_configproperty_group_prop` ON `configproperty`(`groupName`, `propertyName`);

CREATE UNIQUE INDEX `idx_configproperty_propName` ON `configproperty`(`propertyName`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Create Index (x2)', 'EXECUTED', 'dbF360_4.2.0_config.xml', 'f360_4.2.0_config_3', '2.0.1', '3:be3e5e0410bbe10517011de75745e8db', 183);

-- Changeset dbF360_4.2.0_config.xml::f360_4.2.0_config_4::hp::(Checksum: 3:f98b33d10b4a12afe27b26e8cea979f4)
CREATE TABLE `applicationstate` (`id` INT NOT NULL, `restartRequired` VARCHAR(1) DEFAULT 'N', `configVisitRequired` VARCHAR(1) DEFAULT 'Y', CONSTRAINT `PK_APPLICATIONSTATE` PRIMARY KEY (`id`));

INSERT INTO `applicationstate` (`configVisitRequired`, `id`, `restartRequired`) VALUES ('Y', 1, 'N');

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Create Table, Insert Row', 'EXECUTED', 'dbF360_4.2.0_config.xml', 'f360_4.2.0_config_4', '2.0.1', '3:f98b33d10b4a12afe27b26e8cea979f4', 184);

-- Changeset dbF360Mysql_4.2.0.xml::f360Mysql_4.2.0_0::hp::(Checksum: 3:06fa5d66639b537559571c2d051062e0)
ALTER TABLE `issue` ROW_FORMAT=DYNAMIC;

ALTER TABLE `scan_issue` ROW_FORMAT=DYNAMIC;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Custom SQL', 'EXECUTED', 'dbF360Mysql_4.2.0.xml', 'f360Mysql_4.2.0_0', '2.0.1', '3:06fa5d66639b537559571c2d051062e0', 185);

-- Changeset dbF360_4.3.0.xml::f360_4.3.0_1::hp_main::(Checksum: 3:d12c036c06312e685e0df343d8e3e144)
UPDATE `QRTZ_JOB_DETAILS` SET `REQUESTS_RECOVERY` = '1' WHERE JOB_NAME = 'JOB_HISTORICALSNAPSHOT' AND JOB_GROUP = 'JOBGROUP_HISTORICALSNAPSHOT';

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Update Data', 'EXECUTED', 'dbF360_4.3.0.xml', 'f360_4.3.0_1', '2.0.1', '3:d12c036c06312e685e0df343d8e3e144', 186);

-- Changeset dbF360_4.3.0.xml::f360_4.3.0_2::hp_main::(Checksum: 3:1c0adf12793ee9f91c5468568b228550)
CREATE TABLE `project_ldapentity` (`project_id` INT NOT NULL, `ldap_id` INT NOT NULL, CONSTRAINT `PK_PROJECT_LDAPENTITY` PRIMARY KEY (`project_id`, `ldap_id`)) engine innodb;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Create Table', 'EXECUTED', 'dbF360_4.3.0.xml', 'f360_4.3.0_2', '2.0.1', '3:1c0adf12793ee9f91c5468568b228550', 187);

-- Changeset dbF360_4.3.0.xml::f360_4.3.0_20::hp_main::(Checksum: 3:fa0f54ce7923b38ad13a062db42f1db1)
CREATE TABLE `jobqueue` (`jobName` VARCHAR(255) NOT NULL, `jobGroup` VARCHAR(255) NOT NULL, `jobClassName` VARCHAR(128) NOT NULL, `projectVersion_id` BIGINT, `artifact_id` BIGINT, `userName` VARCHAR(255), `state` INT, `executionOrder` decimal(31,8) NOT NULL, `jobData` MEDIUMBLOB, `startTime` TIMESTAMP NULL DEFAULT NULL, `finishTime` TIMESTAMP NULL DEFAULT NULL, CONSTRAINT `PK_JOBQUEUE` PRIMARY KEY (`jobName`), CONSTRAINT `UQ_EXECUTIONORDER` UNIQUE (`executionOrder`));

CREATE INDEX `JOBGROUP_STATE_IDX` ON `jobqueue`(`jobGroup`, `state`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Create Table, Create Index', 'EXECUTED', 'dbF360_4.3.0.xml', 'f360_4.3.0_20', '2.0.1', '3:fa0f54ce7923b38ad13a062db42f1db1', 188);

-- Changeset dbF360_4.3.0.xml::f360_4.3.0_21::hp_main::(Checksum: 3:170b59121b5c59204d2e8e52f9a57678)
INSERT INTO `configproperty` (`description`, `groupName`, `propertyName`, `propertyType`, `propertyValue`) VALUES ('Number of days after which executed jobs will be removed', 'scheduler', 'job.cleanExecutedAfter.days', 'INTEGER', '1');

INSERT INTO `configproperty` (`description`, `groupName`, `propertyName`, `propertyType`, `propertyValue`, `valuesList`) VALUES ('Job execution strategy', 'scheduler', 'job.executionStrategy.class', 'OPTIONLIST', 'com.fortify.manager.service.scheduler.SchedulerConservativeStrategy', 'Conservative|||||com.fortify.manager.service.scheduler.SchedulerConservativeStrategy-----Aggressive|||||com.fortify.manager.service.scheduler.SchedulerAggressiveStrategy-----Exclusive jobs|||||com.fortify.manager.service.scheduler.SchedulerExclusiveJobsStrategy');

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Insert Row (x2)', 'EXECUTED', 'dbF360_4.3.0.xml', 'f360_4.3.0_21', '2.0.1', '3:170b59121b5c59204d2e8e52f9a57678', 189);

-- Changeset dbF360_4.3.0.xml::f360_4.3.0_22::hp_main::(Checksum: 3:7512121f3e1fdb1387b9f416917e9427)
DELETE FROM `QRTZ_CRON_TRIGGERS`  WHERE TRIGGER_GROUP='JOBGROUP_HISTORICALSNAPSHOT';

DELETE FROM `QRTZ_CRON_TRIGGERS`  WHERE TRIGGER_GROUP='DEFAULT' AND TRIGGER_NAME IN ('alertReminderTrigger',
				'idTableCleanupTrigger',
				'ldapCacheRefreshTrigger',
				'orphanedDocInfoCleanupTrigger');

DELETE FROM `QRTZ_TRIGGERS`  WHERE TRIGGER_GROUP='JOBGROUP_HISTORICALSNAPSHOT' AND TRIGGER_TYPE='CRON';

DELETE FROM `QRTZ_TRIGGERS`  WHERE TRIGGER_GROUP='DEFAULT' AND TRIGGER_NAME IN ('alertReminderTrigger',
				'idTableCleanupTrigger',
				'ldapCacheRefreshTrigger',
				'orphanedDocInfoCleanupTrigger');

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Delete Data (x4)', 'EXECUTED', 'dbF360_4.3.0.xml', 'f360_4.3.0_22', '2.0.1', '3:7512121f3e1fdb1387b9f416917e9427', 190);

-- Changeset dbF360_4.3.0.xml::f360_4.3.0_23::hp_main::(Checksum: 3:b983f386f9a09f21720b8baab9fa33c6)
CREATE INDEX `MONITORED_INSTANCE_ID_IDX` ON `alert`(`monitoredInstanceId`, `monitoredEntityType`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Create Index', 'EXECUTED', 'dbF360_4.3.0.xml', 'f360_4.3.0_23', '2.0.1', '3:b983f386f9a09f21720b8baab9fa33c6', 191);

-- Changeset dbF360_4.3.0.xml::f360_4.3.0_24::hp_main::(Checksum: 3:d48aad736c938832e2e037bafe8bbabb)
CREATE INDEX `METAVALUE_METADEF_ID_IDX` ON `metavalue`(`metaDef_id`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Create Index', 'EXECUTED', 'dbF360_4.3.0.xml', 'f360_4.3.0_24', '2.0.1', '3:d48aad736c938832e2e037bafe8bbabb', 192);

-- Changeset dbF360_4.3.0.xml::f360_4.3.0_25::hp_main::(Checksum: 3:0eb3d76ff6f506c5a03ae376aa3d8460)
CREATE TABLE `snapshotquickvalues` (`snapshot_id` INT NOT NULL, `issues` INT NOT NULL, `cfpo` INT NOT NULL, `hfpo` INT NOT NULL, `mfpo` INT NOT NULL, `lfpo` INT NOT NULL, `cfpoAudited` INT NOT NULL, `hfpoAudited` INT NOT NULL, `mfpoAudited` INT NOT NULL, `lfpoAudited` INT NOT NULL, `cfpoUnaudited` INT NOT NULL, `hfpoUnaudited` INT NOT NULL, `mfpoUnaudited` INT NOT NULL, `lfpoUnaudited` INT NOT NULL, CONSTRAINT `PK_SNAPSHOTQUICKVALUES` PRIMARY KEY (`snapshot_id`));

ALTER TABLE `snapshotquickvalues` ADD CONSTRAINT `RefQuickValuesSnapshot` FOREIGN KEY (`snapshot_id`) REFERENCES `snapshot` (`id`) ON DELETE CASCADE;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Create Table, Add Foreign Key Constraint', 'EXECUTED', 'dbF360_4.3.0.xml', 'f360_4.3.0_25', '2.0.1', '3:0eb3d76ff6f506c5a03ae376aa3d8460', 193);

-- Changeset dbF360_4.3.0.xml::f360_4.3.0_26::hp_main::(Checksum: 3:29d3bc695c47855f11605a4ccf621f06)
ALTER TABLE `projectversion` ADD `status` VARCHAR(20);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Add Column', 'EXECUTED', 'dbF360_4.3.0.xml', 'f360_4.3.0_26', '2.0.1', '3:29d3bc695c47855f11605a4ccf621f06', 194);

-- Changeset dbF360_4.3.0.xml::f360_4.3.0_27::hp_main::(Checksum: 3:f03f4f961950833a40f0cd83760235ef)
UPDATE `configproperty` SET `propertyType` = 'URL' WHERE propertyName = 'jms.broker.url';

UPDATE `configproperty` SET `propertyType` = 'HOSTNAME' WHERE propertyName = 'rulepack.update.proxy.host';

UPDATE `configproperty` SET `propertyType` = 'MULTI_EMAIL' WHERE propertyName = 'rtcontroller.sysadmin.email.addresses';

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Update Data (x3)', 'EXECUTED', 'dbF360_4.3.0.xml', 'f360_4.3.0_27', '2.0.1', '3:f03f4f961950833a40f0cd83760235ef', 195);

-- Changeset dbF360_4.3.0.xml::f360_4.3.0_28::hp_main::(Checksum: 3:844802d828d14275667510b08fba9031)
CREATE INDEX `AB_PV_ISSUEINSTANCE_IDX` ON `analysisblob`(`projectVersion_id`, `issueInstanceId`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Create Index', 'EXECUTED', 'dbF360_4.3.0.xml', 'f360_4.3.0_28', '2.0.1', '3:844802d828d14275667510b08fba9031', 196);

-- Changeset dbF360_4.3.0.xml::f360_4.3.0_30::hp_main::(Checksum: 3:f72b02e609642b0313171fd5939d9077)
DROP INDEX `IX_issue_folder_update` ON `issue`;

DROP INDEX `IX_issuecache_hidden` ON `issuecache`;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Drop Index (x2)', 'EXECUTED', 'dbF360_4.3.0.xml', 'f360_4.3.0_30', '2.0.1', '3:f72b02e609642b0313171fd5939d9077', 197);

-- Changeset dbF360_4.3.0.xml::f360_4.3.0_31::hp_main::(Checksum: 3:5c1959f58e8f808ef3db3ebba18becf8)
DROP INDEX `IssueAltKeyWithEngineType` ON `issue`;

DROP INDEX `IssueCorrelatedUpdInd` ON `issue`;

DROP INDEX `IssueEngineStatusAltKey` ON `issue`;

DROP INDEX `IssueLastScanIdUpdateInd` ON `issue`;

DROP INDEX `IssueProjLastScanAltKey` ON `issue`;

DROP INDEX `IssueScanStatusUpdInd` ON `issue`;

DROP INDEX `IssueUpdateFoundDateInd` ON `issue`;

DROP INDEX `IssueUpdScanStatusRemDateInd` ON `issue`;

DROP INDEX `Issue_Alt_Key` ON `issue`;

DROP INDEX `issue_mappedCategory_idx` ON `issue`;

DROP INDEX `IX_issue_conf_sev` ON `issue`;

DROP INDEX `IX_issue_removeddate` ON `issue`;

DROP INDEX `IX_issue_visibilityAndStatus` ON `issue`;

CREATE INDEX `PV_SCAN_IDX` ON `issue`(`projectVersion_id`, `engineType`, `lastScan_id`, `scanStatus`);

CREATE INDEX `PV_CATEGORY_IDX` ON `issue`(`projectVersion_id`, `mappedCategory`, `suppressed`, `scanStatus`);

CREATE INDEX `PV_SEVERITY_IDX` ON `issue`(`projectVersion_id`, `severity`, `audienceSet`, `confidence`);

CREATE INDEX `PV_IMPACT_IDX` ON `issue`(`projectVersion_id`, `impact`, `likelihood`, `suppressed`, `scanStatus`);

CREATE INDEX `PV_FRIORITY_IDX` ON `issue`(`projectVersion_id`, `friority`, `suppressed`, `scanStatus`);

CREATE INDEX `BUG_IDX` ON `issue`(`bug_id`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Drop Index (x13), Create Index (x6)', 'EXECUTED', 'dbF360_4.3.0.xml', 'f360_4.3.0_31', '2.0.1', '3:5c1959f58e8f808ef3db3ebba18becf8', 198);

-- Changeset dbF360_4.3.0.xml::f360_4.3.0_32::hp_main::(Checksum: 3:fdec8b487a8e8932ff7f5d47585cca67)
CREATE INDEX `PV_STATE_IDX` ON `issue`(`projectVersion_id`, `issueState`, `suppressed`, `scanStatus`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Create Index', 'EXECUTED', 'dbF360_4.3.0.xml', 'f360_4.3.0_32', '2.0.1', '3:fdec8b487a8e8932ff7f5d47585cca67', 199);

-- Changeset dbF360_4.3.0.xml::f360_4.3.0_33::hp_main::(Checksum: 3:e603eb26685748750fe24b5d93d3373e)
CREATE INDEX `CPEC_NAME_IDX` ON `catpackexternalcategory`(`catPackExternalList_id`, `name`, `id`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Create Index', 'EXECUTED', 'dbF360_4.3.0.xml', 'f360_4.3.0_33', '2.0.1', '3:e603eb26685748750fe24b5d93d3373e', 200);

-- Changeset dbF360_4.3.0.xml::f360_4.3.0_34::hp_main::(Checksum: 3:7bb80781bbf223bf3dd8f5c970ee02b2)
CREATE INDEX `SCAN_PV_IDX` ON `scan_issue`(`scan_id`, `projectVersion_id`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Create Index', 'EXECUTED', 'dbF360_4.3.0.xml', 'f360_4.3.0_34', '2.0.1', '3:7bb80781bbf223bf3dd8f5c970ee02b2', 201);

-- Changeset dbF360_4.3.0.xml::f360_4.3.0_35::hp_main::(Checksum: 3:d2f78161c6958ff07861c10bed8efa00)
CREATE INDEX `PV_ID_IDX` ON `issue`(`projectVersion_id`, `id`, `friority`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Create Index', 'EXECUTED', 'dbF360_4.3.0.xml', 'f360_4.3.0_35', '2.0.1', '3:d2f78161c6958ff07861c10bed8efa00', 202);

-- Changeset dbF360_4.3.0.xml::f360_4.3.0_37::hp_main::(Checksum: 3:77807a7240c44764a941e7d4cdb47e62)
ALTER TABLE `auditvalue` DROP FOREIGN KEY `RefIssAuditVal`;

ALTER TABLE `audithistory` DROP FOREIGN KEY `RefIssAuditHis`;

ALTER TABLE `auditcomment` DROP FOREIGN KEY `RefIssAuditComment`;

ALTER TABLE `issuecache` DROP FOREIGN KEY `fk_issuecache_issue`;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Drop Foreign Key Constraint (x4)', 'EXECUTED', 'dbF360_4.3.0.xml', 'f360_4.3.0_37', '2.0.1', '3:77807a7240c44764a941e7d4cdb47e62', 203);

-- Changeset dbF360_4.3.0.xml::f360_4.3.0_39::hp_main::(Checksum: 3:9f5444d8c28482a4e323d634681fca7b)
ALTER TABLE `scan_issue` MODIFY `vulnerableParameter` VARCHAR(200);

ALTER TABLE `issue` MODIFY `vulnerableParameter` VARCHAR(200);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Modify data type (x2)', 'EXECUTED', 'dbF360_4.3.0.xml', 'f360_4.3.0_39', '2.0.1', '3:9f5444d8c28482a4e323d634681fca7b', 204);

-- Changeset dbF360_4.3.0.xml::f360_4.3.0_40::hp_main::(Checksum: 3:727fa900e1d1551157866efe171c354d)
ALTER TABLE `metadef` ADD `systemUsage` VARCHAR(50);

UPDATE `metadef` SET `systemUsage` = 'USER_DEFINED_DELETABLE' WHERE systemUsage IS NULL;

ALTER TABLE `metadef` MODIFY `systemUsage` VARCHAR(50) NOT NULL;

ALTER TABLE `metadef` ALTER `systemUsage` SET DEFAULT 'USER_DEFINED_DELETABLE';

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Add Column, Add Not-Null Constraint, Add Default Value', 'EXECUTED', 'dbF360_4.3.0.xml', 'f360_4.3.0_40', '2.0.1', '3:727fa900e1d1551157866efe171c354d', 205);

-- Changeset dbF360Mysql_4.3.0.xml::f360Mysql_4.3.0_0::hp_main::(Checksum: 3:7642e22b19c081f7ef99462eff86875a)
ALTER TABLE `hostlogmessage` ADD `msg_new` TEXT;

UPDATE hostlogmessage set msg_new = msg;

ALTER TABLE `hostlogmessage` DROP COLUMN `msg`;

ALTER TABLE `hostlogmessage` CHANGE `msg_new` `msg` TEXT;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Custom SQL', 'EXECUTED', 'dbF360Mysql_4.3.0.xml', 'f360Mysql_4.3.0_0', '2.0.1', '3:7642e22b19c081f7ef99462eff86875a', 206);

-- Changeset dbF360Mysql_4.3.0.xml::f360Mysql_4.3.0_1::hp_main::(Checksum: 3:f32abdb45c32cda8df42eee17aee6027)
DROP INDEX `ISSUE_BUG_IND` ON `issue`;

DROP INDEX `catPackExtCatNameExtListId_idx` ON `catpackexternalcategory`;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Drop Index (x2)', 'EXECUTED', 'dbF360Mysql_4.3.0.xml', 'f360Mysql_4.3.0_1', '2.0.1', '3:f32abdb45c32cda8df42eee17aee6027', 207);

-- Changeset dbF360Mysql_4.3.0.xml::f360Mysql_4.3.0_2::hp_main::(Checksum: 3:d2ebac299ed4fc3946cd4b9ba7af380b)
CREATE UNIQUE INDEX `PV_ISSUEINSTANCE_IDX` ON `issue`(`projectVersion_id`, `issueInstanceId`, `engineType`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Create Index', 'EXECUTED', 'dbF360Mysql_4.3.0.xml', 'f360Mysql_4.3.0_2', '2.0.1', '3:d2ebac299ed4fc3946cd4b9ba7af380b', 208);

-- Changeset dbF360_4.3.1.xml::f360_4.3.1_1::hp::(Checksum: 3:6f97c4047e7bc4048136b690ade2ca33)
-- Add column for ordering configuration properties
ALTER TABLE `configproperty` ADD `propertyOrder` INT;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', 'Add column for ordering configuration properties', NOW(), 'Add Column', 'EXECUTED', 'dbF360_4.3.1.xml', 'f360_4.3.1_1', '2.0.1', '3:6f97c4047e7bc4048136b690ade2ca33', 209);

-- Changeset dbF360_4.3.1.xml::f360_4.3.1_2::hp::(Checksum: 3:8177a69570a51a7c8859924622fc2f6a)
CREATE TABLE `reportexecparam` (`paramType` VARCHAR(8) NOT NULL, `paramKey` VARCHAR(255) NOT NULL, `paramValue` VARCHAR(2000));

CREATE TABLE `reportexecblob` (`blobType` VARCHAR(8) NOT NULL, `originalFilename` VARCHAR(255) NOT NULL, `data` MEDIUMBLOB);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Create Table (x2)', 'EXECUTED', 'dbF360_4.3.1.xml', 'f360_4.3.1_2', '2.0.1', '3:8177a69570a51a7c8859924622fc2f6a', 210);

-- Changeset dbF360_4.3.1.xml::f360_4.3.1_4::hp::(Checksum: 3:d33eecbfb5e5bc29a5c8299060c4ecc7)
ALTER TABLE `reportexecparam` ADD `savedReport_id` INT NOT NULL DEFAULT 0;

ALTER TABLE `reportexecblob` ADD `savedReport_id` INT NOT NULL DEFAULT 0;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Add Column (x2)', 'EXECUTED', 'dbF360_4.3.1.xml', 'f360_4.3.1_4', '2.0.1', '3:d33eecbfb5e5bc29a5c8299060c4ecc7', 211);

-- Changeset dbF360_4.3.1.xml::f360_4.3.1_5::hp::(Checksum: 3:41e49e3dab356a546eeee3476bffdfb6)
ALTER TABLE `reportexecparam` ADD PRIMARY KEY (`savedReport_id`, `paramKey`);

ALTER TABLE `reportexecblob` ADD PRIMARY KEY (`savedReport_id`, `originalFilename`);

ALTER TABLE `reportexecblob` ADD CONSTRAINT `RefReportExecBlobSavedReport` FOREIGN KEY (`savedReport_id`) REFERENCES `savedreport` (`id`) ON DELETE CASCADE;

ALTER TABLE `reportexecparam` ADD CONSTRAINT `RefReportExecParamSavedReport` FOREIGN KEY (`savedReport_id`) REFERENCES `savedreport` (`id`) ON DELETE CASCADE;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Add Primary Key (x2), Add Foreign Key Constraint (x2)', 'EXECUTED', 'dbF360_4.3.1.xml', 'f360_4.3.1_5', '2.0.1', '3:41e49e3dab356a546eeee3476bffdfb6', 212);

-- Changeset dbF360_4.3.1.xml::f360_4.3.1_6::hp::(Checksum: 3:c9300850b58fde943bf9921e985827f0)
INSERT INTO `configproperty` (`appliedAfterRestarting`, `description`, `groupName`, `propertyName`, `propertyOrder`, `propertyType`, `propertyValue`) VALUES ('N', 'Enhanced security', 'birt.report', 'birt.report.enhancedSecurity.enabled', 10, 'BOOLEAN', 'false');

INSERT INTO `configproperty` (`appliedAfterRestarting`, `description`, `groupName`, `propertyName`, `propertyOrder`, `propertyType`, `propertyValue`) VALUES ('N', 'Username', 'birt.report', 'birt.report.username', 20, 'STRING', '');

INSERT INTO `configproperty` (`appliedAfterRestarting`, `description`, `groupName`, `propertyName`, `propertyOrder`, `propertyType`, `propertyValue`) VALUES ('N', 'Password', 'birt.report', 'birt.report.password', 30, 'ENCODEDHIDDEN', '');

INSERT INTO `configproperty` (`appliedAfterRestarting`, `description`, `groupName`, `propertyName`, `propertyOrder`, `propertyType`, `propertyValue`) VALUES ('N', 'Maximum heap size (MB)', 'birt.report', 'birt.report.maxHeapSize', 40, 'INTEGER', '3072');

INSERT INTO `configproperty` (`appliedAfterRestarting`, `description`, `groupName`, `propertyName`, `propertyOrder`, `propertyType`, `propertyValue`) VALUES ('N', 'Execution timeout (minutes)', 'birt.report', 'birt.report.timeout', 50, 'INTEGER', '1440');

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Insert Row (x5)', 'EXECUTED', 'dbF360_4.3.1.xml', 'f360_4.3.1_6', '2.0.1', '3:c9300850b58fde943bf9921e985827f0', 213);

-- Changeset dbF360_4.4.0.xml::f360_4.4.0_0::hp::(Checksum: 3:26f704eb1371164449d8337b7844020c)
-- Solves index creation issues for MySQL utf8_bin collation. MUST RUN BEFORE sourcefilemap CHANGES
ALTER TABLE `sourcefilemap` ROW_FORMAT=DYNAMIC;

ALTER TABLE `finding` ROW_FORMAT=DYNAMIC;

ALTER TABLE `scan_finding` ROW_FORMAT=DYNAMIC;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', 'Solves index creation issues for MySQL utf8_bin collation. MUST RUN BEFORE sourcefilemap CHANGES', NOW(), 'Custom SQL', 'EXECUTED', 'dbF360_4.4.0.xml', 'f360_4.4.0_0', '2.0.1', '3:26f704eb1371164449d8337b7844020c', 214);

-- Changeset dbF360_4.4.0.xml::f360_4.4.0_1::hp::(Checksum: 3:096741834f28f39962aca5f38d0c4a8d)
ALTER TABLE `sourcefilemap` ADD `fileName` VARCHAR(500);

CREATE INDEX `SourceFileMapScanIdFileNameInd` ON `sourcefilemap`(`scan_id`, `fileName`);

ALTER TABLE `sourcefilemap` DROP PRIMARY KEY;

ALTER TABLE `sourcefilemap` MODIFY `filePath` VARCHAR(3000);

DROP INDEX `SourceFileScanMatchPathInd` ON `sourcefilemap`;

ALTER TABLE `sourcefilemap` DROP COLUMN `matchingPath`;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Add Column, Create Index, Drop Primary Key, Modify data type, Drop Index, Drop Column', 'EXECUTED', 'dbF360_4.4.0.xml', 'f360_4.4.0_1', '2.0.1', '3:096741834f28f39962aca5f38d0c4a8d', 215);

-- Changeset dbF360Mysql_4.4.0_sourcefilemap_id.xml::f360Mysql_4.4.0_0::hp::(Checksum: 3:4a9f471e0c118dc90816ebf31f7b315d)
alter table sourcefilemap add id Int NOT NULL AUTO_INCREMENT primary key;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Custom SQL', 'EXECUTED', 'dbF360Mysql_4.4.0_sourcefilemap_id.xml', 'f360Mysql_4.4.0_0', '2.0.1', '3:4a9f471e0c118dc90816ebf31f7b315d', 216);

-- Changeset dbF360_4.4.0.xml::f360_4.4.0_2::hp::(Checksum: 3:5e33cfe130de985561696801071c0101)
ALTER TABLE `issue` MODIFY `fileName` VARCHAR(3000);

ALTER TABLE `scan_issue` MODIFY `fileName` VARCHAR(3000);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Modify data type (x2)', 'EXECUTED', 'dbF360_4.4.0.xml', 'f360_4.4.0_2', '2.0.1', '3:5e33cfe130de985561696801071c0101', 217);

-- Changeset dbF360_4.4.0.xml::f360_4.4.0_3::hp::(Checksum: 3:a088af138c91566eef049647f7b1ee35)
ALTER TABLE `finding` MODIFY `guid` VARCHAR(512);

ALTER TABLE `scan_finding` MODIFY `findingGuid` VARCHAR(512);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Modify data type (x2)', 'EXECUTED', 'dbF360_4.4.0.xml', 'f360_4.4.0_3', '2.0.1', '3:a088af138c91566eef049647f7b1ee35', 218);

-- Changeset dbF360_4.4.0.xml::f360_4.4.0_4::hp::(Checksum: 3:168e22230931b70eaccc52529c74f4d8)
-- Quartz upgrade from 2.1.x to 2.2.x
ALTER TABLE `QRTZ_FIRED_TRIGGERS` ADD `SCHED_TIME` BIGINT NOT NULL DEFAULT 0;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', 'Quartz upgrade from 2.1.x to 2.2.x', NOW(), 'Add Column', 'EXECUTED', 'dbF360_4.4.0.xml', 'f360_4.4.0_4', '2.0.1', '3:168e22230931b70eaccc52529c74f4d8', 219);

-- Changeset dbF360_4.4.0.xml::f360_4.4.0_5::hp::(Checksum: 3:1986fd77cfc53761f95058f83cd8d3d9)
-- Remove unused data tables
DROP TABLE `systemsettingmultichoicevalue`;

DROP TABLE `systemsettingmultichoiceoption`;

DROP TABLE `systemsettingfilevalue`;

DROP TABLE `systemsettingbooleanvalue`;

DROP TABLE `systemsettinglongstringvalue`;

DROP TABLE `systemsettingshortstringvalue`;

DROP TABLE `systemsettingvalue`;

DROP TABLE `systemsetting`;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', 'Remove unused data tables', NOW(), 'Drop Table (x8)', 'EXECUTED', 'dbF360_4.4.0.xml', 'f360_4.4.0_5', '2.0.1', '3:1986fd77cfc53761f95058f83cd8d3d9', 220);

-- Changeset dbF360_4.4.0.xml::f360_4.4.0_6::hp::(Checksum: 3:a2ad1a39ee3e989a12d541faef48bd13)
-- Increasing sie of the comment text column to let users post longer comments.
ALTER TABLE `auditcomment` MODIFY `commentText` VARCHAR(4000);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', 'Increasing sie of the comment text column to let users post longer comments.', NOW(), 'Modify data type', 'EXECUTED', 'dbF360_4.4.0.xml', 'f360_4.4.0_6', '2.0.1', '3:a2ad1a39ee3e989a12d541faef48bd13', 221);

-- Changeset dbF360_4.4.0.xml::f360_4.4.0_7::hp::(Checksum: 3:1762cf4141b50d739238267be7719989)
-- Add new column to save annotations counter of scan
ALTER TABLE `scan` ADD `fortifyAnnotationsLoc` INT;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', 'Add new column to save annotations counter of scan', NOW(), 'Add Column', 'EXECUTED', 'dbF360_4.4.0.xml', 'f360_4.4.0_7', '2.0.1', '3:1762cf4141b50d739238267be7719989', 222);

-- Changeset dbF360_4.4.0.xml::f360_4.4.0_8::hp::(Checksum: 3:9e2fda94e3f06551e379e9773ddf3e69)
-- Add new table for bugtracker templates
CREATE TABLE `bugtrackertemplate` (`bugtracker` VARCHAR(127) NOT NULL, `template_field_id` VARCHAR(250) NOT NULL, `template_value` VARCHAR(4000));

ALTER TABLE `bugtrackertemplate` ADD PRIMARY KEY (`bugtracker`, `template_field_id`);

INSERT INTO `bugtrackertemplate` (`bugtracker`, `template_field_id`, `template_value`) VALUES ('default', 'summary', 'Fix $ATTRIBUTE_CATEGORY in $ATTRIBUTE_FILE');

INSERT INTO `bugtrackertemplate` (`bugtracker`, `template_field_id`, `template_value`) VALUES ('default', 'description', '#foreach( $is in $issues ) Issue Ids: $is.get("ATTRIBUTE_INSTANCE_ID") | $is.get("ISSUE_DEEPLINK") | $is.get("ATTRIBUTE_FILE")             #end');

INSERT INTO `bugtrackertemplate` (`bugtracker`, `template_field_id`, `template_value`) VALUES ('jira', 'summary', 'Fix $ATTRIBUTE_CATEGORY in $ATTRIBUTE_FILE');

INSERT INTO `bugtrackertemplate` (`bugtracker`, `template_field_id`, `template_value`) VALUES ('jira', 'description', 'Issue Ids: $ATTRIBUTE_INSTANCE_ID $ISSUE_DEEPLINK');

INSERT INTO `bugtrackertemplate` (`bugtracker`, `template_field_id`, `template_value`) VALUES ('hp alm', 'summary', 'Fix $ATTRIBUTE_CATEGORY in $ATTRIBUTE_FILE');

INSERT INTO `bugtrackertemplate` (`bugtracker`, `template_field_id`, `template_value`) VALUES ('hp alm', 'description', 'Issue Ids: $ATTRIBUTE_INSTANCE_ID $ISSUE_DEEPLINK');

INSERT INTO `bugtrackertemplate` (`bugtracker`, `template_field_id`, `template_value`) VALUES ('bugzilla', 'summary', 'Fix $ATTRIBUTE_CATEGORY in $ATTRIBUTE_FILE');

INSERT INTO `bugtrackertemplate` (`bugtracker`, `template_field_id`, `template_value`) VALUES ('bugzilla', 'description', 'Issue Ids: $ATTRIBUTE_INSTANCE_ID $ISSUE_DEEPLINK');

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', 'Add new table for bugtracker templates', NOW(), 'Create Table, Add Primary Key, Insert Row (x8)', 'EXECUTED', 'dbF360_4.4.0.xml', 'f360_4.4.0_8', '2.0.1', '3:9e2fda94e3f06551e379e9773ddf3e69', 223);

-- Changeset dbF360_4.4.0.xml::f360_4.4.0_9::hp::(Checksum: 3:1d2ab10b208eba64a7611b651f7ad1ac)
-- Adds a new column with fulltext indexing status
ALTER TABLE `artifact` ADD `indexed` TINYINT(1) NOT NULL DEFAULT 0;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', 'Adds a new column with fulltext indexing status', NOW(), 'Add Column', 'EXECUTED', 'dbF360_4.4.0.xml', 'f360_4.4.0_9', '2.0.1', '3:1d2ab10b208eba64a7611b651f7ad1ac', 224);

-- Changeset dbF360_4.4.0.xml::f360_4.4.0_10::hp::(Checksum: 3:3b88c7901a5d5fdb65b566b2b92e71ef)
-- New index to improve searching number of issues assigned to specific user(s) across all project versions.
CREATE INDEX `USER_SUPPRESSED_SCANSTAT_IDX` ON `issue`(`userName`, `suppressed`, `scanStatus`, `projectVersion_id`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', 'New index to improve searching number of issues assigned to specific user(s) across all project versions.', NOW(), 'Create Index', 'EXECUTED', 'dbF360_4.4.0.xml', 'f360_4.4.0_10', '2.0.1', '3:3b88c7901a5d5fdb65b566b2b92e71ef', 225);

-- Changeset dbF360_4.4.0.xml::f360_4.4.0_11::hp::(Checksum: 3:6147adc004e9f556336732f950407ac6)
-- Enlarge rulepack.locale column so it can hold xx_XX locale names.
ALTER TABLE `rulepack` MODIFY `locale` VARCHAR(5);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', 'Enlarge rulepack.locale column so it can hold xx_XX locale names.', NOW(), 'Modify data type', 'EXECUTED', 'dbF360_4.4.0.xml', 'f360_4.4.0_11', '2.0.1', '3:6147adc004e9f556336732f950407ac6', 226);

-- Changeset dbF360_4.4.0.xml::f360_4.4.0_12::hp::(Checksum: 3:6f8737c6a504c499603895a5fe92c972)
-- Index maintenance job scheduler configuration
INSERT INTO `configproperty` (`description`, `groupName`, `propertyName`, `propertyValue`) VALUES ('A comma-separated list of the daysOfWeek for the index maintenance job to run. * means run every day. 1 means Sunday, 2 means Monday, etc.', 'scheduler', 'index.maintenance.daysOfWeek', '*');

INSERT INTO `configproperty` (`description`, `groupName`, `propertyName`, `propertyValue`) VALUES ('A comma-separated list of the hours of the day for the index maintenance job to run. * means run every hour.', 'scheduler', 'index.maintenance.hours', '0');

INSERT INTO `configproperty` (`description`, `groupName`, `propertyName`, `propertyValue`) VALUES ('A comma-separated list of the minutes of each hour for the index maintenance job to run. Do not run more than once every 5 minutes.', 'scheduler', 'index.maintenance.minutes', '0');

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', 'Index maintenance job scheduler configuration', NOW(), 'Insert Row (x3)', 'EXECUTED', 'dbF360_4.4.0.xml', 'f360_4.4.0_12', '2.0.1', '3:6f8737c6a504c499603895a5fe92c972', 227);

-- Changeset dbF360_4.4.0.xml::f360_4.4.0_13::hp::(Checksum: 3:4de27e814af629c5b98653ea07e89ef3)
-- SSL/TLS email configuration properties
INSERT INTO `configproperty` (`description`, `groupName`, `propertyName`, `propertyType`, `propertyValue`) VALUES ('Enable SSL/TLS Encryption', 'email', 'email.server.ssl.enabled', 'BOOLEAN', 'false');

INSERT INTO `configproperty` (`description`, `groupName`, `propertyName`, `propertyType`, `propertyValue`) VALUES ('Trust the certificate provided by the SMTP server', 'email', 'email.server.ssl.trustHostCertificate', 'BOOLEAN', 'false');

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', 'SSL/TLS email configuration properties', NOW(), 'Insert Row (x2)', 'EXECUTED', 'dbF360_4.4.0.xml', 'f360_4.4.0_13', '2.0.1', '3:4de27e814af629c5b98653ea07e89ef3', 228);

-- Changeset dbF360_4.4.0.xml::f360_4.4.0_14::hp::(Checksum: 3:92383b1821b788d95e7dd69273547a3d)
-- SAML 2.0 integration properties
INSERT INTO `configproperty` (`description`, `groupName`, `groupSwitch`, `propertyName`, `propertyType`, `propertyValue`) VALUES ('SAML 2.0 Integration', 'saml', 'Y', 'saml.enabled', 'BOOLEAN', 'false');

INSERT INTO `configproperty` (`description`, `groupName`, `propertyName`, `propertyOrder`, `propertyType`, `propertyValue`) VALUES ('Identity provider metadata location', 'saml', 'saml.idp.metadata', 10, 'STRING', 'http://');

INSERT INTO `configproperty` (`description`, `groupName`, `propertyName`, `propertyOrder`, `propertyType`, `propertyValue`) VALUES ('Default identity provider', 'saml', 'saml.idp.default', 20, 'STRING', 'http://');

INSERT INTO `configproperty` (`description`, `groupName`, `propertyName`, `propertyOrder`, `propertyType`, `propertyValue`) VALUES ('Service provider entity ID, must be globally unique across federations', 'saml', 'saml.sp.entityId', 30, 'STRING', 'urn:ssc:saml');

INSERT INTO `configproperty` (`description`, `groupName`, `propertyName`, `propertyOrder`, `propertyType`, `propertyValue`) VALUES ('Service provider alias', 'saml', 'saml.sp.alias', 40, 'STRING', 'urn:ssc:saml');

INSERT INTO `configproperty` (`description`, `groupName`, `propertyName`, `propertyOrder`, `propertyType`, `propertyValue`) VALUES ('Keystore location', 'saml', 'saml.keystore.location', 50, 'STRING', 'file:///');

INSERT INTO `configproperty` (`description`, `groupName`, `propertyName`, `propertyOrder`, `propertyType`, `propertyValue`) VALUES ('Keystore password', 'saml', 'saml.keystore.password', 60, 'ENCODEDHIDDEN', '');

INSERT INTO `configproperty` (`description`, `groupName`, `propertyName`, `propertyOrder`, `propertyType`, `propertyValue`) VALUES ('Key for signing and encryption of SAML messages', 'saml', 'saml.key.alias', 70, 'STRING', '');

INSERT INTO `configproperty` (`description`, `groupName`, `propertyName`, `propertyOrder`, `propertyType`, `propertyValue`) VALUES ('Key password', 'saml', 'saml.key.password', 80, 'ENCODEDHIDDEN', '');

INSERT INTO `configproperty` (`description`, `groupName`, `propertyName`, `propertyOrder`, `propertyType`, `propertyValue`) VALUES ('Assertion attribute which holds username, NameID by default', 'saml', 'saml.assertion.username', 90, 'STRING', 'NameID');

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', 'SAML 2.0 integration properties', NOW(), 'Insert Row (x10)', 'EXECUTED', 'dbF360_4.4.0.xml', 'f360_4.4.0_14', '2.0.1', '3:92383b1821b788d95e7dd69273547a3d', 229);

-- Changeset dbF360_4.4.0.xml::f360_4.4.0_15::hp::(Checksum: 3:35af8d705f105ea8c69d6a2bb4d51776)
-- Adding support for configuration sub groups
ALTER TABLE `configproperty` ADD `subGroupName` VARCHAR(100);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', 'Adding support for configuration sub groups', NOW(), 'Add Column', 'EXECUTED', 'dbF360_4.4.0.xml', 'f360_4.4.0_15', '2.0.1', '3:35af8d705f105ea8c69d6a2bb4d51776', 230);

-- Changeset dbF360_4.4.0.xml::f360_4.4.0_16::hp::(Checksum: 3:a43e5799c0cac397d8929fd3f2a542f4)
UPDATE `configproperty` SET `propertyType` = 'ENCODEDHIDDEN' WHERE propertyName = 'birt.report.username';

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Update Data', 'EXECUTED', 'dbF360_4.4.0.xml', 'f360_4.4.0_16', '2.0.1', '3:a43e5799c0cac397d8929fd3f2a542f4', 231);

-- Changeset dbF360Mysql_4.4.0.xml::f360Mysql_4.4.0_1::hp::(Checksum: 3:6ee32317123ae7b57ebf616e58002db3)
ALTER TABLE `QRTZ_JOB_DETAILS` MODIFY COLUMN `JOB_DATA` MEDIUMBLOB;

ALTER TABLE `QRTZ_TRIGGERS` MODIFY COLUMN `JOB_DATA` MEDIUMBLOB;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Custom SQL', 'EXECUTED', 'dbF360Mysql_4.4.0.xml', 'f360Mysql_4.4.0_1', '2.0.1', '3:6ee32317123ae7b57ebf616e58002db3', 232);

-- Changeset dbF360_4.4.1.xml::f360_4.4.1_0::hp::(Checksum: 3:d48449105d74137f7f65a87d26fa1c5e)
DELETE FROM `QRTZ_CRON_TRIGGERS`;

DELETE FROM `QRTZ_FIRED_TRIGGERS`;

DELETE FROM `QRTZ_SIMPLE_TRIGGERS`;

DELETE FROM `QRTZ_TRIGGERS`;

DELETE FROM `QRTZ_JOB_DETAILS`;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Delete Data (x5)', 'EXECUTED', 'dbF360_4.4.1.xml', 'f360_4.4.1_0', '2.0.1', '3:d48449105d74137f7f65a87d26fa1c5e', 233);

-- Changeset dbF360_4.4.1.xml::f360_4.4.1_1::hp::(Checksum: 3:50f723592bc8c252e8a84c2daf3b80f3)
-- Add index on sourcefilemap.checksum
CREATE INDEX `SOURCEFILEMAP_CHECKSUM_IDX` ON `sourcefilemap`(`checksum`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', 'Add index on sourcefilemap.checksum', NOW(), 'Create Index', 'EXECUTED', 'dbF360_4.4.1.xml', 'f360_4.4.1_1', '2.0.1', '3:50f723592bc8c252e8a84c2daf3b80f3', 234);

-- Changeset dbF360_4.5.0.xml::f360_4.5.0_0::hp::(Checksum: 3:d1ed601e2989a15148b73cbe98aaf69a)
-- Solve slow SQL for issue search
DROP INDEX `idx_id_table_session_date_id` ON `id_table`;

DROP TABLE `id_table`;

CREATE TABLE `id_table` (`id_num` INT NOT NULL, `session_date` BIGINT NOT NULL, `session_id` INT NOT NULL, `id` INT NOT NULL);

CREATE INDEX `pk_id_table` ON `id_table`(`session_date`, `session_id`, `id_num`, `id`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', 'Solve slow SQL for issue search', NOW(), 'Drop Index, Drop Table, Create Table, Create Index', 'EXECUTED', 'dbF360_4.5.0.xml', 'f360_4.5.0_0', '2.0.1', '3:d1ed601e2989a15148b73cbe98aaf69a', 235);

-- Changeset dbF360_4.5.0.xml::f360_4.5.0_1::hp::(Checksum: 3:25145c5a61b07e053aa7e62811e7941e)
-- Adding support of required flag for properties
ALTER TABLE `configproperty` ADD `required` VARCHAR(1);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', 'Adding support of required flag for properties', NOW(), 'Add Column', 'EXECUTED', 'dbF360_4.5.0.xml', 'f360_4.5.0_1', '2.0.1', '3:25145c5a61b07e053aa7e62811e7941e', 236);

-- Changeset dbF360_4.5.0.xml::f360_4.5.0_2::hp::(Checksum: 3:9bda384f045d659c8583a41e11ebcb9f)
-- Adding support of protected option flag for properties
ALTER TABLE `configproperty` ADD `protectedOption` VARCHAR(1) DEFAULT 'Y';

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', 'Adding support of protected option flag for properties', NOW(), 'Add Column', 'EXECUTED', 'dbF360_4.5.0.xml', 'f360_4.5.0_2', '2.0.1', '3:9bda384f045d659c8583a41e11ebcb9f', 237);

-- Changeset dbF360_4.5.0.xml::f360_4.5.0_3::hp::(Checksum: 3:dc3d5d8f765ec1749be53ad22cd641ad)
-- LDAP configuration in DB.
CREATE TABLE `ldapserver` (`id` INT AUTO_INCREMENT  NOT NULL, `objectVersion` INT DEFAULT 1 NOT NULL, `updateTime` DATETIME NOT NULL, `serverName` VARCHAR(200) NOT NULL, `defaultServer` VARCHAR(1) NOT NULL, `enabled` VARCHAR(1) NOT NULL, `baseDn` VARCHAR(255) NOT NULL, `searchDns` VARCHAR(1000), `url` VARCHAR(250) NOT NULL, `userDn` VARCHAR(600) NOT NULL, `userPassword` VARCHAR(600) NOT NULL, `cacheEnabled` VARCHAR(1) NOT NULL, `cacheExecutorPoolSize` INT NOT NULL, `cacheMaxThreadsPerCache` INT NOT NULL, `cacheExecutorPoolSizeMax` INT NOT NULL, `cacheEvictionTime` INT NOT NULL, `pagingEnabled` VARCHAR(1) NOT NULL, `pageSize` INT NOT NULL, `userPhotoEnabled` VARCHAR(1) NOT NULL, `nestedGroupsEnabled` VARCHAR(1) NOT NULL, `ignorePartialResultException` VARCHAR(1) NOT NULL, `validationIdleTime` INT NOT NULL, `validationTimeLimit` INT NOT NULL, `attributeGroupname` VARCHAR(150) NOT NULL, `attributeFirstName` VARCHAR(150) NOT NULL, `attributeLastName` VARCHAR(150) NOT NULL, `attributeOrgunitName` VARCHAR(150) NOT NULL, `attributeMember` VARCHAR(150) NOT NULL, `attributeMemberOf` VARCHAR(150) NOT NULL, `attributeObjectSid` VARCHAR(150), `attributeEmail` VARCHAR(150) NOT NULL, `attributeDistinguishedName` VARCHAR(150) NOT NULL, `attributeObjectClass` VARCHAR(150) NOT NULL, `attributeUserName` VARCHAR(150) NOT NULL, `attributePassword` VARCHAR(150), `attributeThumbnailPhoto` VARCHAR(150), `attributeThumbnailMimeDefault` VARCHAR(50), `authenticatorType` VARCHAR(50) NOT NULL, `passwordEncoderType` VARCHAR(50) NOT NULL, `baseObjectSid` VARCHAR(150), `classUser` VARCHAR(150) NOT NULL, `classGroup` VARCHAR(150) NOT NULL, `classOrgunit` VARCHAR(150) NOT NULL, `referralsProcessingStrategy` VARCHAR(50) NOT NULL, CONSTRAINT `ldapServerPk` PRIMARY KEY (`id`));

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', 'LDAP configuration in DB.', NOW(), 'Create Table', 'EXECUTED', 'dbF360_4.5.0.xml', 'f360_4.5.0_3', '2.0.1', '3:dc3d5d8f765ec1749be53ad22cd641ad', 238);

-- Changeset dbF360_4.5.0.xml::f360_4.5.0_3.1::hp::(Checksum: 3:48e7bd429fd33f04656aab022e80e38b)
-- Solves index creation issues for MySQL utf8_bin collation. MUST RUN BEFORE creating indexes for ldapserver table.
ALTER TABLE `ldapserver` ROW_FORMAT=DYNAMIC;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', 'Solves index creation issues for MySQL utf8_bin collation. MUST RUN BEFORE creating indexes for ldapserver table.', NOW(), 'Custom SQL', 'EXECUTED', 'dbF360_4.5.0.xml', 'f360_4.5.0_3.1', '2.0.1', '3:48e7bd429fd33f04656aab022e80e38b', 239);

-- Changeset dbF360_4.5.0.xml::f360_4.5.0_3.2::hp::(Checksum: 3:d133fbbf08f2674320860dd56e43fa17)
CREATE UNIQUE INDEX `LDAP_SERVER_BASE_DN_IDX` ON `ldapserver`(`baseDn`);

CREATE UNIQUE INDEX `LDAP_SERVER_NAME_IDX` ON `ldapserver`(`serverName`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Create Index (x2)', 'EXECUTED', 'dbF360_4.5.0.xml', 'f360_4.5.0_3.2', '2.0.1', '3:d133fbbf08f2674320860dd56e43fa17', 240);

-- Changeset dbF360_4.5.0.xml::f360_4.5.0_4::hp::(Checksum: 3:e342a5d340b0c14b8d18f0977271a070)
-- Adding table for user UI preferences
CREATE TABLE `usersessionstate` (`id` INT AUTO_INCREMENT  NOT NULL, `userName` VARCHAR(255) NOT NULL, `name` VARCHAR(255), `value` VARCHAR(1024), `category` VARCHAR(100), `projectVersionId` INT, CONSTRAINT `userSessionStatePK` PRIMARY KEY (`id`));

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', 'Adding table for user UI preferences', NOW(), 'Create Table', 'EXECUTED', 'dbF360_4.5.0.xml', 'f360_4.5.0_4', '2.0.1', '3:e342a5d340b0c14b8d18f0977271a070', 241);

-- Changeset dbF360_4.5.0.xml::f360_4.5.0_5::hp::(Checksum: 3:a1f34222765d23b36712ead390af8daf)
-- scan_issue link is no longer used. scanissueview redefined to remove dependency
DROP VIEW `scanissueview`;

CREATE VIEW `scanissueview` AS SELECT si.scan_id, si.id, si.issue_id, si.issueInstanceId, s.startDate, s.engineType, s.projectVersion_id
            FROM scan s INNER JOIN scan_issue si ON si.scan_id = s.id;

DROP TABLE `scan_issue_link`;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', 'scan_issue link is no longer used. scanissueview redefined to remove dependency', NOW(), 'Drop View, Create View, Drop Table', 'EXECUTED', 'dbF360_4.5.0.xml', 'f360_4.5.0_5', '2.0.1', '3:a1f34222765d23b36712ead390af8daf', 242);

-- Changeset dbF360_4.5.0.xml::f360_4.5.0_6::hp::(Checksum: 3:099a802813e88df739943a91696b604f)
CREATE TABLE `cloudworker` (`id` BIGINT AUTO_INCREMENT  NOT NULL, `uuid` VARCHAR(36) NOT NULL, `processUuid` VARCHAR(36) NOT NULL, `state` VARCHAR(25) NOT NULL, `lastChangedOn` BIGINT NOT NULL, `workerStartTime` DATETIME, `workerExpiryTime` DATETIME, `lastSeen` DATETIME, `lastActivity` VARCHAR(100), `ipAddress` VARCHAR(45), `scaVersion` VARCHAR(128), `vmName` VARCHAR(255), `availableProcessors` INT, `totalPhysicalMemory` BIGINT, `osName` VARCHAR(255), `osVersion` VARCHAR(255), `osArchitecture` VARCHAR(255), CONSTRAINT `PK_CLOUDWORKER` PRIMARY KEY (`id`));

CREATE INDEX `WORKER_LASTCHANGEDON_IDX` ON `cloudworker`(`lastChangedOn`);

CREATE UNIQUE INDEX `UQ_WORKER_UUID_IDX` ON `cloudworker`(`uuid`);

CREATE UNIQUE INDEX `UQ_WORKER_PROC_UUID_IDX` ON `cloudworker`(`processUuid`);

CREATE INDEX `WORKER_EXPIRYTIME_IDX` ON `cloudworker`(`workerExpiryTime`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Create Table, Create Index (x4)', 'EXECUTED', 'dbF360_4.5.0.xml', 'f360_4.5.0_6', '2.0.1', '3:099a802813e88df739943a91696b604f', 243);

-- Changeset dbF360_4.5.0.xml::f360_4.5.0_7::hp::(Checksum: 3:65ade22c3b7b2a74028497a8c8b7ac5d)
CREATE TABLE `cloudjob` (`id` BIGINT AUTO_INCREMENT  NOT NULL, `jobToken` VARCHAR(36) NOT NULL, `lastChangedOn` BIGINT NOT NULL, `scaBuildId` VARCHAR(100), `scaVersion` VARCHAR(128), `scaArgs` VARCHAR(4000), `workerUuid` VARCHAR(36), `workerProcessUuid` VARCHAR(36), `submitterUserName` VARCHAR(255), `submitterIpAddress` VARCHAR(45), `submitterEmail` VARCHAR(255), `jobState` VARCHAR(25) NOT NULL, `jobQueuedTime` DATETIME, `jobStartedTime` DATETIME, `jobFinishedTime` DATETIME, `jobExpiryTime` DATETIME, `jobHasLog` CHAR(1), `jobHasFpr` CHAR(1), `cloudWorker_id` BIGINT, `projectVersion_id` BIGINT, CONSTRAINT `PK_CLOUDJOB` PRIMARY KEY (`id`));

CREATE UNIQUE INDEX `UQ_CLOUDJOB_JOBTOKEN_IDX` ON `cloudjob`(`jobToken`);

CREATE INDEX `CLOUDJOB_JOBSTATE_IDX` ON `cloudjob`(`jobState`);

CREATE UNIQUE INDEX `UQ_CLOUDJOB_LASTCHANGEDON_IDX` ON `cloudjob`(`lastChangedOn`);

CREATE INDEX `CLOUDJOB_EXPIRYTIME_IDX` ON `cloudjob`(`jobExpiryTime`);

CREATE INDEX `FK_CLOUDJOB_WORKER_IDX` ON `cloudjob`(`cloudWorker_id`);

ALTER TABLE `cloudjob` ADD CONSTRAINT `RefCloudWorker` FOREIGN KEY (`cloudWorker_id`) REFERENCES `cloudworker` (`id`) ON DELETE SET NULL;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Create Table, Create Index (x5), Add Foreign Key Constraint', 'EXECUTED', 'dbF360_4.5.0.xml', 'f360_4.5.0_7', '2.0.1', '3:65ade22c3b7b2a74028497a8c8b7ac5d', 244);

-- Changeset dbF360_4.5.0.xml::f360_4.5.0_8::hp::(Checksum: 3:a6150f0861fbe89715d544d360902968)
-- Removal of BugStateManagement jobs from the job queue
DELETE FROM `jobqueue`  WHERE jobClassName = 'com.fortify.manager.BLL.jobs.BugStateManagementJob';

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', 'Removal of BugStateManagement jobs from the job queue', NOW(), 'Delete Data', 'EXECUTED', 'dbF360_4.5.0.xml', 'f360_4.5.0_8', '2.0.1', '3:a6150f0861fbe89715d544d360902968', 245);

-- Changeset dbF360_4.5.0.xml::f360_4.5.0_9::hp::(Checksum: 3:2fc54616af2db1b385946f44f2599b6e)
ALTER TABLE `jobqueue` ADD `priority` INT NOT NULL DEFAULT 0;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Add Column', 'EXECUTED', 'dbF360_4.5.0.xml', 'f360_4.5.0_9', '2.0.1', '3:2fc54616af2db1b385946f44f2599b6e', 246);

-- Changeset dbF360_4.5.0.xml::f360_4.5.0_11::hp::(Checksum: 3:3dc436ad97ac6df65c09791ec90ad116)
-- Kerberos integration properties
INSERT INTO `configproperty` (`description`, `groupName`, `groupSwitch`, `propertyName`, `propertyType`, `propertyValue`, `required`) VALUES ('SPNEGO/Kerberos Integration', 'kerberos', 'Y', 'kerberos.enabled', 'BOOLEAN', 'false', 'N');

INSERT INTO `configproperty` (`description`, `groupName`, `propertyName`, `propertyOrder`, `propertyType`, `propertyValue`, `required`) VALUES ('Service principal name (SPN)', 'kerberos', 'kerberos.service.principal', 10, 'STRING', '', 'Y');

INSERT INTO `configproperty` (`description`, `groupName`, `propertyName`, `propertyOrder`, `propertyType`, `propertyValue`, `required`) VALUES ('Keytab location with service principal keys.', 'kerberos', 'kerberos.keytab.location', 20, 'STRING', 'file:///', 'Y');

INSERT INTO `configproperty` (`description`, `groupName`, `propertyName`, `propertyOrder`, `propertyType`, `propertyValue`, `required`) VALUES ('Optional krb5.conf file location. Sets the ''java.security.krb5.conf'' property.', 'kerberos', 'kerberos.krb5conf.location', 30, 'STRING', '', 'N');

INSERT INTO `configproperty` (`description`, `groupName`, `propertyName`, `propertyOrder`, `propertyType`, `propertyValue`, `required`) VALUES ('Enable debug mode of Kerberos integration', 'kerberos', 'kerberos.debug', 40, 'BOOLEAN', 'false', 'N');

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', 'Kerberos integration properties', NOW(), 'Insert Row (x5)', 'EXECUTED', 'dbF360_4.5.0.xml', 'f360_4.5.0_11', '2.0.1', '3:3dc436ad97ac6df65c09791ec90ad116', 247);

-- Changeset dbF360_4.5.0.xml::f360_4.5.0_12::hp::(Checksum: 3:e5d9656a21447a409d31c59273669e58)
-- X509 integration properties
INSERT INTO `configproperty` (`description`, `groupName`, `groupSwitch`, `propertyName`, `propertyOrder`, `propertyType`, `propertyValue`, `required`) VALUES ('X.509 certificate username pattern', 'x509', 'N', 'x509.username.pattern', 10, 'STRING', 'CN=(.*?)(?:,|$)', 'Y');

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', 'X509 integration properties', NOW(), 'Insert Row', 'EXECUTED', 'dbF360_4.5.0.xml', 'f360_4.5.0_12', '2.0.1', '3:e5d9656a21447a409d31c59273669e58', 248);

-- Changeset dbF360_4.5.0.xml::f360_4.5.0_13::hp::(Checksum: 3:437917e829a0eba50d01782087ed901b)
-- Added hashValue column to store hash of ldap.properties to determine if file has been modified
ALTER TABLE `ldapserver` ADD `hashValue` INT;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', 'Added hashValue column to store hash of ldap.properties to determine if file has been modified', NOW(), 'Add Column', 'EXECUTED', 'dbF360_4.5.0.xml', 'f360_4.5.0_13', '2.0.1', '3:437917e829a0eba50d01782087ed901b', 249);

-- Changeset dbF360_4.5.0.xml::f360_4.5.0_14::hp::(Checksum: 3:eebeefca4c2c22cad0d6b9c3eb3ea603)
-- Change index jobqueue(executionOrder) from unique to non-unique
ALTER TABLE `jobqueue` DROP KEY `UQ_EXECUTIONORDER`;

CREATE INDEX `EXECUTIONORDER_IDX` ON `jobqueue`(`executionOrder`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', 'Change index jobqueue(executionOrder) from unique to non-unique', NOW(), 'Drop Unique Constraint, Create Index', 'EXECUTED', 'dbF360_4.5.0.xml', 'f360_4.5.0_14', '2.0.1', '3:eebeefca4c2c22cad0d6b9c3eb3ea603', 250);

-- Changeset dbF360_4.5.0.xml::f360_4.5.0_15::hp::(Checksum: 3:a55cfe676cb302f66b3ff6a6e32843f8)
-- Add index jobqueue(state ASC, priority DESC, executionOrder DESC)
CREATE INDEX `STATE_PRIO_EXECORDER_IDX` ON `jobqueue`(`state` ASC, `priority` DESC, `executionOrder` ASC);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', 'Add index jobqueue(state ASC, priority DESC, executionOrder DESC)', NOW(), 'Create Index', 'EXECUTED', 'dbF360_4.5.0.xml', 'f360_4.5.0_15', '2.0.1', '3:a55cfe676cb302f66b3ff6a6e32843f8', 251);

-- Changeset dbF360_4.5.0.xml::f360_4.5.0_16::hp_main::(Checksum: 3:39553133ebe844b4a53ef13899cc78f4)
INSERT INTO `configproperty` (`description`, `groupName`, `propertyName`, `propertyOrder`, `propertyType`, `propertyValue`, `required`, `valuesList`) VALUES ('User lookup strategy when LDAP is enabled', 'core', 'user.lookup.strategy', 45, 'OPTIONLIST', '3', 'Y', 'Local users first, fallback to LDAP users (compatibility)|||||1-----LDAP users first, fallback to local users|||||2-----LDAP users exclusive, fallback to local administrator|||||3');

UPDATE configproperty SET propertyValue='1'
			WHERE groupName='core' AND propertyName='user.lookup.strategy'
			AND 0 < (
				SELECT count(userName) FROM fortifyuser fu
				INNER JOIN user_pt ON (fu.id=user_pt.user_id)
				INNER JOIN permissiontemplate pt ON (pt.id=user_pt.pt_id and pt.guid<>'admin')
			)
			AND 0 = (SELECT A.cnt FROM (
				SELECT count(cp.propertyValue) cnt FROM configproperty cp
				WHERE cp.propertyName IN ('saml.enabled', 'sso.enabled', 'kerberos.enabled', 'cas.enabled')
				AND cp.propertyValue='true'
			) A);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Insert Row, Custom SQL', 'EXECUTED', 'dbF360_4.5.0.xml', 'f360_4.5.0_16', '2.0.1', '3:39553133ebe844b4a53ef13899cc78f4', 252);

-- Changeset dbF360_4.5.0.xml::f360_4.5.0_17::hp_main::(Checksum: 3:991c43f6e4e00a772a335b532718619a)
-- Set WAITING_FOR_WORKER jobs as PREPARED
UPDATE `jobqueue` SET `state` = 0 WHERE state = 3;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', 'Set WAITING_FOR_WORKER jobs as PREPARED', NOW(), 'Update Data', 'EXECUTED', 'dbF360_4.5.0.xml', 'f360_4.5.0_17', '2.0.1', '3:991c43f6e4e00a772a335b532718619a', 253);

-- Changeset dbF360_4.5.0.xml::f360_4.5.0_18::hp::(Checksum: 3:d48449105d74137f7f65a87d26fa1c5e)
-- Truncate QRTZ tables
DELETE FROM `QRTZ_CRON_TRIGGERS`;

DELETE FROM `QRTZ_FIRED_TRIGGERS`;

DELETE FROM `QRTZ_SIMPLE_TRIGGERS`;

DELETE FROM `QRTZ_TRIGGERS`;

DELETE FROM `QRTZ_JOB_DETAILS`;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', 'Truncate QRTZ tables', NOW(), 'Delete Data (x5)', 'EXECUTED', 'dbF360_4.5.0.xml', 'f360_4.5.0_18', '2.0.1', '3:d48449105d74137f7f65a87d26fa1c5e', 254);

-- Changeset dbF360_4.5.0.xml::f360_4.5.0_19::hp::(Checksum: 3:f9f845641adb6f5acdecb39a81a1019d)
-- Remove FK constraint RefIssueAuditAttach from auditattachment table
ALTER TABLE `auditattachment` DROP FOREIGN KEY `RefIssueAuditAttach`;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', 'Remove FK constraint RefIssueAuditAttach from auditattachment table', NOW(), 'Drop Foreign Key Constraint', 'EXECUTED', 'dbF360_4.5.0.xml', 'f360_4.5.0_19', '2.0.1', '3:f9f845641adb6f5acdecb39a81a1019d', 255);

-- Changeset dbF360_4.5.0.xml::f360_4.5.0_20::hp::(Checksum: 3:363691553f62cdeb7ddc174a938e215f)
UPDATE `configproperty` SET `description` = 'HPE Security Fortify Software security Center Location' WHERE groupName='cas' AND propertyName='cas.f360.server.location';

UPDATE `configproperty` SET `description` = 'Enable SSO Integration. WARNING: Single-Sign-On should only be enabled for a locked-down HPE Security Fortify Software Security Center instance, with Apache Agent capable of SSO authentication in front. The SSO-enabled Apache Agent should pass trusted HTTP headers to SSC. For more information, please refer to HPE Security Fortify Software Security Center Deployment Guide' WHERE groupName='sso' AND propertyName='sso.enabled';

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Update Data (x2)', 'EXECUTED', 'dbF360_4.5.0.xml', 'f360_4.5.0_20', '2.0.1', '3:363691553f62cdeb7ddc174a938e215f', 256);

-- Changeset dbF360_4.5.0.xml::f360_4.5.0_21::hp::(Checksum: 3:cd632556c4e786ea01c51babdb72e120)
ALTER TABLE `alerthistory` ADD `triggeredValue` VARCHAR(255);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Add Column', 'EXECUTED', 'dbF360_4.5.0.xml', 'f360_4.5.0_21', '2.0.1', '3:cd632556c4e786ea01c51babdb72e120', 257);

-- Changeset dbF360_4.5.0.xml::f360_4.5.0_22::hp::(Checksum: 3:9e69ba523b7698f1069ada51143a5f79)
-- Add FK constraint RefRTProjTempl on projectTemplate_id
ALTER TABLE `requirementtemplate` ADD CONSTRAINT `RefRTProjTempl` FOREIGN KEY (`projectTemplate_id`) REFERENCES `projecttemplate` (`id`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', 'Add FK constraint RefRTProjTempl on projectTemplate_id', NOW(), 'Add Foreign Key Constraint', 'EXECUTED', 'dbF360_4.5.0.xml', 'f360_4.5.0_22', '2.0.1', '3:9e69ba523b7698f1069ada51143a5f79', 258);

-- Changeset dbF360_16.20_audithistory.xml::f360_16.20_audithistory_1::hp::(Checksum: 3:74f56119cb5ab06d93622b46003ab93a)
-- Audit history values conversion
DROP VIEW `audithistoryview`;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', 'Audit history values conversion', NOW(), 'Drop View', 'EXECUTED', 'dbF360_16.20_audithistory.xml', 'f360_16.20_audithistory_1', '2.0.1', '3:74f56119cb5ab06d93622b46003ab93a', 259);

-- Changeset dbF360_16.20_audithistory.xml::f360_16.20_audithistory_2::hp::(Checksum: 3:29f25e05ba2b7fd3a72aaa879875f9e3)
ALTER TABLE `audithistory` RENAME `audithistory_old`;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Rename Table', 'EXECUTED', 'dbF360_16.20_audithistory.xml', 'f360_16.20_audithistory_2', '2.0.1', '3:29f25e05ba2b7fd3a72aaa879875f9e3', 260);

-- Changeset dbF360_16.20_audithistory.xml::f360_16.20_audithistory_4::hp::(Checksum: 3:ef4b6422322d15ab4d50d507156c8e7d)
CREATE TABLE `audithistory` (`issue_id` BIGINT NOT NULL, `attrGuid` VARCHAR(255), `seqNumber` BIGINT NOT NULL, `projectVersion_id` BIGINT, `auditTime` BIGINT, `oldValue` VARCHAR(500), `newValue` VARCHAR(500), `userName` VARCHAR(255), `conflict` CHAR(1), CONSTRAINT `PK_AUDITHISTORY` PRIMARY KEY (`issue_id`, `seqNumber`));

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Create Table', 'EXECUTED', 'dbF360_16.20_audithistory.xml', 'f360_16.20_audithistory_4', '2.0.1', '3:ef4b6422322d15ab4d50d507156c8e7d', 261);

-- Changeset dbF360Mysql_16.20_audithistory.xml::f360Mysql_16.20_0::hp::(Checksum: 3:b1c46029dbb415efa282a06b68045634)
-- Audit history value migration
INSERT INTO
    audithistory (`issue_id`, `seqNumber`, `attrGuid`, `auditTime`, `oldValue`, `newValue`, `userName`, `conflict`, `projectVersion_id`)
    SELECT
        aho.`issue_id`, aho.`seqNumber`, aho.`attrGuid`, aho.`auditTime`,
        (CASE WHEN aho.oldValue IS NULL THEN NULL
            WHEN alOld.lookupValue IS NULL THEN CAST(aho.oldValue as char(500))
            ELSE alOld.lookupValue END),
        (CASE WHEN aho.newValue IS NULL THEN NULL
            WHEN alNew.lookupValue IS NULL THEN CAST(aho.newValue as char(500))
            ELSE alNew.lookupValue END),
        aho.`userName`, aho.`conflict`, aho.`projectVersion_id`
    FROM audithistory_old aho
        INNER JOIN attr a ON aho.attrGuid = a.guid
        LEFT JOIN attrlookup alNew ON alNew.attrGuid = aho.attrGuid AND aho.newValue = alNew.lookupIndex
        LEFT JOIN attrlookup alOld ON alOld.attrGuid = aho.attrGuid AND aho.oldValue = alOld.lookupIndex
    WHERE a.attrType = 'CUSTOM'
UNION ALL
    SELECT
        aho.`issue_id`, aho.`seqNumber`, aho.`attrGuid`, aho.`auditTime`,
        (CASE WHEN aho.oldValue = 0 THEN 'false'
            WHEN aho.oldValue = 1 THEN 'true'
            ELSE NULL END),
        (CASE WHEN aho.newValue = 0 THEN 'false'
            WHEN aho.newValue = 1 THEN 'true'
            ELSE NULL END),
        aho.`userName`, aho.`conflict`, aho.`projectVersion_id`
    FROM audithistory_old aho
    WHERE aho.attrGuid = '22222222-2222-2222-2222-222222222222'
UNION ALL
    SELECT
        aho.`issue_id`, aho.`seqNumber`, aho.`attrGuid`, aho.`auditTime`,
        (CASE WHEN aho.oldValue IS NULL THEN NULL
            WHEN upOld.userName IS NULL THEN CAST(aho.oldValue as char(500))
            ELSE upOld.userName END),
        (CASE WHEN aho.newValue IS NULL THEN NULL
            WHEN upNew.userName IS NULL THEN CAST(aho.newValue as char(500))
            ELSE upNew.userName END),
        aho.`userName`, aho.`conflict`, aho.`projectVersion_id`
    FROM audithistory_old aho
        LEFT JOIN userpreference upOld ON aho.oldValue = upOld.id
        LEFT JOIN userpreference upNew ON aho.newValue = upNew.id
    WHERE aho.attrGuid = 'User';

INSERT INTO
    audithistory (`issue_id`, `seqNumber`, `attrGuid`, `auditTime`, `oldValue`, `newValue`, `userName`, `conflict`, `projectVersion_id`)
SELECT
    aho.`issue_id`, aho.`seqNumber`, aho.`attrGuid`, aho.`auditTime`,
    (CASE WHEN aho.oldValue IS NULL THEN NULL ELSE CAST(aho.oldValue AS char(500)) END),
    (CASE WHEN aho.newValue IS NULL THEN NULL ELSE CAST(aho.newValue AS char(500)) END),
    aho.`userName`, aho.`conflict`, aho.`projectVersion_id` 
FROM audithistory_old aho 
WHERE NOT EXISTS (SELECT 1 
                    FROM audithistory ah 
                    WHERE aho.issue_id = ah.issue_id AND aho.seqNumber = ah.seqNumber);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', 'Audit history value migration', NOW(), 'Custom SQL', 'EXECUTED', 'dbF360Mysql_16.20_audithistory.xml', 'f360Mysql_16.20_0', '2.0.1', '3:b1c46029dbb415efa282a06b68045634', 262);

-- Changeset dbF360_16.20.xml::f360_16.20_0::hp::(Checksum: 3:ca402b8d076249fb5dc75f481abdfcda)
DROP TABLE `QRTZ_SIMPLE_TRIGGERS`;

DROP TABLE `QRTZ_CRON_TRIGGERS`;

DROP TABLE `QRTZ_SIMPROP_TRIGGERS`;

DROP TABLE `QRTZ_FIRED_TRIGGERS`;

DROP TABLE `QRTZ_PAUSED_TRIGGER_GRPS`;

DROP TABLE `QRTZ_LOCKS`;

DROP TABLE `QRTZ_CALENDARS`;

DROP TABLE `QRTZ_SCHEDULER_STATE`;

DROP TABLE `QRTZ_BLOB_TRIGGERS`;

DROP TABLE `QRTZ_TRIGGERS`;

DROP TABLE `QRTZ_JOB_DETAILS`;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Drop Table (x11)', 'EXECUTED', 'dbF360_16.20.xml', 'f360_16.20_0', '2.0.1', '3:ca402b8d076249fb5dc75f481abdfcda', 263);

-- Changeset dbF360_16.20.xml::f360_16.20_1::hp::(Checksum: 3:4b6600b213f0786d1c0e85c41862a61d)
-- Create cloudpool table
CREATE TABLE `cloudpool` (`id` BIGINT AUTO_INCREMENT  NOT NULL, `uuid` VARCHAR(36) NOT NULL, `path` VARCHAR(255), `name` VARCHAR(255), `description` VARCHAR(1999), `lastChangedOn` BIGINT NOT NULL, CONSTRAINT `PK_CLOUDPOOL` PRIMARY KEY (`id`));

CREATE INDEX `CLOUDPOOL_LASTCHANGEDON_IDX` ON `cloudpool`(`lastChangedOn`);

CREATE UNIQUE INDEX `UQ_CLOUDPOOL_UUID_IDX` ON `cloudpool`(`uuid`);

CREATE INDEX `CLOUDPOOL_PATH_IDX` ON `cloudpool`(`path`);

CREATE INDEX `CLOUDPOOL_NAME_IDX` ON `cloudpool`(`name`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', 'Create cloudpool table', NOW(), 'Create Table, Create Index (x4)', 'EXECUTED', 'dbF360_16.20.xml', 'f360_16.20_1', '2.0.1', '3:4b6600b213f0786d1c0e85c41862a61d', 264);

-- Changeset dbF360_16.20.xml::f360_16.20_2::hp::(Checksum: 3:9e58203af0daf6dbbc7beb235c7edba4)
-- Add hostName and cloudPool_id columns to cloudworker table
ALTER TABLE `cloudworker` ADD `hostName` VARCHAR(255);

ALTER TABLE `cloudworker` ADD `cloudPool_id` BIGINT;

ALTER TABLE `cloudworker` ADD CONSTRAINT `RefWorkerCloudPool` FOREIGN KEY (`cloudPool_id`) REFERENCES `cloudpool` (`id`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', 'Add hostName and cloudPool_id columns to cloudworker table', NOW(), 'Add Column, Add Foreign Key Constraint', 'EXECUTED', 'dbF360_16.20.xml', 'f360_16.20_2', '2.0.1', '3:9e58203af0daf6dbbc7beb235c7edba4', 265);

-- Changeset dbF360_16.20.xml::f360_16.20_3::hp::(Checksum: 3:3f5e40b325688b4d1413f503da7184c3)
-- Add cloudPool_id column to cloudjob table, change index on lastChangedOn, migrate removed state
ALTER TABLE `cloudjob` ADD `cloudPool_id` BIGINT;

ALTER TABLE `cloudjob` ADD CONSTRAINT `RefJobCloudPool` FOREIGN KEY (`cloudPool_id`) REFERENCES `cloudpool` (`id`);

DROP INDEX `UQ_CLOUDJOB_LASTCHANGEDON_IDX` ON `cloudjob`;

CREATE INDEX `CLOUDJOB_LASTCHANGEDON_IDX` ON `cloudjob`(`lastChangedOn`);

UPDATE `cloudjob` SET `jobState` = 'SCAN_RUNNING' WHERE jobState = 'SCAN_QUEUED';

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', 'Add cloudPool_id column to cloudjob table, change index on lastChangedOn, migrate removed state', NOW(), 'Add Column, Add Foreign Key Constraint, Drop Index, Create Index, Update Data', 'EXECUTED', 'dbF360_16.20.xml', 'f360_16.20_3', '2.0.1', '3:3f5e40b325688b4d1413f503da7184c3', 266);

-- Changeset dbF360_16.20.xml::f360_16.20_4::hp::(Checksum: 3:875447e28e2033d211e7ccded87fd141)
-- Create cloudpool_projectversion table
CREATE TABLE `projectversion_cloudpool` (`projectVersion_id` BIGINT NOT NULL, `cloudPool_id` BIGINT NOT NULL, CONSTRAINT `PK_PROJECTVERSION_CLOUDPOOL` PRIMARY KEY (`projectVersion_id`));

CREATE INDEX `PVCP_CLOUDPOOL_ID_IDX` ON `projectversion_cloudpool`(`cloudPool_id`);

ALTER TABLE `projectversion_cloudpool` ADD CONSTRAINT `RefPVCPCloudPool` FOREIGN KEY (`cloudPool_id`) REFERENCES `cloudpool` (`id`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', 'Create cloudpool_projectversion table', NOW(), 'Create Table, Create Index, Add Foreign Key Constraint', 'EXECUTED', 'dbF360_16.20.xml', 'f360_16.20_4', '2.0.1', '3:875447e28e2033d211e7ccded87fd141', 267);

-- Changeset dbF360_16.20.xml::f360_16.20_5::hp::(Checksum: 3:c2508e18ec9de3c89487114e7e2d7294)
-- Add value typing to tag definitions
ALTER TABLE `attr` ADD `valueType` VARCHAR(20);

UPDATE `attr` SET `valueType` = 'LIST' WHERE attrType = 'CUSTOM';

CREATE INDEX `ATTR_VALUETYPE_IDX` ON `attr`(`valueType`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', 'Add value typing to tag definitions', NOW(), 'Add Column, Update Data, Create Index', 'EXECUTED', 'dbF360_16.20.xml', 'f360_16.20_5', '2.0.1', '3:c2508e18ec9de3c89487114e7e2d7294', 268);

-- Changeset dbF360_16.20.xml::f360_16.20_6::hp::(Checksum: 3:f7e5cd933a515c70a0bc91456920363c)
-- Add support to multiple audit value types
ALTER TABLE `auditvalue` ADD `decimalValue` decimal(18,9);

ALTER TABLE `auditvalue` ADD `dateValue` DATE;

ALTER TABLE `auditvalue` ADD `textValue` VARCHAR(500);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', 'Add support to multiple audit value types', NOW(), 'Add Column', 'EXECUTED', 'dbF360_16.20.xml', 'f360_16.20_6', '2.0.1', '3:f7e5cd933a515c70a0bc91456920363c', 269);

-- Changeset dbF360_16.20.xml::f360_16.20_7::hp::(Checksum: 3:4f6188e0bfb07be349180be7809e8fe6)
-- Velocity templates for Bug filing
CREATE TABLE `bugfieldtemplategroup` (`id` BIGINT AUTO_INCREMENT  NOT NULL, `objectVersion` INT DEFAULT 1 NOT NULL, `name` VARCHAR(255) NOT NULL, `description` VARCHAR(500), `bugTrackerPluginId` VARCHAR(255) NOT NULL, CONSTRAINT `PK_BUGFIELDTEMPLATEGROUP` PRIMARY KEY (`id`), CONSTRAINT `UK_BugfieldTemplateGroupName` UNIQUE (`name`));

CREATE TABLE `bugfieldtemplate` (`id` BIGINT AUTO_INCREMENT  NOT NULL, `bugfieldTemplateGroup_id` BIGINT NOT NULL, `fieldName` VARCHAR(255) NOT NULL, `fieldValue` MEDIUMTEXT, CONSTRAINT `PK_BUGFIELDTEMPLATE` PRIMARY KEY (`id`));

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', 'Velocity templates for Bug filing', NOW(), 'Create Table (x2)', 'EXECUTED', 'dbF360_16.20.xml', 'f360_16.20_7', '2.0.1', '3:4f6188e0bfb07be349180be7809e8fe6', 270);

-- Changeset dbF360_16.20.xml::f360_16.20_9::hp::(Checksum: 3:12c061b3333f300af73c921e5664fdd8)
ALTER TABLE `bugfieldtemplate` ADD CONSTRAINT `FK_BugfieldTemplateGroupId` FOREIGN KEY (`bugfieldTemplateGroup_id`) REFERENCES `bugfieldtemplategroup` (`id`) ON DELETE CASCADE;

CREATE INDEX `BT_BTG_IDX` ON `bugfieldtemplate`(`bugfieldTemplateGroup_id`);

ALTER TABLE `bugfieldtemplate` ADD CONSTRAINT `UQ_BugfieldName` UNIQUE (`bugfieldTemplateGroup_id`, `fieldName`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Add Foreign Key Constraint, Create Index, Add Unique Constraint', 'EXECUTED', 'dbF360_16.20.xml', 'f360_16.20_9', '2.0.1', '3:12c061b3333f300af73c921e5664fdd8', 271);

-- Changeset dbF360_16.20.xml::f360_16.20_10::hp::(Checksum: 3:244f00342830945271af3dd6c1972f89)
-- Pre-seeded template groups for sample bugtracker plugins
INSERT INTO `bugfieldtemplategroup` (`bugTrackerPluginId`, `description`, `name`) VALUES ('com.fortify.sample.bugtracker.bugzilla.Bugzilla4BugTrackerPlugin', 'templates for Bugzilla text fields', 'Bugzilla');

INSERT INTO `bugfieldtemplategroup` (`bugTrackerPluginId`, `description`, `name`) VALUES ('com.fortify.sample.defecttracking.jira.Jira4BugTrackerPlugin', 'templates for JIRA (legacy plugin using SOAP api) text fields', 'JIRA');

INSERT INTO `bugfieldtemplategroup` (`bugTrackerPluginId`, `description`, `name`) VALUES ('com.fortify.pub.bugtracker.plugin.jira.JiraBatchBugTrackerPlugin', 'templates for JIRA 7 (plugin using REST api) text fields', 'JIRA 7');

INSERT INTO `bugfieldtemplategroup` (`bugTrackerPluginId`, `description`, `name`) VALUES ('com.fortify.sample.bugtracker.alm.AlmBugTrackerPlugin', 'templates for HPE ALM text fields', 'HPE ALM');

INSERT INTO `bugfieldtemplategroup` (`bugTrackerPluginId`, `description`, `name`) VALUES ('com.fortify.pub.bugtracker.plugin.tfs.TFSBatchBugTrackerPlugin', 'templates for TFS/Visual Studio Online text fields', 'TFS/Visual Studio Online');

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', 'Pre-seeded template groups for sample bugtracker plugins', NOW(), 'Insert Row (x5)', 'EXECUTED', 'dbF360_16.20.xml', 'f360_16.20_10', '2.0.1', '3:244f00342830945271af3dd6c1972f89', 272);

-- Changeset dbF360_16.20.xml::f360_16.20_11::hp::(Checksum: 3:995cdd7f17f10f6aa71cf2d93d46937b)
-- Information about Audit Assistant status for each project version
CREATE TABLE `auditassistantstatus` (`projectVersion_id` BIGINT NOT NULL, `userName` VARCHAR(255), `fprFilePath` VARCHAR(255), `status` VARCHAR(80) DEFAULT 'NONE', `serverId` BIGINT, `serverStatus` INT, `serverStatusCheckCount` INT DEFAULT 0, `message` VARCHAR(2000), `lastTrainingTime` DATETIME, CONSTRAINT `PK_AUDITASSISTANTSTATUS` PRIMARY KEY (`projectVersion_id`));

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', 'Information about Audit Assistant status for each project version', NOW(), 'Create Table', 'EXECUTED', 'dbF360_16.20.xml', 'f360_16.20_11', '2.0.1', '3:995cdd7f17f10f6aa71cf2d93d46937b', 273);

-- Changeset dbF360_16.20.xml::f360_16.20_12::hp::(Checksum: 3:b6ee7a30205358fc999cedb26febb6e4)
-- Flag that should be used to mark values that mean "not an issue".
ALTER TABLE `attrlookup` ADD `consideredIssue` VARCHAR(1) DEFAULT 'N';

UPDATE `attrlookup` SET `consideredIssue` = 'N';

UPDATE `attrlookup` SET `consideredIssue` = 'Y' WHERE attrGuid = '87f2364f-dcd4-49e6-861d-f8d3f351686b' and lookupIndex between 3 and 4;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', 'Flag that should be used to mark values that mean "not an issue".', NOW(), 'Add Column, Update Data (x2)', 'EXECUTED', 'dbF360_16.20.xml', 'f360_16.20_12', '2.0.1', '3:b6ee7a30205358fc999cedb26febb6e4', 274);

-- Changeset dbF360_16.20.xml::f360_16.20_13::hp::(Checksum: 3:80f923cae55e2546b1762902d0f95bc2)
CREATE UNIQUE INDEX `AuditHistoryIssueAltKey` ON `audithistory`(`issue_id`, `attrGuid`, `auditTime`);

CREATE INDEX `AuditHistoryPVAltKey` ON `audithistory`(`projectVersion_id`, `attrGuid`, `auditTime`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Create Index (x2)', 'EXECUTED', 'dbF360_16.20.xml', 'f360_16.20_13', '2.0.1', '3:80f923cae55e2546b1762902d0f95bc2', 275);

-- Changeset dbF360_16.20.xml::f360_16.20_14::hp::(Checksum: 3:09aa9a445351ca215f23c14e877bfb66)
DROP TABLE `audithistory_old`;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Drop Table', 'EXECUTED', 'dbF360_16.20.xml', 'f360_16.20_14', '2.0.1', '3:09aa9a445351ca215f23c14e877bfb66', 276);

-- Changeset dbF360_16.20.xml::f360_16.20_15::hp::(Checksum: 3:9cbc07a46f82d5e7681638f4c156a359)
CREATE VIEW `audithistoryview` AS SELECT h.issue_id  issue_id,
                   h.seqNumber seqNumber,
                   h.attrGuid attrGuid,
                   h.auditTime auditTime,
                   h.oldValue oldValue,
                   h.newValue newValue,
                   h.projectVersion_id projectVersion_id,
                   h.userName userName,
                   h.conflict conflict,
                   a.attrName attrName,
                   a.defaultValue defaultValue
            from audithistory h
            JOIN attr a ON h.attrGuid=a.guid;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Create View', 'EXECUTED', 'dbF360_16.20.xml', 'f360_16.20_15', '2.0.1', '3:9cbc07a46f82d5e7681638f4c156a359', 277);

-- Changeset dbF360_16.20.xml::f360_16.20_16::hp::(Checksum: 3:8b11257ee66734dcde5a446b3e9b4b1c)
-- BIRT temporary directory
INSERT INTO `configproperty` (`appliedAfterRestarting`, `description`, `groupName`, `propertyName`, `propertyOrder`, `propertyType`, `propertyValue`) VALUES ('N', 'A custum BIRT tmp directory (the default one is taken from JVM system variable java.io.tmpdir ).', 'birt.report', 'birt.report.tmpDir', 60, 'STRING', '');

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', 'BIRT temporary directory', NOW(), 'Insert Row', 'EXECUTED', 'dbF360_16.20.xml', 'f360_16.20_16', '2.0.1', '3:8b11257ee66734dcde5a446b3e9b4b1c', 278);

-- Changeset dbF360_16.20.xml::f360_16.20_17::hp::(Checksum: 3:47488c6d9fe96d68202d2413b1969aa5)
-- bugtrackertemplate table is now obsolete
DROP TABLE `bugtrackertemplate`;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', 'bugtrackertemplate table is now obsolete', NOW(), 'Drop Table', 'EXECUTED', 'dbF360_16.20.xml', 'f360_16.20_17', '2.0.1', '3:47488c6d9fe96d68202d2413b1969aa5', 279);

-- Changeset dbF360_16.20.xml::f360_16.20_18::hp::(Checksum: 3:2f7e910cc94dd80ec927975803f5e5a5)
INSERT INTO `configproperty` (`appliedAfterRestarting`, `description`, `groupName`, `groupSwitch`, `propertyName`, `propertyType`, `propertyValue`, `required`) VALUES ('Y', 'X.509 Integration', 'x509', 'Y', 'x509.enabled', 'BOOLEAN', 'false', 'N');

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Insert Row', 'EXECUTED', 'dbF360_16.20.xml', 'f360_16.20_18', '2.0.1', '3:2f7e910cc94dd80ec927975803f5e5a5', 280);

-- Changeset dbF360_Data_16.20.xml::f360_Data_16.20_1::hp::(Checksum: 3:aeb6dccdae71ecf98c620fd7dfce2ae1)
-- Pre-seeded Velocity templates for sample bugtracker plugins (standard newline using backslash n)
INSERT INTO bugfieldtemplate (bugfieldTemplateGroup_id, fieldName, fieldValue) VALUES ((select id from bugfieldtemplategroup where name = 'Bugzilla'), 'Bug Summary', 'Fix #if ($issues.size() == 1) $issues.get(0).get("ATTRIBUTE_CATEGORY") in $issues.get(0).get("ATTRIBUTE_FILE") #else $ATTRIBUTE_CATEGORY #end \n##This pre-defined template renders a single line for "Bug Summary" ');

INSERT INTO bugfieldtemplate (bugfieldTemplateGroup_id, fieldName, fieldValue) VALUES ((select id from bugfieldtemplategroup where name = 'Bugzilla'), 'Bug Description', '#macro( addcontent $attrib )   \n  #if ($is.get($attrib)) $is.get($attrib) $newline $newline #end    \n#end  \n  \n$newline  \n#if ($issues.size() == 1)   \n    #set ($is = $issues.get(0))  \n    #addcontent("ISSUE_DESCRIPTION")  \n    Issue Link: #addcontent("ISSUE_DEEPLINK")  \n    Issue Instance Id: #addcontent("ATTRIBUTE_INSTANCE_ID")  \n    File Name:  #addcontent("ATTRIBUTE_FILE")  \n    Line Number: #addcontent("ATTRIBUTE_LINE")  \n    Issue Category: #addcontent("ATTRIBUTE_CATEGORY")  \n    Application Name: #addcontent("PROJECT_NAME")  \n    Application Version Name: #addcontent("PROJECTVERSION_NAME") \n    Custom Tags: #addcontent("ISSUE_CUSTOMTAGS") \n    Issue Detail: #addcontent("ISSUE_DETAIL") \n    Issue Recommendation: #addcontent("ISSUE_RECOMMENDATION") \n    Comments: #addcontent("ATTRIBUTE_COMMENTS")  \n\n#else \n  Issue Listing \n  $newline \n  #foreach( $is in $issues ) \n    Issue Link:  $is.get("ISSUE_DEEPLINK") $newline File Name: $is.get("ATTRIBUTE_FILE") $newline $newline \n  #end \n\n#end \n##This is the pre-defined velocity template for "Bug Description".  \n##Use the SSC Administration page to manage or customize bugfield templates.');

INSERT INTO bugfieldtemplate (bugfieldTemplateGroup_id, fieldName, fieldValue) VALUES ((select id from bugfieldtemplategroup where name = 'JIRA'), 'Bug Summary', 'Fix #if ($issues.size() == 1) $issues.get(0).get("ATTRIBUTE_CATEGORY") in $issues.get(0).get("ATTRIBUTE_FILE") #else $ATTRIBUTE_CATEGORY #end \n##This pre-defined template renders a single line for "Bug Summary" ');

INSERT INTO bugfieldtemplate (bugfieldTemplateGroup_id, fieldName, fieldValue) VALUES ((select id from bugfieldtemplategroup where name = 'JIRA'), 'Bug Description', '#macro( addcontent $attrib )   \n  #if ($is.get($attrib)) $is.get($attrib) $newline $newline #end    \n#end  \n  \n$newline  \n#if ($issues.size() == 1)   \n    #set ($is = $issues.get(0))  \n    #addcontent("ISSUE_DESCRIPTION")  \n    Issue Link: #addcontent("ISSUE_DEEPLINK")  \n    Issue Instance Id: #addcontent("ATTRIBUTE_INSTANCE_ID")  \n    File Name:  #addcontent("ATTRIBUTE_FILE")  \n    Line Number: #addcontent("ATTRIBUTE_LINE")  \n    Issue Category: #addcontent("ATTRIBUTE_CATEGORY")  \n    Application Name: #addcontent("PROJECT_NAME")  \n    Application Version Name: #addcontent("PROJECTVERSION_NAME") \n    Custom Tags: #addcontent("ISSUE_CUSTOMTAGS") \n    Issue Detail: #addcontent("ISSUE_DETAIL") \n    Issue Recommendation: #addcontent("ISSUE_RECOMMENDATION") \n    Comments: #addcontent("ATTRIBUTE_COMMENTS")  \n\n#else \n  Issue Listing \n  $newline \n  #foreach( $is in $issues ) \n    Issue Link:  $is.get("ISSUE_DEEPLINK") $newline File Name: $is.get("ATTRIBUTE_FILE") $newline $newline \n  #end \n\n#end \n##This is the pre-defined velocity template for "Bug Description".  \n##Use the SSC Administration page to manage or customize bugfield templates.');

INSERT INTO bugfieldtemplate (bugfieldTemplateGroup_id, fieldName, fieldValue) VALUES ((select id from bugfieldtemplategroup where name = 'JIRA 7'), 'Summary', 'Fix #if ($issues.size() == 1) $issues.get(0).get("ATTRIBUTE_CATEGORY") in $issues.get(0).get("ATTRIBUTE_FILE") #else $ATTRIBUTE_CATEGORY #end \n##This pre-defined template renders a single line for "Summary" ');

INSERT INTO bugfieldtemplate (bugfieldTemplateGroup_id, fieldName, fieldValue) VALUES ((select id from bugfieldtemplategroup where name = 'JIRA 7'), 'Description', '#macro( addcontent $attrib )   \n  #if ($is.get($attrib)) $is.get($attrib) $newline $newline #end    \n#end  \n  \n$newline  \n#if ($issues.size() == 1)   \n    #set ($is = $issues.get(0))  \n    #addcontent("ISSUE_DESCRIPTION")  \n    Issue Link: #addcontent("ISSUE_DEEPLINK")  \n    Issue Instance Id: #addcontent("ATTRIBUTE_INSTANCE_ID")  \n    File Name:  #addcontent("ATTRIBUTE_FILE")  \n    Line Number: #addcontent("ATTRIBUTE_LINE")  \n    Issue Category: #addcontent("ATTRIBUTE_CATEGORY")  \n    Application Name: #addcontent("PROJECT_NAME")  \n    Application Version Name: #addcontent("PROJECTVERSION_NAME") \n    Custom Tags: #addcontent("ISSUE_CUSTOMTAGS") \n    Issue Detail: #addcontent("ISSUE_DETAIL") \n    Issue Recommendation: #addcontent("ISSUE_RECOMMENDATION") \n    Comments: #addcontent("ATTRIBUTE_COMMENTS")  \n\n#else \n  Issue Listing \n  $newline \n  #foreach( $is in $issues ) \n    Issue Link:  $is.get("ISSUE_DEEPLINK") $newline File Name: $is.get("ATTRIBUTE_FILE") $newline $newline \n  #end \n\n#end \n##This is the pre-defined velocity template for "Description".  \n##Use the SSC Administration page to manage or customize bugfield templates.');

INSERT INTO bugfieldtemplate (bugfieldTemplateGroup_id, fieldName, fieldValue) VALUES ((select id from bugfieldtemplategroup where name = 'HPE ALM'), 'Summary', 'Fix #if ($issues.size() == 1) $issues.get(0).get("ATTRIBUTE_CATEGORY") in $issues.get(0).get("ATTRIBUTE_FILE") #else $ATTRIBUTE_CATEGORY #end \n##This pre-defined template renders a single line for "Summary" ');

INSERT INTO bugfieldtemplate (bugfieldTemplateGroup_id, fieldName, fieldValue) VALUES ((select id from bugfieldtemplategroup where name = 'HPE ALM'), 'Description', '#macro( addcontent $attrib )   \n  #if ($is.get($attrib)) $is.get($attrib) $newline $newline #end    \n#end  \n  \n$newline  \n#if ($issues.size() == 1)   \n    #set ($is = $issues.get(0))  \n    #addcontent("ISSUE_DESCRIPTION")  \n    Issue Link: #addcontent("ISSUE_DEEPLINK")  \n    Issue Instance Id: #addcontent("ATTRIBUTE_INSTANCE_ID")  \n    File Name:  #addcontent("ATTRIBUTE_FILE")  \n    Line Number: #addcontent("ATTRIBUTE_LINE")  \n    Issue Category: #addcontent("ATTRIBUTE_CATEGORY")  \n    Application Name: #addcontent("PROJECT_NAME")  \n    Application Version Name: #addcontent("PROJECTVERSION_NAME") \n    Custom Tags: #addcontent("ISSUE_CUSTOMTAGS") \n    Issue Detail: #addcontent("ISSUE_DETAIL") \n    Issue Recommendation: #addcontent("ISSUE_RECOMMENDATION") \n    Comments: #addcontent("ATTRIBUTE_COMMENTS")  \n\n#else \n  Issue Listing \n  $newline \n  #foreach( $is in $issues ) \n    Issue Link:  $is.get("ISSUE_DEEPLINK") $newline File Name: $is.get("ATTRIBUTE_FILE") $newline $newline \n  #end \n\n#end \n##This is the pre-defined velocity template for "Description".  \n##Use the SSC Administration page to manage or customize bugfield templates.');

INSERT INTO bugfieldtemplate (bugfieldTemplateGroup_id, fieldName, fieldValue) VALUES ((select id from bugfieldtemplategroup where name = 'TFS/Visual Studio Online'), 'Title', 'Fix #if ($issues.size() == 1) $issues.get(0).get("ATTRIBUTE_CATEGORY") in $issues.get(0).get("ATTRIBUTE_FILE") #else $ATTRIBUTE_CATEGORY #end \n##This pre-defined template renders a single line for "Title" ');

INSERT INTO bugfieldtemplate (bugfieldTemplateGroup_id, fieldName, fieldValue) VALUES ((select id from bugfieldtemplategroup where name = 'TFS/Visual Studio Online'), 'Description', '#set($linefeed = $newline) \n#set($newline = $linebreak) \n#macro( addcontent $attrib )   \n  #if ($is.get($attrib)) $is.get($attrib) $newline $newline  #end    \n#end  \n  \n$newline  \n#if ($issues.size() == 1)   \n    #set ($is = $issues.get(0))  \n    #addcontent("ISSUE_DESCRIPTION")  \n    Issue Link: #addcontent("ISSUE_DEEPLINK")  \n    Issue Instance Id: #addcontent("ATTRIBUTE_INSTANCE_ID")  \n    File Name:  #addcontent("ATTRIBUTE_FILE")  \n    Line Number: #addcontent("ATTRIBUTE_LINE")  \n    Issue Category: #addcontent("ATTRIBUTE_CATEGORY")  \n    Application Name: #addcontent("PROJECT_NAME")  \n    Application Version Name: #addcontent("PROJECTVERSION_NAME") \n    Custom Tags: #addcontent("ISSUE_CUSTOMTAGS") \n    Issue Detail: #addcontent("ISSUE_DETAIL") \n    Issue Recommendation: #addcontent("ISSUE_RECOMMENDATION") \n    Comments: #if ($is.get("ATTRIBUTE_COMMENTS")) $is.get("ATTRIBUTE_COMMENTS").replace($linefeed, $linebreak) #end  \n\n#else \n  Issue Listing \n  $newline $newline \n  #foreach( $is in $issues ) \n    Issue Link:  $is.get("ISSUE_DEEPLINK") $newline File Name: $is.get("ATTRIBUTE_FILE") $newline $newline \n  #end \n\n#end \n##This is the pre-defined velocity template for "Description".  \n##Use the SSC Administration page to manage or customize bugfield templates.');

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', 'Pre-seeded Velocity templates for sample bugtracker plugins (standard newline using backslash n)', NOW(), 'Custom SQL (x10)', 'EXECUTED', 'dbF360_Data_16.20.xml', 'f360_Data_16.20_1', '2.0.1', '3:aeb6dccdae71ecf98c620fd7dfce2ae1', 281);

-- Changeset dbF360_17.10_auditcomment.xml::f360_17.10_auditcomment_1::hp::(Checksum: 3:a93d20687e5ef9d3ac4ad52a553ca459)
DROP INDEX `AuditCommentAltKey` ON `auditcomment`;

ALTER TABLE `auditcomment` RENAME `auditcomment_old`;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Drop Index, Rename Table', 'EXECUTED', 'dbF360_17.10_auditcomment.xml', 'f360_17.10_auditcomment_1', '2.0.1', '3:a93d20687e5ef9d3ac4ad52a553ca459', 282);

-- Changeset dbF360_17.10_auditcomment.xml::f360_17.10_auditcomment_3::hp::(Checksum: 3:12a05fbd79b515e5eda4bbabea7681fb)
CREATE TABLE `auditcomment` (`issue_id` BIGINT NOT NULL, `seqNumber` BIGINT NOT NULL, `auditTime` BIGINT, `commentText` MEDIUMTEXT, `userName` VARCHAR(255), CONSTRAINT `PK_AUDITCOMMENT` PRIMARY KEY (`issue_id`, `seqNumber`));

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Create Table', 'EXECUTED', 'dbF360_17.10_auditcomment.xml', 'f360_17.10_auditcomment_3', '2.0.1', '3:12a05fbd79b515e5eda4bbabea7681fb', 283);

-- Changeset dbF360Mysql_17.10_auditcomment.xml::f360Mysql_17.10_0::hp::(Checksum: 3:9773b1c24f144124e2e2f7c05646fa5f)
-- Audit comment value migration
INSERT INTO auditcomment (`issue_id`, `seqNumber`, `auditTime`, `commentText`, `userName`)
            SELECT `issue_id`, `seqNumber`, `auditTime`, `commentText`, `userName`
            FROM auditcomment_old;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', 'Audit comment value migration', NOW(), 'Custom SQL', 'EXECUTED', 'dbF360Mysql_17.10_auditcomment.xml', 'f360Mysql_17.10_0', '2.0.1', '3:9773b1c24f144124e2e2f7c05646fa5f', 284);

-- Changeset dbF360_17.10.xml::f360_17.10_1::hp::(Checksum: 3:dc68df8da2830f71a4300b1105124c17)
ALTER TABLE `snapshot` ADD `artifact_id` BIGINT;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Add Column', 'EXECUTED', 'dbF360_17.10.xml', 'f360_17.10_1', '2.0.1', '3:dc68df8da2830f71a4300b1105124c17', 285);

-- Changeset dbF360_17.10.xml::f360_17.10_2::hp::(Checksum: 3:1a3ba3199c8abd552bbb4355e82e5c72)
ALTER TABLE `alert` ADD `customMessage` VARCHAR(2000);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Add Column', 'EXECUTED', 'dbF360_17.10.xml', 'f360_17.10_2', '2.0.1', '3:1a3ba3199c8abd552bbb4355e82e5c72', 286);

-- Changeset dbF360_17.10.xml::f360_17.10_3::hp::(Checksum: 3:dbe75b8b70a8c62c7d931f0c8b974080)
ALTER TABLE `alerthistory` ADD `customMessage` VARCHAR(2000);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Add Column', 'EXECUTED', 'dbF360_17.10.xml', 'f360_17.10_3', '2.0.1', '3:dbe75b8b70a8c62c7d931f0c8b974080', 287);

-- Changeset dbF360_17.10.xml::f360_17.10_4::hp::(Checksum: 3:48b0b5037d9fd2299d77277623893734)
CREATE TABLE `scan_issue_ca` (`projectVersion_id` BIGINT NOT NULL, `scan_id` BIGINT NOT NULL, `scan_issue_id` BIGINT NOT NULL, `dataVersion` INT NOT NULL, `integerValue01` INT, `integerValue02` INT, `integerValue03` INT, `decimalValue01` decimal(18,9), `decimalValue02` decimal(18,9), `decimalValue03` decimal(18,9), `decimalValue04` decimal(18,9), `decimalValue05` decimal(18,9), `dateValue01` DATE, `dateValue02` DATE, `dateValue03` DATE, `dateValue04` DATE, `dateValue05` DATE, `textValue01` VARCHAR(1000), `textValue02` VARCHAR(1000), `textValue03` VARCHAR(1000), `textValue04` VARCHAR(1000), `textValue05` VARCHAR(1000), `textValue06` VARCHAR(1000), `textValue07` VARCHAR(1000), `textValue08` VARCHAR(1000), `textValue09` VARCHAR(1000), `textValue10` VARCHAR(1000), `textValue11` VARCHAR(1000), `textValue12` VARCHAR(1000), `clobValue01` MEDIUMTEXT, `clobValue02` MEDIUMTEXT, CONSTRAINT `PK_SCAN_ISSUE_CA` PRIMARY KEY (`scan_issue_id`));

CREATE INDEX `SCAN_ISSUE_CA_PV_SCAN_ID_IDX` ON `scan_issue_ca`(`projectVersion_id`, `scan_id`, `scan_issue_id`);

CREATE TABLE `issue_ca` (`issue_id` BIGINT NOT NULL, `projectVersion_id` BIGINT NOT NULL, `issueInstanceId` VARCHAR(80) NOT NULL, `engineType` VARCHAR(20) NOT NULL, `dataVersion` INT NOT NULL, `integerValue01` INT, `integerValue02` INT, `integerValue03` INT, `decimalValue01` decimal(18,9), `decimalValue02` decimal(18,9), `decimalValue03` decimal(18,9), `decimalValue04` decimal(18,9), `decimalValue05` decimal(18,9), `dateValue01` DATE, `dateValue02` DATE, `dateValue03` DATE, `dateValue04` DATE, `dateValue05` DATE, `textValue01` VARCHAR(1000), `textValue02` VARCHAR(1000), `textValue03` VARCHAR(1000), `textValue04` VARCHAR(1000), `textValue05` VARCHAR(1000), `textValue06` VARCHAR(1000), `textValue07` VARCHAR(1000), `textValue08` VARCHAR(1000), `textValue09` VARCHAR(1000), `textValue10` VARCHAR(1000), `textValue11` VARCHAR(1000), `textValue12` VARCHAR(1000), `clobValue01` MEDIUMTEXT, `clobValue02` MEDIUMTEXT, CONSTRAINT `PK_ISSUE_CA` PRIMARY KEY (`issue_id`));

CREATE INDEX `ISSUE_ATTR_PV_ISSUE_ID_IDX` ON `issue_ca`(`projectVersion_id`, `issue_id`);

CREATE TABLE `parserpluginmetadata` (`id` BIGINT AUTO_INCREMENT  NOT NULL, `pluginId` VARCHAR(80) NOT NULL, `apiVersion` VARCHAR(8) NOT NULL, `pluginName` VARCHAR(40) NOT NULL, `pluginVersion` VARCHAR(25) NOT NULL, `dataVersion` INT NOT NULL, `vendorName` VARCHAR(80) NOT NULL, `vendorUrl` VARCHAR(100), `engineType` VARCHAR(80) NOT NULL, `description` VARCHAR(500), CONSTRAINT `PK_PARSERPLUGINMETADATA` PRIMARY KEY (`id`));

CREATE UNIQUE INDEX `PLUGIN_META_DATA_ID_VERS_IDX` ON `parserpluginmetadata`(`pluginId`, `pluginVersion`);

CREATE TABLE `pluginimage` (`metadataPluginId` VARCHAR(80) NOT NULL, `imageType` VARCHAR(16) NOT NULL, `imageData` MEDIUMBLOB, CONSTRAINT `PK_PLUGINIMAGE` PRIMARY KEY (`metadataPluginId`, `imageType`));

CREATE TABLE `pluginconfiguration` (`metadataId` BIGINT NOT NULL, `parameterName` VARCHAR(30) NOT NULL, `parameterType` VARCHAR(10) NOT NULL, CONSTRAINT `PK_PLUGINCONFIGURATION` PRIMARY KEY (`metadataId`, `parameterName`));

CREATE TABLE `pluginlocalization` (`metadataId` BIGINT NOT NULL, `languageId` VARCHAR(10) NOT NULL, `localizationData` MEDIUMBLOB NOT NULL, CONSTRAINT `PK_PLUGINLOCALIZATION` PRIMARY KEY (`metadataId`, `languageId`));

CREATE TABLE `issuemetadata` (`id` BIGINT AUTO_INCREMENT  NOT NULL, `engineType` VARCHAR(80) NOT NULL, `dataVersion` INT NOT NULL, `attribute_id` VARCHAR(50) NOT NULL, `attributeDataType` VARCHAR(30) NOT NULL, `dataColumnName` VARCHAR(32) NOT NULL, CONSTRAINT `PK_ISSUEMETADATA` PRIMARY KEY (`id`));

CREATE INDEX `ISSUE_META_DATA_ET_DV_IDX` ON `issuemetadata`(`engineType`, `dataVersion`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Create Table, Create Index, Create Table, Create Index, Create Table, Create Index, Create Table (x4), Create Index', 'EXECUTED', 'dbF360_17.10.xml', 'f360_17.10_4', '2.0.1', '3:48b0b5037d9fd2299d77277623893734', 288);

-- Changeset dbF360_17.10.xml::f360_17.10_5::hp::(Checksum: 3:bc47200e757f247480c9d5dd6d5b0952)
-- Remove FK constraint RefAppEntEventLog - not used anywhere, elimination of possible deadlocks
ALTER TABLE `eventlogentry` DROP FOREIGN KEY `RefAppEntEventLog`;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', 'Remove FK constraint RefAppEntEventLog - not used anywhere, elimination of possible deadlocks', NOW(), 'Drop Foreign Key Constraint', 'EXECUTED', 'dbF360_17.10.xml', 'f360_17.10_5', '2.0.1', '3:bc47200e757f247480c9d5dd6d5b0952', 289);

-- Changeset dbF360_17.10.xml::f360_17.10_6::hp::(Checksum: 3:5aedd5fd15ac507aa39b947107dcee7f)
CREATE TABLE `issueviewtemplate` (`id` INT AUTO_INCREMENT  NOT NULL, `engineType` VARCHAR(20) NOT NULL, `dataVersion` INT NOT NULL, `templateData` MEDIUMBLOB, `objectVersion` INT NOT NULL, `description` VARCHAR(250), CONSTRAINT `PK_ISSUEVIEWTEMPLATE` PRIMARY KEY (`id`));

CREATE UNIQUE INDEX `ISSUE_VIEW_TPL_ENGINE_VERS_IDX` ON `issueviewtemplate`(`engineType`, `dataVersion`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Create Table, Create Index', 'EXECUTED', 'dbF360_17.10.xml', 'f360_17.10_6', '2.0.1', '3:5aedd5fd15ac507aa39b947107dcee7f', 290);

-- Changeset dbF360_17.10.xml::f360_17.10_7::hp::(Checksum: 3:658bb0f878bdeda30b18ce1005ed6aea)
-- Audit Assistant training status for each project version
CREATE TABLE `auditassistanttrainingstatus` (`projectVersion_id` BIGINT NOT NULL, `userName` VARCHAR(255), `status` VARCHAR(80) DEFAULT 'NONE', `lastTrainingTime` DATETIME, `message` VARCHAR(2000), CONSTRAINT `PK_AATRAININGSTATUS` PRIMARY KEY (`projectVersion_id`));

ALTER TABLE `auditassistantstatus` DROP COLUMN `lastTrainingTime`;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', 'Audit Assistant training status for each project version', NOW(), 'Create Table, Drop Column', 'EXECUTED', 'dbF360_17.10.xml', 'f360_17.10_7', '2.0.1', '3:658bb0f878bdeda30b18ce1005ed6aea', 291);

-- Changeset dbF360_17.10.xml::f360_17.10_8::hp::(Checksum: 3:9abc2f59a8f709cd44c6e2788411ea11)
ALTER TABLE `ldapserver` ADD `checkSslTrust` VARCHAR(1) NOT NULL DEFAULT 'Y';

ALTER TABLE `ldapserver` ADD `checkSslHostname` VARCHAR(1) NOT NULL DEFAULT 'N';

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Add Column', 'EXECUTED', 'dbF360_17.10.xml', 'f360_17.10_8', '2.0.1', '3:9abc2f59a8f709cd44c6e2788411ea11', 292);

-- Changeset dbF360_17.10.xml::f360_17.10_9::hp::(Checksum: 3:add8d789f080c0876adf7361c2bc90bc)
-- Add non unique index on eventDate field
CREATE INDEX `EVENTLOGENTRY_EVENTDATE_IDX` ON `eventlogentry`(`eventDate`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', 'Add non unique index on eventDate field', NOW(), 'Create Index', 'EXECUTED', 'dbF360_17.10.xml', 'f360_17.10_9', '2.0.1', '3:add8d789f080c0876adf7361c2bc90bc', 293);

-- Changeset dbF360_17.10.xml::f360_17.10_10::hp::(Checksum: 3:43ba1fb31e0b9d28269878766ad2eb89)
-- Value provided by issue parser and contains a numeric data version of the issue data parsed by plugin.
ALTER TABLE `scan` ADD `dataVersion` INT;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', 'Value provided by issue parser and contains a numeric data version of the issue data parsed by plugin.', NOW(), 'Add Column', 'EXECUTED', 'dbF360_17.10.xml', 'f360_17.10_10', '2.0.1', '3:43ba1fb31e0b9d28269878766ad2eb89', 294);

-- Changeset dbF360_17.10.xml::f360_17.10_11::hp::(Checksum: 3:61fffd57e0df5722286ba1225cb6b50c)
-- Engine type of tha scan in artifact. Value of the field is null if artifact contains multiply scans.
ALTER TABLE `artifact` ADD `engineType` VARCHAR(20);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', 'Engine type of tha scan in artifact. Value of the field is null if artifact contains multiply scans.', NOW(), 'Add Column', 'EXECUTED', 'dbF360_17.10.xml', 'f360_17.10_11', '2.0.1', '3:61fffd57e0df5722286ba1225cb6b50c', 295);

-- Changeset dbF360_17.10.xml::f360_17.10_12::hp::(Checksum: 3:23dcedab7be6a52ab3d0a42553efcccc)
ALTER TABLE `alerttrigger` ADD `resetAfterTriggering` VARCHAR(1) NOT NULL DEFAULT 'N';

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Add Column', 'EXECUTED', 'dbF360_17.10.xml', 'f360_17.10_12', '2.0.1', '3:23dcedab7be6a52ab3d0a42553efcccc', 296);

-- Changeset dbF360_17.10.xml::f360_17.10_13::hp::(Checksum: 3:16c7bd2a86da00f19f527607e8c74e29)
CREATE UNIQUE INDEX `AuditCommentAltKey` ON `auditcomment`(`issue_id`, `auditTime`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Create Index', 'EXECUTED', 'dbF360_17.10.xml', 'f360_17.10_13', '2.0.1', '3:16c7bd2a86da00f19f527607e8c74e29', 297);

-- Changeset dbF360_17.10.xml::f360_17.10_14::hp::(Checksum: 3:dc511c0a07da8802dcff44c3eda946ec)
DROP TABLE `auditcomment_old`;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Drop Table', 'EXECUTED', 'dbF360_17.10.xml', 'f360_17.10_14', '2.0.1', '3:dc511c0a07da8802dcff44c3eda946ec', 298);

-- Changeset dbF360_17.10.xml::f360_17.10_15::hp::(Checksum: 3:5d14ad103d6344a4be5073df50e4e256)
-- some formatting tweaks for velocity templates: replace newlines with linebreak for html, remove prefix spaces introduced by addcontent macro and a few others
UPDATE bugfieldtemplate SET fieldValue = REPLACE(fieldValue, 'Custom Tags: #addcontent', 'Custom Tags: $newline#addcontent');

UPDATE bugfieldtemplate SET fieldValue = REPLACE(fieldValue, 'Comments: #', 'Comments: $newline#');

UPDATE bugfieldtemplate SET fieldValue = REPLACE(fieldValue, 'Issue Recommendation: #addcontent', 'Issue Recommendation: $newline#addcontent');

UPDATE bugfieldtemplate SET fieldValue = REPLACE(fieldValue, '#macro( addcontent $attrib )   ', '#macro( addcontent $attrib )');

UPDATE bugfieldtemplate SET fieldValue = REPLACE(fieldValue, '  #if ($is.get($attrib)) $is.get($attrib)', '#if($is.get($attrib))$is.get($attrib)');

UPDATE bugfieldtemplate SET fieldValue = REPLACE(fieldValue, '#if($is.get($attrib))$is.get($attrib) ', '#if($is.get($attrib))$is.get($attrib).replace($linefeed, $linebreak) ') WHERE fieldValue LIKE '%#set($linefeed = $newline)%';

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', 'some formatting tweaks for velocity templates: replace newlines with linebreak for html, remove prefix spaces introduced by addcontent macro and a few others', NOW(), 'Custom SQL (x6)', 'EXECUTED', 'dbF360_17.10.xml', 'f360_17.10_15', '2.0.1', '3:5d14ad103d6344a4be5073df50e4e256', 299);

-- Changeset dbF360_17.10.xml::f360_17.10_16::hp::(Checksum: 3:852d01cc1429a88dcc4dc38a70d4dde4)
-- Change "value" column of usersessionstate table to a CLOB datatype
CREATE TABLE `usersessionstate_temp` (`id` INT AUTO_INCREMENT  NOT NULL, `userName` VARCHAR(255) NOT NULL, `name` VARCHAR(255), `value` MEDIUMTEXT, `category` VARCHAR(100), `projectVersionId` INT, CONSTRAINT `PK_USERSESSIONSTATE` PRIMARY KEY (`id`));

INSERT INTO usersessionstate_temp (userName, name, value, category, projectVersionId)
            SELECT userName, name, value, category, projectVersionId FROM usersessionstate;

DROP TABLE `usersessionstate`;

ALTER TABLE `usersessionstate_temp` RENAME `usersessionstate`;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', 'Change "value" column of usersessionstate table to a CLOB datatype', NOW(), 'Create Table, Custom SQL, Drop Table, Rename Table', 'EXECUTED', 'dbF360_17.10.xml', 'f360_17.10_16', '2.0.1', '3:852d01cc1429a88dcc4dc38a70d4dde4', 300);

-- Changeset dbF360_17.20.xml::f360_17.20_1::hp::(Checksum: 3:ccad8b7da2f894e8857e262e90cdc29f)
ALTER TABLE `parserpluginmetadata` ADD `supportedEngineVersions` VARCHAR(40);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Add Column', 'EXECUTED', 'dbF360_17.20.xml', 'f360_17.20_1', '2.0.1', '3:ccad8b7da2f894e8857e262e90cdc29f', 301);

-- Changeset dbF360_17.20.xml::f360_17.20_2::hp::(Checksum: 3:3eed908b0c45ff8c4b0e344afc4f9436)
ALTER TABLE `configproperty` MODIFY `propertyType` VARCHAR(25);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Modify data type', 'EXECUTED', 'dbF360_17.20.xml', 'f360_17.20_2', '2.0.1', '3:3eed908b0c45ff8c4b0e344afc4f9436', 302);

-- Changeset dbF360_17.20.xml::f360_17.20_3::hp::(Checksum: 3:c46f4b1b311d3725dbad2cef8204b3d0)
ALTER TABLE `parserpluginmetadata` RENAME `pluginmetadata`;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Rename Table', 'EXECUTED', 'dbF360_17.20.xml', 'f360_17.20_3', '2.0.1', '3:c46f4b1b311d3725dbad2cef8204b3d0', 303);

-- Changeset dbF360_17.20.xml::f360_17.20_4::hp::(Checksum: 3:ea65602560e9d97b70953d544b5db693)
ALTER TABLE `pluginmetadata` ADD `pluginType` VARCHAR(25);

UPDATE `pluginmetadata` SET `pluginType` = 'SCAN_PARSER';

ALTER TABLE `pluginmetadata` ADD `lastAction` VARCHAR(25);

ALTER TABLE `pluginmetadata` ADD `documentInfo_id` INT;

CREATE INDEX `IDX_PLUGINMETADATA_DOC_ID` ON `pluginmetadata`(`documentInfo_id`);

ALTER TABLE `pluginmetadata` ADD CONSTRAINT `RefDocInfoPluginMetaData` FOREIGN KEY (`documentInfo_id`) REFERENCES `documentinfo` (`id`) ON DELETE CASCADE;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Add Column, Create Index, Add Foreign Key Constraint', 'EXECUTED', 'dbF360_17.20.xml', 'f360_17.20_4', '2.0.1', '3:ea65602560e9d97b70953d544b5db693', 304);

-- Changeset dbF360_17.20.xml::f360_17.20_5::hp::(Checksum: 3:cdd2393957c24a6ede6328d365539233)
-- Table for info regarding data exported in CSV format by default. File with exported data is stored as a blob in datablob table.
CREATE TABLE `dataexport` (`id` BIGINT AUTO_INCREMENT  NOT NULL, `datasetName` VARCHAR(50) NOT NULL, `fileName` VARCHAR(255) NOT NULL, `fileType` VARCHAR(10) DEFAULT 'CSV', `note` VARCHAR(255), `exportDate` DATETIME NOT NULL, `userName` VARCHAR(255) NOT NULL, `status` VARCHAR(30) NOT NULL, `documentInfo_id` INT, `projectVersion_id` BIGINT, CONSTRAINT `PK_DATAEXPORT` PRIMARY KEY (`id`));

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', 'Table for info regarding data exported in CSV format by default. File with exported data is stored as a blob in datablob table.', NOW(), 'Create Table', 'EXECUTED', 'dbF360_17.20.xml', 'f360_17.20_5', '2.0.1', '3:cdd2393957c24a6ede6328d365539233', 305);

-- Changeset dbF360_17.20.xml::f360_17.20_6::hp::(Checksum: 3:955af029e88beb66ef6bf17ff26c3f07)
ALTER TABLE `pluginmetadata` MODIFY `engineType` VARCHAR(80) NULL;

ALTER TABLE `pluginmetadata` ADD `lastUsedOfKind` VARCHAR(1) DEFAULT 'N';

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Drop Not-Null Constraint, Add Column', 'EXECUTED', 'dbF360_17.20.xml', 'f360_17.20_6', '2.0.1', '3:955af029e88beb66ef6bf17ff26c3f07', 306);

-- Changeset dbF360_17.20.xml::f360_17.20_7::hp::(Checksum: 3:762d11179ba4ff814fb407d754d76727)
-- Switching issuemetadata identification from engine type + data version to meta data ID.
CREATE TABLE `issuemetadata_temp` (`id` BIGINT AUTO_INCREMENT  NOT NULL, `metadataId` BIGINT NOT NULL, `attribute_id` VARCHAR(50) NOT NULL, `attributeDataType` VARCHAR(30) NOT NULL, `dataColumnName` VARCHAR(32) NOT NULL, CONSTRAINT `PK_ISSUEMETADATA_TEMP` PRIMARY KEY (`id`, `metadataId`));

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', 'Switching issuemetadata identification from engine type + data version to meta data ID.', NOW(), 'Create Table', 'EXECUTED', 'dbF360_17.20.xml', 'f360_17.20_7', '2.0.1', '3:762d11179ba4ff814fb407d754d76727', 307);

-- Changeset dbF360_17.20.xml::f360_17.20_7_2::hp::(Checksum: 3:cb11728875301f1d7ec44e98f2055bf1)
INSERT INTO issuemetadata_temp (metadataId, attribute_id, attributeDataType, dataColumnName)
            SELECT (SELECT max(pm.id) FROM pluginmetadata pm where imt.engineType = pm.engineType and imt.dataVersion = pm.dataVersion) as metadataId,
                   imt.attribute_id,
                   imt.attributeDataType,
                   imt.dataColumnName
            FROM issuemetadata imt
            WHERE EXISTS (SELECT pm.id FROM pluginmetadata pm WHERE imt.engineType = pm.engineType and imt.dataVersion = pm.dataVersion);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Custom SQL', 'EXECUTED', 'dbF360_17.20.xml', 'f360_17.20_7_2', '2.0.1', '3:cb11728875301f1d7ec44e98f2055bf1', 308);

-- Changeset dbF360_17.20.xml::f360_17.20_7_3::hp::(Checksum: 3:b62ca4bd07343dba393ddc992cde8b82)
DROP TABLE `issuemetadata`;

ALTER TABLE `issuemetadata_temp` RENAME `issuemetadata`;

CREATE INDEX `ISSUE_META_DATA_MD_ID_IDX` ON `issuemetadata`(`metadataId`);

ALTER TABLE `issuemetadata` ADD CONSTRAINT `RefIssueMetadataPlugMetadata` FOREIGN KEY (`metadataId`) REFERENCES `pluginmetadata` (`id`) ON DELETE CASCADE;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Drop Table, Rename Table, Create Index, Add Foreign Key Constraint', 'EXECUTED', 'dbF360_17.20.xml', 'f360_17.20_7_3', '2.0.1', '3:b62ca4bd07343dba393ddc992cde8b82', 309);

-- Changeset dbF360_17.20.xml::f360_17.20_8::hp::(Checksum: 3:47c3641daacf7cc0456c40455ed4be6e)
-- in 17.10, there can only be one entry in pluginmetadata for each engine type
CREATE TABLE `issueviewtemplate_temp` (`id` INT AUTO_INCREMENT  NOT NULL, `metadataId` BIGINT NOT NULL, `templateData` MEDIUMBLOB, `objectVersion` INT NOT NULL, `description` VARCHAR(250), CONSTRAINT `PK_ISSUEVIEWTEMPLATE_TEMP` PRIMARY KEY (`id`, `metadataId`));

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', 'in 17.10, there can only be one entry in pluginmetadata for each engine type', NOW(), 'Create Table', 'EXECUTED', 'dbF360_17.20.xml', 'f360_17.20_8', '2.0.1', '3:47c3641daacf7cc0456c40455ed4be6e', 310);

-- Changeset dbF360_17.20.xml::f360_17.20_8_2::hp::(Checksum: 3:1d1a4732b55d75a090017384f4225fcd)
INSERT INTO issueviewtemplate_temp (metadataId, templateData, objectVersion, description)
            SELECT (SELECT max(pm.id) FROM pluginmetadata pm where ivt.engineType = pm.engineType and ivt.dataVersion = pm.dataVersion) as metadataId,
            ivt.templateData,
            ivt.objectVersion,
            ivt.description
            FROM issueviewtemplate ivt
            WHERE EXISTS (SELECT pm.id FROM pluginmetadata pm WHERE ivt.engineType = pm.engineType and ivt.dataVersion = pm.dataVersion);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Custom SQL', 'EXECUTED', 'dbF360_17.20.xml', 'f360_17.20_8_2', '2.0.1', '3:1d1a4732b55d75a090017384f4225fcd', 311);

-- Changeset dbF360_17.20.xml::f360_17.20_8_3::hp::(Checksum: 3:1d6df83ea229c05ee53553a907990d5a)
DROP TABLE `issueviewtemplate`;

ALTER TABLE `issueviewtemplate_temp` RENAME `issueviewtemplate`;

CREATE UNIQUE INDEX `ISSUE_VIEW_TPL_MD_ID_IDX` ON `issueviewtemplate`(`metadataId`);

ALTER TABLE `issueviewtemplate` ADD CONSTRAINT `RefIssueViewTplPlugMetadata` FOREIGN KEY (`metadataId`) REFERENCES `pluginmetadata` (`id`) ON DELETE CASCADE;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Drop Table, Rename Table, Create Index, Add Foreign Key Constraint', 'EXECUTED', 'dbF360_17.20.xml', 'f360_17.20_8_3', '2.0.1', '3:1d6df83ea229c05ee53553a907990d5a', 312);

-- Changeset dbF360_17.20.xml::f360_17.20_9::hp::(Checksum: 3:122359a50baddc6195e7bb3a80f4ec90)
-- Switching plugin image identification from plugin ID to meta data ID.
CREATE TABLE `pluginimage_temp` (`metadataId` BIGINT NOT NULL, `imageType` VARCHAR(16) NOT NULL, `imageData` MEDIUMBLOB, CONSTRAINT `PK_PLUGINIMAGE_TEMP` PRIMARY KEY (`metadataId`, `imageType`));

INSERT INTO pluginimage_temp (metadataId, imageType, imageData)
            SELECT (SELECT max(pm.id) FROM pluginmetadata pm where metadataPluginId = pm.pluginId) as metadataId,
                   pi.imageType, pi.imageData
            FROM pluginimage pi
            WHERE EXISTS (SELECT pm.id FROM pluginmetadata pm WHERE metadataPluginId = pm.pluginId);

DROP TABLE `pluginimage`;

ALTER TABLE `pluginimage_temp` RENAME `pluginimage`;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', 'Switching plugin image identification from plugin ID to meta data ID.', NOW(), 'Create Table, Custom SQL, Drop Table, Rename Table', 'EXECUTED', 'dbF360_17.20.xml', 'f360_17.20_9', '2.0.1', '3:122359a50baddc6195e7bb3a80f4ec90', 313);

-- Changeset dbF360_17.20.xml::f360_17.20_10::hp::(Checksum: 3:4887374bcb4cbe2981f14ccfe38151b5)
-- Store pluginID in scan table.
CREATE INDEX `PLUGINMETADATA_ET_ID_IDX` ON `pluginmetadata`(`engineType`, `pluginId`);

ALTER TABLE `scan` ADD `metadataPluginId` VARCHAR(80);

UPDATE scan SET metadataPluginId =
            (SELECT DISTINCT pluginId FROM pluginmetadata WHERE pluginType = 'SCAN_PARSER' AND engineType = scan.engineType)
            WHERE EXISTS (SELECT 1 from pluginmetadata WHERE engineType = scan.engineType);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', 'Store pluginID in scan table.', NOW(), 'Create Index, Add Column, Custom SQL', 'EXECUTED', 'dbF360_17.20.xml', 'f360_17.20_10', '2.0.1', '3:4887374bcb4cbe2981f14ccfe38151b5', 314);

-- Changeset dbF360_17.20.xml::f360_17.20_11::hp::(Checksum: 3:aafb7dc470e4bf5bdd9303babacd91c8)
-- Migrate scan_issue_ca table: store pluginID and add more column for attributes.
CREATE TABLE `scan_issue_ca_temp` (`projectVersion_id` BIGINT NOT NULL, `scan_id` BIGINT NOT NULL, `scan_issue_id` BIGINT NOT NULL, `metadataPluginId` VARCHAR(80) NOT NULL, `dataVersion` INT NOT NULL, `integerValue01` INT, `integerValue02` INT, `integerValue03` INT, `decimalValue01` decimal(18,9), `decimalValue02` decimal(18,9), `decimalValue03` decimal(18,9), `decimalValue04` decimal(18,9), `decimalValue05` decimal(18,9), `dateValue01` DATE, `dateValue02` DATE, `dateValue03` DATE, `dateValue04` DATE, `dateValue05` DATE, `textValue01` VARCHAR(800), `textValue02` VARCHAR(800), `textValue03` VARCHAR(800), `textValue04` VARCHAR(800), `textValue05` VARCHAR(800), `textValue06` VARCHAR(800), `textValue07` VARCHAR(800), `textValue08` VARCHAR(800), `textValue09` VARCHAR(800), `textValue10` VARCHAR(800), `textValue11` VARCHAR(800), `textValue12` VARCHAR(800), `textValue13` VARCHAR(800), `textValue14` VARCHAR(800), `textValue15` VARCHAR(800), `textValue16` VARCHAR(800), `clobValue01` MEDIUMTEXT, `clobValue02` MEDIUMTEXT, `clobValue03` MEDIUMTEXT, `clobValue04` MEDIUMTEXT, `clobValue05` MEDIUMTEXT, `clobValue06` MEDIUMTEXT, CONSTRAINT `PK_SCAN_ISSUE_CA_TEMP` PRIMARY KEY (`scan_issue_id`));

INSERT INTO scan_issue_ca_temp (projectVersion_id, scan_id, scan_issue_id, metadataPluginId, dataVersion,
                                            integerValue01, integerValue02, integerValue03,
                                            decimalValue01, decimalValue02, decimalValue03, decimalValue04, decimalValue05,
                                            dateValue01, dateValue02, dateValue03, dateValue04, dateValue05,
                                            textValue01, textValue02, textValue03, textValue04,
                                            textValue05, textValue06, textValue07, textValue08,
                                            textValue09, textValue10, textValue11, textValue12,
                                            clobValue01, clobValue02
            )
            SELECT sic.projectVersion_id,
                   sic.scan_id,
                   sic.scan_issue_id,
                   pmt.pluginId,
                   sic.dataVersion,
                   integerValue01, integerValue02, integerValue03,
                   decimalValue01, decimalValue02, decimalValue03, decimalValue04, decimalValue05,
                   dateValue01, dateValue02, dateValue03, dateValue04, dateValue05,
                   textValue01, textValue02, textValue03, textValue04,
                   textValue05, textValue06, textValue07, textValue08,
                   textValue09, textValue10, textValue11, textValue12,
                   clobValue01, clobValue02
            FROM scan_issue_ca sic, scan s
            LEFT JOIN (SELECT pmt.pluginId, pmt.engineType FROM pluginmetadata pmt WHERE pluginType = 'SCAN_PARSER' GROUP BY pmt.pluginId, pmt.engineType) pmt ON s.engineType = pmt.engineType
            WHERE sic.scan_id = s.id;

DROP TABLE `scan_issue_ca`;

ALTER TABLE `scan_issue_ca_temp` RENAME `scan_issue_ca`;

CREATE INDEX `SCAN_ISSUE_CA_PV_SCAN_ID_IDX` ON `scan_issue_ca`(`projectVersion_id`, `scan_id`, `scan_issue_id`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', 'Migrate scan_issue_ca table: store pluginID and add more column for attributes.', NOW(), 'Create Table, Custom SQL, Drop Table, Rename Table, Create Index', 'EXECUTED', 'dbF360_17.20.xml', 'f360_17.20_11', '2.0.1', '3:aafb7dc470e4bf5bdd9303babacd91c8', 315);

-- Changeset dbF360_17.20.xml::f360_17.20_12::hp::(Checksum: 3:0b288d1aaea00f092c4820ea73398f2b)
-- Migrate issue_ca table: store pluginID and add more column for attributes.
CREATE TABLE `issue_ca_temp` (`issue_id` BIGINT NOT NULL, `projectVersion_id` BIGINT NOT NULL, `issueInstanceId` VARCHAR(80) NOT NULL, `engineType` VARCHAR(20) NOT NULL, `metadataPluginId` VARCHAR(80) NOT NULL, `dataVersion` INT NOT NULL, `integerValue01` INT, `integerValue02` INT, `integerValue03` INT, `decimalValue01` decimal(18,9), `decimalValue02` decimal(18,9), `decimalValue03` decimal(18,9), `decimalValue04` decimal(18,9), `decimalValue05` decimal(18,9), `dateValue01` DATE, `dateValue02` DATE, `dateValue03` DATE, `dateValue04` DATE, `dateValue05` DATE, `textValue01` VARCHAR(800), `textValue02` VARCHAR(800), `textValue03` VARCHAR(800), `textValue04` VARCHAR(800), `textValue05` VARCHAR(800), `textValue06` VARCHAR(800), `textValue07` VARCHAR(800), `textValue08` VARCHAR(800), `textValue09` VARCHAR(800), `textValue10` VARCHAR(800), `textValue11` VARCHAR(800), `textValue12` VARCHAR(800), `textValue13` VARCHAR(800), `textValue14` VARCHAR(800), `textValue15` VARCHAR(800), `textValue16` VARCHAR(800), `clobValue01` MEDIUMTEXT, `clobValue02` MEDIUMTEXT, `clobValue03` MEDIUMTEXT, `clobValue04` MEDIUMTEXT, `clobValue05` MEDIUMTEXT, `clobValue06` MEDIUMTEXT, CONSTRAINT `PK_ISSUE_CA_TEMP` PRIMARY KEY (`issue_id`));

INSERT INTO issue_ca_temp (issue_id, projectVersion_id, issueInstanceId, engineType, metadataPluginId, dataVersion,
                                       integerValue01, integerValue02, integerValue03,
                                       decimalValue01, decimalValue02, decimalValue03, decimalValue04, decimalValue05,
                                       dateValue01, dateValue02, dateValue03, dateValue04, dateValue05,
                                       textValue01, textValue02, textValue03, textValue04,
                                       textValue05, textValue06, textValue07, textValue08,
                                       textValue09, textValue10, textValue11, textValue12,
                                       clobValue01, clobValue02
            )
            SELECT ic.issue_id,
                   ic.projectVersion_id,
                   ic.issueInstanceId,
                   ic.engineType,
                   pmt.pluginId,
                   ic.dataVersion,
                   integerValue01, integerValue02, integerValue03,
                   decimalValue01, decimalValue02, decimalValue03, decimalValue04, decimalValue05,
                   dateValue01, dateValue02, dateValue03, dateValue04, dateValue05,
                   textValue01, textValue02, textValue03, textValue04,
                   textValue05, textValue06, textValue07, textValue08,
                   textValue09, textValue10, textValue11, textValue12,
                   clobValue01, clobValue02
            FROM issue_ca ic
            LEFT JOIN (SELECT pmt.pluginId, pmt.engineType FROM pluginmetadata pmt WHERE pluginType = 'SCAN_PARSER' GROUP BY pmt.pluginId, pmt.engineType) pmt ON ic.engineType = pmt.engineType;

DROP TABLE `issue_ca`;

ALTER TABLE `issue_ca_temp` RENAME `issue_ca`;

CREATE INDEX `ISSUE_ATTR_PV_ISSUE_ID_IDX` ON `issue_ca`(`projectVersion_id`, `issue_id`);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', 'Migrate issue_ca table: store pluginID and add more column for attributes.', NOW(), 'Create Table, Custom SQL, Drop Table, Rename Table, Create Index', 'EXECUTED', 'dbF360_17.20.xml', 'f360_17.20_12', '2.0.1', '3:0b288d1aaea00f092c4820ea73398f2b', 316);

-- Changeset dbF360_17.20.xml::f360_17.20_13::hp::(Checksum: 3:04b91e7572c468502e8074916a2920db)
ALTER TABLE `pluginmetadata` MODIFY `pluginName` VARCHAR(80);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Modify data type', 'EXECUTED', 'dbF360_17.20.xml', 'f360_17.20_13', '2.0.1', '3:04b91e7572c468502e8074916a2920db', 317);

-- Changeset dbF360_17.20.xml::f360_17.20_14::hp::(Checksum: 3:32a77adb32098605b2aeaa69030ec16e)
ALTER TABLE `bugfieldtemplategroup` DROP KEY `UK_BugfieldTemplateGroupName`;

ALTER TABLE `bugfieldtemplategroup` DROP COLUMN `name`;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Drop Unique Constraint, Drop Column', 'EXECUTED', 'dbF360_17.20.xml', 'f360_17.20_14', '2.0.1', '3:32a77adb32098605b2aeaa69030ec16e', 318);

-- Changeset dbF360_17.20.xml::f360_17.20_15::hp::(Checksum: 3:5cdb5f734f2819f82360cefb1218859f)
ALTER TABLE `folder` ADD `orderIndex` INT;

UPDATE `projectversion` SET `staleProjectTemplate` = 'Y';

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Add Column, Update Data', 'EXECUTED', 'dbF360_17.20.xml', 'f360_17.20_15', '2.0.1', '3:5cdb5f734f2819f82360cefb1218859f', 319);

-- Changeset dbF360_17.20.xml::f360_17.20_16::hp::(Checksum: 3:cc9e147f8796887a3f670988562de4a2)
DELETE FROM `pluginimage`;

DELETE FROM `pluginconfiguration`;

DELETE FROM `pluginlocalization`;

DELETE FROM `issueviewtemplate`;

DELETE FROM `pluginmetadata`;

DELETE FROM `issuemetadata`;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Delete Data (x6)', 'EXECUTED', 'dbF360_17.20.xml', 'f360_17.20_16', '2.0.1', '3:cc9e147f8796887a3f670988562de4a2', 320);

-- Changeset views/dbF360_baseissueview.xml::baseissueview::hp::(Checksum: 3:013c957c3b1be591359d31a84e93e1d0)
DROP VIEW `baseissueview`;

CREATE VIEW `baseissueview` AS SELECT
                i.id,
                i.folder_id,
                i.issueInstanceId,
                i.fileName,
                i.shortFileName,
                i.severity,
                i.ruleGuid,
                i.confidence,
                i.kingdom,
                i.issueType,
                i.issueSubtype,
                i.analyzer,
                i.lineNumber,
                i.taintFlag,
                i.packageName,
                i.functionName,
                i.className,
                i.issueAbstract,
                i.issueRecommendation,
                i.friority,
                i.engineType,
                i.scanStatus,
                i.audienceSet,
                i.lastScan_id,
                i.replaceStore,
                i.snippetId,
                i.url,
                i.category,
                i.source,
                i.sourceContext,
                i.sourceFile,
                i.sink,
                i.sinkContext,
                i.userName,
                i.revision,
                i.audited,
                i.auditedTime,
                i.suppressed,
                i.findingGuid,
                i.issueStatus,
                i.issueState,
                i.dynamicConfidence,
                i.minVirtualCallConfidence,
                i.remediationConstant,
                i.projectVersion_id,
                i.hidden,
                i.likelihood,
                i.impact,
                i.accuracy,
                i.rtaCovered,
                i.probability,
                i.foundDate,
                i.removedDate,
                i.requestHeader,
                i.requestParameter,
                i.requestBody,
                i.attackPayload,
                i.attackType,
                i.response,
                i.triggerDefinition,
                i.triggerString,
                i.triggerDisplayText,
                i.secondaryRequest,
                i.sourceLine,
                i.requestMethod,
                i.httpVersion,
                i.cookie,
                i.mappedCategory,
                i.correlated,
                i.correlationSetGuid,
                i.attackTriggerDefinition,
                i.vulnerableParameter,
                i.reproStepDefinition,
                i.stackTrace,
                i.stackTraceTriggerDisplayText,
                i.bug_id,
                i.manual
            FROM issue i;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Drop View, Create View', 'EXECUTED', 'views/dbF360_baseissueview.xml', 'baseissueview', '2.0.1', '3:013c957c3b1be591359d31a84e93e1d0', 321);

-- Changeset views/dbF360_defaultissueview_standards.xml::defaultissueview_standards::hp::(Checksum: 3:b3cf3bd1c25b08027b80f9a90db7a3cd)
DROP VIEW `view_standards`;

DROP VIEW `defaultissueview`;

CREATE VIEW `defaultissueview` AS SELECT
                i.id,
                i.folder_id,
                i.issueInstanceId,
                i.fileName,
                i.shortFileName,
                i.severity,
                i.ruleGuid,
                i.confidence,
                i.kingdom,
                i.issueType,
                i.issueSubtype,
                i.analyzer,
                i.lineNumber,
                i.taintFlag,
                i.packageName,
                i.functionName,
                i.className,
                i.issueAbstract,
                i.issueRecommendation,
                i.friority,
                i.engineType,
                i.scanStatus,
                i.audienceSet,
                i.lastScan_id,
                i.replaceStore,
                i.snippetId,
                i.url,
                i.category,
                i.source,
                i.sourceContext,
                i.sourceFile,
                i.sink,
                i.sinkContext,
                i.userName,
                i.revision,
                i.audited,
                i.auditedTime,
                i.suppressed,
                i.findingGuid,
                i.issueStatus,
                i.issueState,
                i.dynamicConfidence,
                i.minVirtualCallConfidence,
                i.remediationConstant,
                i.projectVersion_id,
                i.hidden,
                i.likelihood,
                i.impact,
                i.accuracy,
                i.rtaCovered,
                i.probability,
                i.foundDate,
                i.removedDate,
                i.requestHeader,
                i.requestParameter,
                i.requestBody,
                i.attackPayload,
                i.attackType,
                i.response,
                i.triggerDefinition,
                i.triggerString,
                i.triggerDisplayText,
                i.secondaryRequest,
                i.sourceLine,
                i.requestMethod,
                i.httpVersion,
                i.cookie,
                i.mappedCategory,
                i.correlated,
                i.attackTriggerDefinition,
                i.vulnerableParameter,
                i.reproStepDefinition,
                i.stackTrace,
                i.stackTraceTriggerDisplayText,
                i.bug_id,
                i.manual,
                getExternalCategories(i.mappedCategory, '771C470C-9274-4580-8556-C023E4D3ADB4') AS owasp2004,
                getExternalCategories(i.mappedCategory, '1EB1EC0E-74E6-49A0-BCE5-E6603802987A') AS owasp2007,
                getExternalCategories(i.mappedCategory, 'FDCECA5E-C2A8-4BE8-BB26-76A8ECD0ED59') AS owasp2010,
                getExternalCategories(i.mappedCategory, '3ADB9EE4-5761-4289-8BD3-CBFCC593EBBC') AS cwe,
                getExternalCategories(i.mappedCategory, '939EF193-507A-44E2-ABB7-C00B2168B6D8') AS sans25,
                getExternalCategories(i.mappedCategory, '72688795-4F7B-484C-88A6-D4757A6121CA') AS sans2010,
                getExternalCategories(i.mappedCategory, '9DC61E7F-1A48-4711-BBFD-E9DFF537871F') AS wasc,
                getExternalCategories(i.mappedCategory, 'F2FA57EA-5AAA-4DDE-90A5-480BE65CE7E7') AS stig,
                getExternalCategories(i.mappedCategory, '58E2C21D-C70F-4314-8994-B859E24CF855') AS stig34,
                getExternalCategories(i.mappedCategory, 'CBDB9D4D-FC20-4C04-AD58-575901CAB531') AS pci11,
                getExternalCategories(i.mappedCategory, '57940BDB-99F0-48BF-BF2E-CFC42BA035E5') AS pci12,
                getExternalCategories(i.mappedCategory, '8970556D-7F9F-4EA7-8033-9DF39D68FF3E') AS pci20,
                getExternalCategories(i.mappedCategory, 'B40F9EE0-3824-4879-B9FE-7A789C89307C') AS fisma
            FROM issue i;

CREATE VIEW `view_standards` AS SELECT
                i.folder_id,
                i.id,
                i.issueInstanceId,
                i.fileName,
                i.shortFileName,
                i.severity,
                i.ruleGuid,
                i.confidence,
                i.kingdom,
                i.issueType,
                i.issueSubtype,
                i.analyzer,
                i.lineNumber,
                i.taintFlag,
                i.packageName,
                i.functionName,
                i.className,
                i.issueAbstract,
                i.issueRecommendation,
                i.friority,
                i.engineType,
                i.scanStatus,
                i.audienceSet,
                i.lastScan_id,
                i.replaceStore,
                i.snippetId,
                i.url,
                i.category,
                i.source,
                i.sourceContext,
                i.sourceFile,
                i.sink,
                i.sinkContext,
                i.userName,
                i.owasp2004,
                i.owasp2007,
                i.cwe,
                i.revision,
                i.audited,
                i.auditedTime,
                i.suppressed,
                i.findingGuid,
                i.issueStatus,
                i.issueState,
                i.dynamicConfidence,
                i.minVirtualCallConfidence,
                i.remediationConstant,
                i.projectVersion_id,
                i.hidden,
                i.likelihood,
                i.impact,
                i.accuracy,
                i.wasc,
                i.sans25 AS sans2009,
                i.stig,
                i.pci11,
                i.pci12,
                i.rtaCovered,
                i.probability,
                i.foundDate,
                i.removedDate,
                i.requestHeader,
                i.requestParameter,
                i.requestBody,
                i.attackPayload,
                i.attackType,
                i.attackTriggerDefinition,
                i.response,
                i.triggerDefinition,
                i.triggerString,
                i.triggerDisplayText,
                i.secondaryRequest,
                i.sourceLine,
                i.requestMethod,
                i.httpVersion,
                i.cookie,
                i.mappedCategory,
                i.owasp2010,
                i.fisma AS fips200,
                i.sans2010,
                i.correlated,
                i.pci20,
                i.vulnerableParameter,
                i.reproStepDefinition,
                i.stackTrace,
                i.stackTraceTriggerDisplayText
            FROM defaultissueview i
            WHERE i.hidden='N'
                AND i.suppressed='N'
                AND i.scanStatus <> 'REMOVED'
                AND (
                    (i.owasp2010 IS NOT NULL and upper(i.owasp2010) <> 'NONE')
                    OR (i.fisma IS NOT NULL AND upper(i.fisma) <> 'NONE')
                    OR (i.sans25 IS NOT NULL AND upper(i.sans25) <> 'NONE')
                    OR (i.sans2010 IS NOT NULL AND upper(i.sans2010) <> 'NONE')
                    OR (i.pci20 IS NOT NULL AND upper(i.pci20) <> 'NONE')
                );

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Drop View (x2), Create View (x2)', 'EXECUTED', 'views/dbF360_defaultissueview_standards.xml', 'defaultissueview_standards', '2.0.1', '3:b3cf3bd1c25b08027b80f9a90db7a3cd', 322);

-- Changeset views/dbF360_measurementAgentInUseView.xml::measurementAgentInUseViewCreate::hp::(Checksum: 3:89b253a9112d08670456f8e6225cef53)
CREATE VIEW `measurementAgentInUseView` AS select monitoredInstanceId as measurement_id
            from alert
            where monitoredEntityType = 'MEASUREMENT_AGENT'
            union all
            select psa.measurement_id
            from projectstateactivity psa;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Create View', 'EXECUTED', 'views/dbF360_measurementAgentInUseView.xml', 'measurementAgentInUseViewCreate', '2.0.1', '3:89b253a9112d08670456f8e6225cef53', 323);

-- Changeset views/dbF360_variableInUseView.xml::variableInUseViewCreate::hp::(Checksum: 3:1456e7bfdf552fe95554d4b5ac7198e2)
CREATE VIEW `variableInUseView` AS select variable_id
            from measurement_variable
            union all
            select monitoredInstanceId as variable_id
            from alert
            where monitoredEntityType = 'VARIABLE';

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Create View', 'EXECUTED', 'views/dbF360_variableInUseView.xml', 'variableInUseViewCreate', '2.0.1', '3:1456e7bfdf552fe95554d4b5ac7198e2', 324);

-- Changeset views/dbF360_metadefview.xml::metadefview::hp::(Checksum: 3:a428f4eb64aa27313b7523720a5ba16b)
DROP VIEW `metadefview`;

CREATE VIEW `metadefview` AS SELECT def.id id, def.metaType metaType, def.seqNumber seqNumber, def.required required, def.category category,
 			    def.hidden hidden, def.booleanDefault booleanDefault, def.guid guid, def.parent_id parent_id,
 			    def.systemUsage systemUsage, t.name name, t.description description, t.help help, t.lang lang,
 			    def.parentOption_id, def.appEntityType, def.objectVersion, def.publishVersion
			FROM metadef def, metadef_t t
			WHERE def.id =  t.metaDef_id  AND t.metaDef_id = def.id;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Drop View, Create View', 'EXECUTED', 'views/dbF360_metadefview.xml', 'metadefview', '2.0.1', '3:a428f4eb64aa27313b7523720a5ba16b', 325);

-- Changeset views/dbF360_externalcatorderview.xml::externalcatorderview::hp::(Checksum: 3:a8cf4a477b0121c7a40c575e2576f998)
CREATE VIEW `externalCatOrderView` AS select cl.mappedCategory, cec.catPackExternalList_id, max(cl.orderingInfo) as orderingInfo
            from catpacklookup cl, catpackexternalcategory cec
            where cl.catPackExternalCategory_id = cec.id
            group by cl.mappedCategory, cec.catPackExternalList_id;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Create View', 'EXECUTED', 'views/dbF360_externalcatorderview.xml', 'externalcatorderview', '2.0.1', '3:a8cf4a477b0121c7a40c575e2576f998', 326);

-- Changeset views/dbF360_auditvalueview.xml::auditvalueview::hp::(Checksum: 3:85dc5004a8e302f1c42a8cfddce0c96a)
DROP VIEW `auditvalueview`;

CREATE VIEW `auditvalueview` AS SELECT a.projectVersion_id,
                   a.issue_id,
                   a.attrGuid,
                   a.attrValue lookupIndex,
                   l.lookupValue,
				   a.decimalValue,
				   a.dateValue,
				   a.textValue,
                   attr.attrName,
                   attr.defaultValue,
                   attr.hidden,
                   attr.valueType,
                   l.seqNumber,
                   attr.restriction
            from auditvalue a
			join attr on a.attrGuid = attr.guid
            left join attrlookup l on attr.id = l.attr_id and l.lookupIndex = a.attrValue;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Drop View, Create View', 'EXECUTED', 'views/dbF360_auditvalueview.xml', 'auditvalueview', '2.0.1', '3:85dc5004a8e302f1c42a8cfddce0c96a', 327);

-- Changeset views/dbF360_attrLookupInUseView.xml::attrLookupInUseView_mysql::hp::(Checksum: 3:b0086dbfbf8426bda5005741a2866b07)
CREATE VIEW `attrlookupinuseview` AS select attr_id, lookupIndex
            from attrlookup al
            where exists (select 1 from auditvalue av where av.attrValue = al.lookupIndex and av.attrGuid = al.attrGuid LIMIT 0, 1);

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Create View', 'EXECUTED', 'views/dbF360_attrLookupInUseView.xml', 'attrLookupInUseView_mysql', '2.0.1', '3:b0086dbfbf8426bda5005741a2866b07', 328);

-- Changeset procs/dbF360_updateScanIssueIds.xml::updateScanIssueIds_mysql::hp_main::(Checksum: 3:adadfed5acd6d484bbd8f4f97c381124)
DROP PROCEDURE IF EXISTS updateScanIssueIds;

DELIMITER //
CREATE PROCEDURE updateScanIssueIds	(p_scan_id INT,
	 p_projectVersion_id INT,
	 p_engineType varchar(20)
	)
BEGIN
	UPDATE scan_issue si, issue
	SET si.issue_id=issue.id
	WHERE issue.projectVersion_id = p_projectVersion_id
	  AND issue.engineType = si.engineType
	  AND si.issueInstanceId = issue.issueInstanceId
	  AND si.scan_id = p_scan_id
	  AND si.issue_id IS NULL;
END//
DELIMITER ;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Custom SQL (x2)', 'EXECUTED', 'procs/dbF360_updateScanIssueIds.xml', 'updateScanIssueIds_mysql', '2.0.1', '3:adadfed5acd6d484bbd8f4f97c381124', 329);

-- Changeset procs/dbF360_updateIssuesFromFilterSet.xml::updateIssuesFromFilterSet_mysql::hp_main::(Checksum: 3:895219144944570a661cad4a152175ca)
DROP PROCEDURE IF EXISTS updateIssuesFromFilterSet;

DELIMITER //
CREATE PROCEDURE updateIssuesFromFilterSet (		p_projectVersion_id INT,
		p_filterSet_id INT
	)
BEGIN
	UPDATE issue i, issuecache ic
	SET i.hidden = ic.hidden, i.folder_id = ic.folder_id
	WHERE i.projectVersion_id = p_projectVersion_id
		AND ic.projectVersion_id = p_projectVersion_id
		AND ic.filterSet_id = p_filterSet_id
		AND ic.issue_id = i.id
		AND (i.hidden <> ic.hidden OR i.folder_id IS NULL OR i.folder_id <> ic.folder_id);
END//
DELIMITER ;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Custom SQL (x2)', 'EXECUTED', 'procs/dbF360_updateIssuesFromFilterSet.xml', 'updateIssuesFromFilterSet_mysql', '2.0.1', '3:895219144944570a661cad4a152175ca', 330);

-- Changeset procs/dbF360_updateExistingWithLatest.xml::updateExistingWithLatest_mysql::hp_main::(Checksum: 3:4b4dad7b9fd5a7156473cdfd57147480)
DROP PROCEDURE IF EXISTS updateExistingWithLatest;

DELIMITER //
CREATE PROCEDURE updateExistingWithLatest    (p_scan_id INT,
     p_projectVersion_id INT,
     p_foundDate BIGINT,
     p_folder_id INT
    )
BEGIN
    insert into issue (lastScan_Id, scanStatus, issueInstanceId, projectVersion_Id, engineType 
        , foundDate, shortFileName, fileName, severity, confidence, kingdom
        , issueType, issueSubtype, analyzer, lineNumber, taintFlag, packageName
        , functionName, className, issueAbstract, issueRecommendation, friority
        , replaceStore, ruleGuid, findingGuid, snippetId, contextId, category
        , url, source, sourceContext, sink, sinkContext, sourceFile
        , audienceSet, remediationConstant, likelihood, probability, impact
        , accuracy, rtaCovered, requestIdentifier, requestHeader, requestParameter
        , requestBody, requestMethod, cookie, httpVersion, attackPayload, attackType
        , attackTriggerDefinition , response, triggerDefinition, triggerString
        , triggerDisplayText, secondaryRequest, sourceLine, mappedCategory
        , vulnerableParameter, reproStepDefinition, stackTrace, stackTraceTriggerDisplayText
        , manual, minVirtualCallConfidence, hidden, folder_Id, objectVersion)
	select scan_Id, 'NEW', issueInstanceId, projectVersion_Id, engineType, p_foundDate
        , shortFileName, fileName, severity, confidence, kingdom, issueType, issueSubtype
        , analyzer, lineNumber, taintFlag, packageName, functionName, className, issueAbstract
        , issueRecommendation, friority, replaceStore, ruleGuid, findingGuid, snippetId, contextId
        , category, url, source, sourceContext, sink, sinkContext, sourceFile, audienceSet
        , remediationConstant, likelihood, probability, impact, accuracy, rtaCovered
        , requestIdentifier, requestHeader, requestParameter, requestBody, requestMethod, cookie
        , httpVersion, attackPayload, attackType, attackTriggerDefinition, response
        , triggerDefinition, triggerString, triggerDisplayText, secondaryRequest, sourceLine
        , mappedCategory, vulnerableParameter, reproStepDefinition, stackTrace
        , stackTraceTriggerDisplayText, manual, minVirtualCallConfidence, 'N', p_folder_id, 0 from scan_issue si where si.projectVersion_id = p_projectVersion_id and si.scan_id = p_scan_id
	 on duplicate key update issue.lastScan_Id= si.scan_id
        , issue.shortFileName=si.shortFileName, issue.fileName=si.fileName, issue.severity=si.severity, issue.confidence=si.confidence, issue.kingdom=si.kingdom, issue.issueType=si.issueType
        , issue.issueSubtype=si.issueSubtype, issue.analyzer=si.analyzer, issue.engineType=si.engineType, issue.lineNumber=si.lineNumber, issue.taintFlag=si.taintFlag, issue.packageName=si.packageName
        , issue.functionName=si.functionName, issue.className=si.className, issue.issueAbstract=si.issueAbstract, issue.issueRecommendation=si.issueRecommendation, issue.friority=si.friority, issue.replaceStore=si.replaceStore
        , issue.ruleGuid=si.ruleGuid, issue.snippetId=si.snippetId, issue.contextId=si.contextId, issue.category=si.category, issue.url=si.url, issue.source=si.source, issue.sourceContext=si.sourceContext, issue.sink=si.sink
        , issue.sinkContext=si.sinkContext, issue.sourceFile=si.sourceFile, issue.audienceSet=si.audienceSet
        , issue.scanStatus = (CASE WHEN issue.scanStatus='REMOVED' THEN 'REINTRODUCED' ELSE 'UPDATED' END)
        , issue.findingGuid = si.findingGuid, issue.remediationConstant=si.remediationConstant,issue.likelihood=si.likelihood,issue.impact=si.impact, issue.accuracy=si.accuracy
        , issue.rtaCovered=si.rtaCovered,issue.probability=si.probability
        , issue.requestIdentifier=si.requestIdentifier, issue.requestHeader=si.requestHeader, issue.requestParameter=si.requestParameter, issue.requestBody=si.requestBody, issue.requestMethod=si.requestMethod
        , issue.cookie=si.cookie, issue.httpVersion=si.httpVersion, issue.attackPayload=si.attackPayload, issue.attackType=si.attackType, issue.response=si.response, issue.triggerDefinition=si.triggerDefinition, issue.triggerString=si.triggerString
        , issue.triggerDisplayText=si.triggerDisplayText, issue.secondaryRequest=si.secondaryRequest, issue.sourceLine=si.sourceLine, issue.mappedCategory=si.mappedCategory
        , issue.minVirtualCallConfidence=si.minVirtualCallConfidence;

    insert into issue_ca (issue_id, projectVersion_id, issueInstanceId, engineType, dataVersion, metadataPluginId,
			integerValue01, integerValue02, integerValue03, decimalValue01, decimalValue02, decimalValue03, decimalValue04, decimalValue05,
			dateValue01, dateValue02, dateValue03, dateValue04, dateValue05,
			textValue01, textValue02, textValue03, textValue04, textValue05, textValue06, textValue07, textValue08, textValue09, textValue10, textValue11, textValue12, textValue13, textValue14, textValue15, textValue16,
			clobValue01, clobValue02, clobValue03, clobValue04, clobValue05, clobValue06)
	select i.id, sica.projectVersion_id, si.issueInstanceId, si.engineType, sica.dataVersion, sica.metadataPluginId,
			sica.integerValue01, sica.integerValue02, sica.integerValue03, sica.decimalValue01, sica.decimalValue02, sica.decimalValue03, sica.decimalValue04, sica.decimalValue05,
			sica.dateValue01, sica.dateValue02, sica.dateValue03, sica.dateValue04, sica.dateValue05,
			sica.textValue01, sica.textValue02, sica.textValue03, sica.textValue04, sica.textValue05, sica.textValue06, sica.textValue07, sica.textValue08, sica.textValue09, sica.textValue10, sica.textValue11, sica.textValue12, sica.textValue13, sica.textValue14, sica.textValue15, sica.textValue16,
			sica.clobValue01, sica.clobValue02, sica.clobValue03, sica.clobValue04, sica.clobValue05, sica.clobValue06
	    from scan_issue_ca sica join scan_issue si ON sica.scan_issue_id=si.id join issue i ON i.engineType=si.engineType AND i.issueInstanceId=si.issueInstanceId where sica.scan_id = p_scan_id AND sica.projectVersion_id = p_projectVersion_id AND i.projectVersion_id=p_projectVersion_id
	on duplicate key update issue_ca.issueInstanceId=si.issueInstanceId, issue_ca.engineType=si.engineType, issue_ca.dataVersion=sica.dataVersion,
			issue_ca.integerValue01=sica.integerValue01, issue_ca.integerValue02=sica.integerValue02, issue_ca.integerValue03=sica.integerValue03, issue_ca.decimalValue01=sica.decimalValue01, issue_ca.decimalValue02=sica.decimalValue02, issue_ca.decimalValue03=sica.decimalValue03, issue_ca.decimalValue04=sica.decimalValue04, issue_ca.decimalValue05=sica.decimalValue05,
			issue_ca.dateValue01=sica.dateValue01, issue_ca.dateValue02=sica.dateValue02, issue_ca.dateValue03=sica.dateValue03, issue_ca.dateValue04=sica.dateValue04, issue_ca.dateValue05=sica.dateValue05,
			issue_ca.textValue01=sica.textValue01, issue_ca.textValue02=sica.textValue02, issue_ca.textValue03=sica.textValue03, issue_ca.textValue04=sica.textValue04, issue_ca.textValue05=sica.textValue05, issue_ca.textValue06=sica.textValue06, issue_ca.textValue07=sica.textValue07, issue_ca.textValue08=sica.textValue08, issue_ca.textValue09=sica.textValue09, issue_ca.textValue10=sica.textValue10,
			issue_ca.textValue11=sica.textValue11, issue_ca.textValue12=sica.textValue12, issue_ca.textValue13=sica.textValue13, issue_ca.textValue14=sica.textValue14, issue_ca.textValue15=sica.textValue15, issue_ca.textValue16=sica.textValue16,
			issue_ca.clobValue01=sica.clobValue01, issue_ca.clobValue02=sica.clobValue02, issue_ca.clobValue03=sica.clobValue03, issue_ca.clobValue04=sica.clobValue04, issue_ca.clobValue05=sica.clobValue05, issue_ca.clobValue06=sica.clobValue06;

    delete ica from issue_ca ica
        where ica.projectVersion_id = p_projectVersion_id AND EXISTS (SELECT 1 from scan_issue si WHERE si.projectVersion_id=p_projectVersion_id AND si.scan_id = p_scan_id AND si.engineType=ica.engineType AND si.issueInstanceId=ica.issueInstanceId AND NOT EXISTS (SELECT 1 FROM scan_issue_ca WHERE scan_issue_id = si.id));
END//
DELIMITER ;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Custom SQL (x2)', 'EXECUTED', 'procs/dbF360_updateExistingWithLatest.xml', 'updateExistingWithLatest_mysql', '2.0.1', '3:4b4dad7b9fd5a7156473cdfd57147480', 331);

-- Changeset procs/dbF360_updateDeletedIssues.xml::updateDeletedIssues_mysql::hp::(Checksum: 3:950c9661a45955b00676b087a0d9440c)
DROP PROCEDURE IF EXISTS updateDeletedIssues;

DELIMITER //
CREATE PROCEDURE updateDeletedIssues    (p_scan_id INT,
     p_previous_scan_id INT,
     p_projectVersion_id INT
    )
BEGIN
    UPDATE issue issue, scan_issue si, issue_ca ica, scan_issue_ca sica
    SET ica.engineType=si.engineType, ica.dataVersion=sica.dataVersion, ica.metadataPluginId=sica.metadataPluginId,
	    ica.integerValue01 = sica.integerValue01, ica.integerValue02 = sica.integerValue02, ica.integerValue03 = sica.integerValue03,
	    ica.decimalValue01 = sica.decimalValue01, ica.decimalValue02 = sica.decimalValue02, ica.decimalValue03 = sica.decimalValue03, ica.decimalValue04 = sica.decimalValue04, ica.decimalValue05 = sica.decimalValue05,
	    ica.dateValue01 = sica.dateValue01, ica.dateValue02 = sica.dateValue02, ica.dateValue03 = sica.dateValue03, ica.dateValue04 = sica.dateValue04, ica.dateValue05 = sica.dateValue05,
	    ica.textValue01 = sica.textValue01, ica.textValue02 = sica.textValue02, ica.textValue03 = sica.textValue03, ica.textValue04 = sica.textValue04, ica.textValue05 = sica.textValue05,
	    ica.textValue06 = sica.textValue06, ica.textValue07 = sica.textValue07, ica.textValue08 = sica.textValue08, ica.textValue09 = sica.textValue09, ica.textValue10 = sica.textValue10,
	    ica.textValue11 = sica.textValue11, ica.textValue12 = sica.textValue12, ica.textValue13 = sica.textValue13, ica.textValue14 = sica.textValue14, ica.textValue15 = sica.textValue15, ica.textValue16 = sica.textValue16,
	    ica.clobValue01 = sica.clobValue01, ica.clobValue02 = sica.clobValue02, ica.clobValue03 = sica.clobValue03, ica.clobValue04 = sica.clobValue04, ica.clobValue05 = sica.clobValue05, ica.clobValue06 = sica.clobValue06
    WHERE issue.projectVersion_id = p_projectVersion_id
        AND issue.lastScan_id = p_scan_id
        AND si.issue_id = issue.id
        AND si.scan_id = p_previous_scan_id
        AND ica.issue_id = issue.id
        AND sica.scan_issue_id = si.id;

    INSERT into issue_ca (issue_id, projectVersion_id, issueInstanceId, engineType, dataVersion, metadataPluginId,
			integerValue01, integerValue02, integerValue03, decimalValue01, decimalValue02, decimalValue03, decimalValue04, decimalValue05,
			dateValue01, dateValue02, dateValue03, dateValue04, dateValue05,
			textValue01, textValue02, textValue03, textValue04, textValue05, textValue06, textValue07, textValue08, textValue09, textValue10, textValue11, textValue12, textValue13, textValue14, textValue15, textValue16,
			clobValue01, clobValue02, clobValue03, clobValue04, clobValue05, clobValue06)
	    SELECT i.id, sica.projectVersion_id, si.issueInstanceId, si.engineType, sica.dataVersion, sica.metadataPluginId,
			sica.integerValue01, sica.integerValue02, sica.integerValue03, sica.decimalValue01, sica.decimalValue02, sica.decimalValue03, sica.decimalValue04, sica.decimalValue05,
			sica.dateValue01, sica.dateValue02, sica.dateValue03, sica.dateValue04, sica.dateValue05,
			sica.textValue01, sica.textValue02, sica.textValue03, sica.textValue04, sica.textValue05, sica.textValue06, sica.textValue07, sica.textValue08, sica.textValue09, sica.textValue10, sica.textValue11, sica.textValue12, sica.textValue13, sica.textValue14, sica.textValue15, sica.textValue16,
			sica.clobValue01, sica.clobValue02, sica.clobValue03, sica.clobValue04, sica.clobValue05, sica.clobValue06
	    FROM scan_issue_ca sica join scan_issue si ON sica.scan_issue_id=si.id join issue i ON i.id = si.issue_id
	    WHERE i.lastScan_id = p_scan_id AND i.projectVersion_id = p_projectVersion_id AND si.scan_id = p_previous_scan_id
	        AND NOT EXISTS (SELECT 1 FROM issue_ca ica WHERE ica.issue_id = i.id);

    DELETE ica FROM issue_ca ica
        WHERE ica.projectVersion_id = p_projectVersion_id AND EXISTS (SELECT 1 from scan_issue si, issue i WHERE si.issue_id = i.id AND si.scan_id = p_previous_scan_id AND i.lastScan_id = p_scan_id AND si.projectVersion_id=p_projectVersion_id AND si.issue_id = ica.issue_id AND NOT EXISTS (SELECT 1 FROM scan_issue_ca WHERE scan_issue_id = si.id));

    UPDATE issue issue, scan_issue si
    SET issue.lastScan_Id = si.scan_id
        , issue.shortFileName=si.shortFileName, issue.fileName=si.fileName, issue.severity=si.severity, issue.confidence=si.confidence, issue.kingdom=si.kingdom, issue.issueType=si.issueType
        , issue.issueSubtype=si.issueSubtype, issue.analyzer=si.analyzer, issue.lineNumber=si.lineNumber, issue.taintFlag=si.taintFlag, issue.packageName=si.packageName
        , issue.functionName=si.functionName, issue.className=si.className, issue.issueAbstract=si.issueAbstract, issue.issueRecommendation=si.issueRecommendation, issue.friority=si.friority, issue.replaceStore=si.replaceStore
        , issue.ruleGuid=si.ruleGuid, issue.snippetId=si.snippetId, issue.contextId=si.contextId, issue.category=si.category, issue.url=si.url, issue.source=si.source, issue.sourceContext=si.sourceContext, issue.sink=si.sink
        , issue.sinkContext=si.sinkContext, issue.sourceFile=si.sourceFile, issue.audienceSet=si.audienceSet
        , issue.findingGuid = si.findingGuid, issue.remediationConstant=si.remediationConstant,issue.likelihood=si.likelihood,issue.impact=si.impact, issue.accuracy=si.accuracy
        , issue.rtaCovered=si.rtaCovered,issue.probability=si.probability
        , issue.requestIdentifier=si.requestIdentifier, issue.requestHeader=si.requestHeader, issue.requestParameter=si.requestParameter, issue.requestBody=si.requestBody, issue.requestMethod=si.requestMethod
        , issue.cookie=si.cookie, issue.httpVersion=si.httpVersion, issue.attackPayload=si.attackPayload, issue.attackType=si.attackType, issue.response=si.response, issue.triggerDefinition=si.triggerDefinition, issue.triggerString=si.triggerString
        , issue.triggerDisplayText=si.triggerDisplayText, issue.secondaryRequest=si.secondaryRequest, issue.sourceLine=si.sourceLine, issue.mappedCategory=si.mappedCategory
        , issue.minVirtualCallConfidence=si.minVirtualCallConfidence
    WHERE issue.projectVersion_id = p_projectVersion_id
        AND issue.lastScan_id = p_scan_id
        AND si.issue_id = issue.id
        AND si.scan_id = p_previous_scan_id;
END//
DELIMITER ;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Custom SQL (x2)', 'EXECUTED', 'procs/dbF360_updateDeletedIssues.xml', 'updateDeletedIssues_mysql', '2.0.1', '3:950c9661a45955b00676b087a0d9440c', 332);

-- Changeset procs/dbF360_updateRemovedWithUpload.xml::updateRemovedWithUpload_mysql::hp::(Checksum: 3:7c3bf7d707649215c2c10b786a7eb003)
DROP PROCEDURE IF EXISTS updateRemovedWithUpload;

DELIMITER //
CREATE PROCEDURE updateRemovedWithUpload    (p_scan_id INT,
     p_projectVersion_Id INT,
     p_engineType varchar(20),
     p_scanDate BIGINT,
     p_removedDate BIGINT)
BEGIN
    UPDATE issue issue, scan_issue si, scan scan, issue_ca ica, scan_issue_ca sica
    SET ica.engineType=si.engineType, ica.dataVersion=sica.dataVersion, ica.metadataPluginId=sica.metadataPluginId,
	    ica.integerValue01 = sica.integerValue01, ica.integerValue02 = sica.integerValue02, ica.integerValue03 = sica.integerValue03,
	    ica.decimalValue01 = sica.decimalValue01, ica.decimalValue02 = sica.decimalValue02, ica.decimalValue03 = sica.decimalValue03, ica.decimalValue04 = sica.decimalValue04, ica.decimalValue05 = sica.decimalValue05,
	    ica.dateValue01 = sica.dateValue01, ica.dateValue02 = sica.dateValue02, ica.dateValue03 = sica.dateValue03, ica.dateValue04 = sica.dateValue04, ica.dateValue05 = sica.dateValue05,
	    ica.textValue01 = sica.textValue01, ica.textValue02 = sica.textValue02, ica.textValue03 = sica.textValue03, ica.textValue04 = sica.textValue04, ica.textValue05 = sica.textValue05,
	    ica.textValue06 = sica.textValue06, ica.textValue07 = sica.textValue07, ica.textValue08 = sica.textValue08, ica.textValue09 = sica.textValue09, ica.textValue10 = sica.textValue10,
	    ica.textValue11 = sica.textValue11, ica.textValue12 = sica.textValue12, ica.textValue13 = sica.textValue13, ica.textValue14 = sica.textValue14, ica.textValue15 = sica.textValue15, ica.textValue16 = sica.textValue16,
	    ica.clobValue01 = sica.clobValue01, ica.clobValue02 = sica.clobValue02, ica.clobValue03 = sica.clobValue03, ica.clobValue04 = sica.clobValue04, ica.clobValue05 = sica.clobValue05, ica.clobValue06 = sica.clobValue06
    WHERE issue.projectVersion_id = p_projectVersion_id
        AND issue.engineType = p_engineType
        AND si.scan_id = p_scan_id
        AND si.issueInstanceId = issue.issueInstanceId
        AND issue.scanStatus = 'REMOVED'
        AND issue.lastScan_id = scan.id
        AND scan.startDate < p_scanDate
        AND sica.scan_issue_id = si.id
        AND ica.issue_id = issue.id;

    INSERT into issue_ca (issue_id, projectVersion_id, issueInstanceId, engineType, dataVersion, metadataPluginId,
			integerValue01, integerValue02, integerValue03, decimalValue01, decimalValue02, decimalValue03, decimalValue04, decimalValue05,
			dateValue01, dateValue02, dateValue03, dateValue04, dateValue05,
			textValue01, textValue02, textValue03, textValue04, textValue05, textValue06, textValue07, textValue08, textValue09, textValue10, textValue11, textValue12, textValue13, textValue14, textValue15, textValue16,
			clobValue01, clobValue02, clobValue03, clobValue04, clobValue05, clobValue06)
	    SELECT i.id, sica.projectVersion_id, si.issueInstanceId, si.engineType, sica.dataVersion, sica.metadataPluginId,
			sica.integerValue01, sica.integerValue02, sica.integerValue03, sica.decimalValue01, sica.decimalValue02, sica.decimalValue03, sica.decimalValue04, sica.decimalValue05,
			sica.dateValue01, sica.dateValue02, sica.dateValue03, sica.dateValue04, sica.dateValue05,
			sica.textValue01, sica.textValue02, sica.textValue03, sica.textValue04, sica.textValue05, sica.textValue06, sica.textValue07, sica.textValue08, sica.textValue09, sica.textValue10, sica.textValue11, sica.textValue12, sica.textValue13, sica.textValue14, sica.textValue15, sica.textValue16,
			sica.clobValue01, sica.clobValue02, sica.clobValue03, sica.clobValue04, sica.clobValue05, sica.clobValue06
	    FROM scan_issue_ca sica join scan_issue si ON sica.scan_issue_id=si.id join issue i ON i.id = si.issue_id join scan s ON i.lastScan_id=s.id
	    WHERE i.projectVersion_id = p_projectVersion_id AND si.scan_id = p_scan_id
	        AND NOT EXISTS (SELECT 1 FROM issue_ca ica WHERE ica.issue_id = i.id) AND i.scanStatus = 'REMOVED'
	        AND s.startDate < p_scanDate AND i.engineType = p_engineType;

    DELETE ica FROM issue_ca ica
        WHERE ica.projectVersion_id = p_projectVersion_id AND EXISTS (SELECT 1 from scan_issue si, issue i, scan s WHERE si.issue_id = i.id AND si.scan_id = p_scan_id AND i.lastScan_id = s.id AND i.scanStatus = 'REMOVED' AND s.startDate < p_scanDate AND si.projectVersion_id=p_projectVersion_id AND si.engineType=ica.engineType AND si.issueInstanceId=ica.issueInstanceId AND NOT EXISTS (SELECT 1 FROM scan_issue_ca WHERE scan_issue_id = si.id));

    UPDATE issue issue, scan_issue si, scan scan
    SET issue.lastScan_Id= si.scan_id, issue.removedDate=p_removedDate
        , issue.shortFileName=si.shortFileName, issue.fileName=si.fileName, issue.severity=si.severity, issue.confidence=si.confidence, issue.kingdom=si.kingdom, issue.issueType=si.issueType
        , issue.issueSubtype=si.issueSubtype, issue.analyzer=si.analyzer, issue.engineType=si.engineType, issue.lineNumber=si.lineNumber, issue.taintFlag=si.taintFlag, issue.packageName=si.packageName
        , issue.functionName=si.functionName, issue.className=si.className, issue.issueAbstract=si.issueAbstract, issue.issueRecommendation=si.issueRecommendation, issue.friority=si.friority, issue.replaceStore=si.replaceStore
        , issue.ruleGuid=si.ruleGuid, issue.snippetId=si.snippetId, issue.contextId=si.contextId, issue.category=si.category, issue.url=si.url, issue.source=si.source, issue.sourceContext=si.sourceContext, issue.sink=si.sink
        , issue.sinkContext=si.sinkContext, issue.sourceFile=si.sourceFile, issue.audienceSet=si.audienceSet
        , issue.findingGuid = si.findingGuid, issue.remediationConstant=si.remediationConstant,issue.likelihood=si.likelihood,issue.impact=si.impact, issue.accuracy=si.accuracy
        , issue.rtaCovered=si.rtaCovered,issue.probability=si.probability
        , issue.requestIdentifier=si.requestIdentifier, issue.requestHeader=si.requestHeader, issue.requestParameter=si.requestParameter, issue.requestBody=si.requestBody, issue.requestMethod=si.requestMethod
        , issue.cookie=si.cookie, issue.httpVersion=si.httpVersion, issue.attackPayload=si.attackPayload, issue.attackType=si.attackType, issue.response=si.response, issue.triggerDefinition=si.triggerDefinition, issue.triggerString=si.triggerString
        , issue.triggerDisplayText=si.triggerDisplayText, issue.secondaryRequest=si.secondaryRequest, issue.sourceLine=si.sourceLine, issue.mappedCategory=si.mappedCategory
        , issue.minVirtualCallConfidence=si.minVirtualCallConfidence
    WHERE issue.projectVersion_id = p_projectVersion_id
        AND issue.engineType = p_engineType
        AND si.scan_id = p_scan_id
        AND si.issueInstanceId = issue.issueInstanceId
        AND issue.scanStatus = 'REMOVED'
        AND issue.lastScan_id = scan.id
        AND scan.startDate < p_scanDate;
END//
DELIMITER ;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Custom SQL (x2)', 'EXECUTED', 'procs/dbF360_updateRemovedWithUpload.xml', 'updateRemovedWithUpload_mysql', '2.0.1', '3:7c3bf7d707649215c2c10b786a7eb003', 333);

-- Changeset procs/dbF360_updateRemovedWithUpload2nd.xml::updateRemovedWithUpload2nd_mysql::hp::(Checksum: 3:c3522de2765086c8222c505c91a9690f)
DROP PROCEDURE IF EXISTS updateRemovedWithUpload2nd;

DELIMITER //
CREATE PROCEDURE updateRemovedWithUpload2nd    (p_scan_id INT,
     p_projectVersion_Id INT,
     p_engineType varchar(20),
     p_scanDate BIGINT,
     p_removedDate BIGINT
    )
BEGIN
    UPDATE issue issue, scan_issue si, issue_ca ica, scan_issue_ca sica
    SET ica.engineType=si.engineType, ica.dataVersion=sica.dataVersion, ica.metadataPluginId=sica.metadataPluginId,
	    ica.integerValue01 = sica.integerValue01, ica.integerValue02 = sica.integerValue02, ica.integerValue03 = sica.integerValue03,
	    ica.decimalValue01 = sica.decimalValue01, ica.decimalValue02 = sica.decimalValue02, ica.decimalValue03 = sica.decimalValue03, ica.decimalValue04 = sica.decimalValue04, ica.decimalValue05 = sica.decimalValue05,
	    ica.dateValue01 = sica.dateValue01, ica.dateValue02 = sica.dateValue02, ica.dateValue03 = sica.dateValue03, ica.dateValue04 = sica.dateValue04, ica.dateValue05 = sica.dateValue05,
	    ica.textValue01 = sica.textValue01, ica.textValue02 = sica.textValue02, ica.textValue03 = sica.textValue03, ica.textValue04 = sica.textValue04, ica.textValue05 = sica.textValue05,
	    ica.textValue06 = sica.textValue06, ica.textValue07 = sica.textValue07, ica.textValue08 = sica.textValue08, ica.textValue09 = sica.textValue09, ica.textValue10 = sica.textValue10,
	    ica.textValue11 = sica.textValue11, ica.textValue12 = sica.textValue12, ica.textValue13 = sica.textValue13, ica.textValue14 = sica.textValue14, ica.textValue15 = sica.textValue15, ica.textValue16 = sica.textValue16,
	    ica.clobValue01 = sica.clobValue01, ica.clobValue02 = sica.clobValue02, ica.clobValue03 = sica.clobValue03, ica.clobValue04 = sica.clobValue04, ica.clobValue05 = sica.clobValue05, ica.clobValue06 = sica.clobValue06
    WHERE issue.projectVersion_id = p_projectVersion_id
        AND issue.engineType = p_engineType
        AND si.scan_id = p_scan_id
        AND si.issue_id = issue.id
        AND issue.scanStatus = 'REMOVED'
        AND sica.scan_issue_id = si.id
        AND ica.issue_id = issue.id;

    INSERT into issue_ca (issue_id, projectVersion_id, issueInstanceId, engineType, dataVersion, metadataPluginId,
			integerValue01, integerValue02, integerValue03, decimalValue01, decimalValue02, decimalValue03, decimalValue04, decimalValue05,
			dateValue01, dateValue02, dateValue03, dateValue04, dateValue05,
			textValue01, textValue02, textValue03, textValue04, textValue05, textValue06, textValue07, textValue08, textValue09, textValue10, textValue11, textValue12, textValue13, textValue14, textValue15, textValue16,
			clobValue01, clobValue02, clobValue03, clobValue04, clobValue05, clobValue06)
	    SELECT i.id, sica.projectVersion_id, si.issueInstanceId, si.engineType, sica.dataVersion, sica.metadataPluginId,
			sica.integerValue01, sica.integerValue02, sica.integerValue03, sica.decimalValue01, sica.decimalValue02, sica.decimalValue03, sica.decimalValue04, sica.decimalValue05,
			sica.dateValue01, sica.dateValue02, sica.dateValue03, sica.dateValue04, sica.dateValue05,
			sica.textValue01, sica.textValue02, sica.textValue03, sica.textValue04, sica.textValue05, sica.textValue06, sica.textValue07, sica.textValue08, sica.textValue09, sica.textValue10, sica.textValue11, sica.textValue12, sica.textValue13, sica.textValue14, sica.textValue15, sica.textValue16,
			sica.clobValue01, sica.clobValue02, sica.clobValue03, sica.clobValue04, sica.clobValue05, sica.clobValue06
	    FROM scan_issue_ca sica join scan_issue si ON sica.scan_issue_id=si.id join issue i ON i.id = si.issue_id join scan s ON i.lastScan_id=s.id
	    WHERE i.projectVersion_id = p_projectVersion_id AND si.scan_id = p_scan_id
	        AND NOT EXISTS (SELECT 1 FROM issue_ca ica WHERE ica.issue_id = i.id) AND i.scanStatus = 'REMOVED'
	        AND i.engineType = p_engineType;

    DELETE ica FROM issue_ca ica
        WHERE ica.projectVersion_id = p_projectVersion_id AND EXISTS (SELECT 1 from scan_issue si, issue i WHERE si.issue_id = i.id AND si.scan_id = p_scan_id AND i.scanStatus = 'REMOVED' AND si.projectVersion_id=p_projectVersion_id AND si.engineType=ica.engineType AND si.issueInstanceId=ica.issueInstanceId AND NOT EXISTS (SELECT 1 FROM scan_issue_ca WHERE scan_issue_id = si.id));


    UPDATE issue issue, scan_issue si
    SET issue.lastScan_Id= si.scan_id, issue.removedDate=p_removedDate
        , issue.shortFileName=si.shortFileName, issue.fileName=si.fileName, issue.severity=si.severity, issue.confidence=si.confidence, issue.kingdom=si.kingdom, issue.issueType=si.issueType
        , issue.issueSubtype=si.issueSubtype, issue.analyzer=si.analyzer, issue.lineNumber=si.lineNumber, issue.taintFlag=si.taintFlag, issue.packageName=si.packageName
        , issue.functionName=si.functionName, issue.className=si.className, issue.issueAbstract=si.issueAbstract, issue.issueRecommendation=si.issueRecommendation, issue.friority=si.friority, issue.replaceStore=si.replaceStore
        , issue.ruleGuid=si.ruleGuid, issue.snippetId=si.snippetId, issue.contextId=si.contextId, issue.category=si.category, issue.url=si.url, issue.source=si.source, issue.sourceContext=si.sourceContext, issue.sink=si.sink
        , issue.sinkContext=si.sinkContext, issue.sourceFile=si.sourceFile, issue.audienceSet=si.audienceSet
        , issue.findingGuid = si.findingGuid, issue.remediationConstant=si.remediationConstant,issue.likelihood=si.likelihood,issue.impact=si.impact, issue.accuracy=si.accuracy
        , issue.rtaCovered=si.rtaCovered,issue.probability=si.probability
        , issue.requestIdentifier=si.requestIdentifier, issue.requestHeader=si.requestHeader, issue.requestParameter=si.requestParameter, issue.requestBody=si.requestBody, issue.requestMethod=si.requestMethod
        , issue.cookie=si.cookie, issue.httpVersion=si.httpVersion, issue.attackPayload=si.attackPayload, issue.attackType=si.attackType, issue.response=si.response, issue.triggerDefinition=si.triggerDefinition, issue.triggerString=si.triggerString
        , issue.triggerDisplayText=si.triggerDisplayText, issue.secondaryRequest=si.secondaryRequest, issue.sourceLine=si.sourceLine, issue.mappedCategory=si.mappedCategory
        , issue.minVirtualCallConfidence=si.minVirtualCallConfidence
    WHERE issue.projectVersion_id = p_projectVersion_id
        AND issue.engineType = p_engineType
        AND si.scan_id = p_scan_id
        AND si.issue_id = issue.id
        AND issue.scanStatus = 'REMOVED';
END//
DELIMITER ;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp', '', NOW(), 'Custom SQL (x2)', 'EXECUTED', 'procs/dbF360_updateRemovedWithUpload2nd.xml', 'updateRemovedWithUpload2nd_mysql', '2.0.1', '3:c3522de2765086c8222c505c91a9690f', 334);

-- Changeset procs/dbF360_migrateScanIssueIds.xml::migrateScanIssueIds_mysql::hp_main::(Checksum: 3:c3097e7b3c4529f6836dbd139978e0a2)
DROP PROCEDURE IF EXISTS migrateScanIssueIds;

DELIMITER //
CREATE PROCEDURE migrateScanIssueIds	(p_scan_id INT,
	p_projectVersion_Id INT, 
	p_engineType varchar(20)
	)
BEGIN
	UPDATE scan_issue si, issue issue
	SET si.issue_id=issue.id
	WHERE issue.projectVersion_Id = p_projectVersion_Id
	  AND issue.engineType= p_engineType
	  AND si.issueInstanceId=issue.tempInstanceId
	  AND si.scan_id= p_scan_id;
END//
DELIMITER ;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Custom SQL (x2)', 'EXECUTED', 'procs/dbF360_migrateScanIssueIds.xml', 'migrateScanIssueIds_mysql', '2.0.1', '3:c3097e7b3c4529f6836dbd139978e0a2', 335);

-- Changeset procs/dbF360_extractFileName.xml::extractFileName_mysql::hp_main::(Checksum: 3:a273d6b66a857e20de8f13ac2e50b48d)
DROP FUNCTION IF EXISTS extractFileName;

DELIMITER //
CREATE FUNCTION extractFileName(fullFilePath VARCHAR(3000)) RETURNS VARCHAR(500)    DETERMINISTIC
BEGIN
    DECLARE reversed varchar(3000);
    DECLARE result varchar(1000);
    declare slashPosition int;

    SET reversed = reverse(fullFilePath);
    SET slashPosition = LOCATE('/', reversed) - 1;
    IF slashPosition <= 0 THEN
		SET slashPosition = LOCATE('\\', reversed) - 1;
		IF slashPosition <= 0 THEN
			SET slashPosition = length(reversed);
		END IF;
    END IF;
    SET result = substr(reversed, 1, slashPosition);

    RETURN reverse(result);
END//
DELIMITER ;

INSERT INTO `DATABASECHANGELOG` (`AUTHOR`, `COMMENTS`, `DATEEXECUTED`, `DESCRIPTION`, `EXECTYPE`, `FILENAME`, `ID`, `LIQUIBASE`, `MD5SUM`, `ORDEREXECUTED`) VALUES ('hp_main', '', NOW(), 'Custom SQL (x2)', 'EXECUTED', 'procs/dbF360_extractFileName.xml', 'extractFileName_mysql', '2.0.1', '3:a273d6b66a857e20de8f13ac2e50b48d', 336);

