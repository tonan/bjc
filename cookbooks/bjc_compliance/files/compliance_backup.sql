--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.1
-- Dumped by pg_dump version 9.5.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

SET search_path = sqitch, pg_catalog;

ALTER TABLE ONLY sqitch.tags DROP CONSTRAINT tags_project_fkey;
ALTER TABLE ONLY sqitch.tags DROP CONSTRAINT tags_change_id_fkey;
ALTER TABLE ONLY sqitch.events DROP CONSTRAINT events_project_fkey;
ALTER TABLE ONLY sqitch.dependencies DROP CONSTRAINT dependencies_dependency_id_fkey;
ALTER TABLE ONLY sqitch.dependencies DROP CONSTRAINT dependencies_change_id_fkey;
ALTER TABLE ONLY sqitch.changes DROP CONSTRAINT changes_project_fkey;
SET search_path = public, pg_catalog;

ALTER TABLE ONLY public.owners DROP CONSTRAINT owners_fk_source;
ALTER TABLE ONLY public.nodes DROP CONSTRAINT nodes_fkey_owner;
ALTER TABLE ONLY public.nodes DROP CONSTRAINT nodes_fkey_environment;
SET search_path = sqitch, pg_catalog;

ALTER TABLE ONLY sqitch.tags DROP CONSTRAINT tags_project_tag_key;
ALTER TABLE ONLY sqitch.tags DROP CONSTRAINT tags_pkey;
ALTER TABLE ONLY sqitch.projects DROP CONSTRAINT projects_uri_key;
ALTER TABLE ONLY sqitch.projects DROP CONSTRAINT projects_pkey;
ALTER TABLE ONLY sqitch.events DROP CONSTRAINT events_pkey;
ALTER TABLE ONLY sqitch.dependencies DROP CONSTRAINT dependencies_pkey;
ALTER TABLE ONLY sqitch.changes DROP CONSTRAINT changes_pkey;
SET search_path = public, pg_catalog;

ALTER TABLE ONLY public.user_preferences DROP CONSTRAINT user_preferences_pkey;
ALTER TABLE ONLY public.user_permissions DROP CONSTRAINT user_permissions_pkey;
ALTER TABLE ONLY public.teams DROP CONSTRAINT teams_pkey;
ALTER TABLE ONLY public.team_members DROP CONSTRAINT team_members_pkey;
ALTER TABLE ONLY public.sources DROP CONSTRAINT sources_pkey;
ALTER TABLE ONLY public.scans DROP CONSTRAINT scans_pkey;
ALTER TABLE ONLY public.scan_rule_results DROP CONSTRAINT scan_rule_results_pkey;
ALTER TABLE ONLY public.scan_node_results DROP CONSTRAINT scan_node_results_pkey;
ALTER TABLE ONLY public.role_permissions DROP CONSTRAINT role_permissions_pkey;
ALTER TABLE ONLY public.patch_runs DROP CONSTRAINT patch_runs_pkey;
ALTER TABLE ONLY public.patch_node_results DROP CONSTRAINT patch_node_results_pkey;
ALTER TABLE ONLY public.packages_installed DROP CONSTRAINT packages_installed_pkey;
ALTER TABLE ONLY public.packages_install DROP CONSTRAINT packages_install_pkey;
ALTER TABLE ONLY public.packages_available DROP CONSTRAINT packages_available_pkey;
ALTER TABLE ONLY public.package_confs DROP CONSTRAINT package_confs_pkey;
ALTER TABLE ONLY public.package_conf_profiles DROP CONSTRAINT package_conf_profiles_pkey;
ALTER TABLE ONLY public.owners DROP CONSTRAINT owners_pkey;
ALTER TABLE ONLY public.nodes DROP CONSTRAINT nodes_pkey;
ALTER TABLE ONLY public.owners DROP CONSTRAINT login_uniqueness;
ALTER TABLE ONLY public.jobs DROP CONSTRAINT jobs_pkey;
ALTER TABLE ONLY public.job_tasks DROP CONSTRAINT job_tasks_pkey;
ALTER TABLE ONLY public.job_runs DROP CONSTRAINT job_runs_pkey;
ALTER TABLE ONLY public.hardening_config DROP CONSTRAINT hardening_config_pkey;
ALTER TABLE ONLY public.environments DROP CONSTRAINT environments_pkey;
ALTER TABLE ONLY public.access_keys DROP CONSTRAINT access_keys_uniqueness;
ALTER TABLE ONLY public.access_keys DROP CONSTRAINT access_keys_pkey;
SET search_path = sqitch, pg_catalog;

SET search_path = public, pg_catalog;

SET search_path = sqitch, pg_catalog;

DROP TABLE sqitch.tags;
DROP TABLE sqitch.projects;
DROP TABLE sqitch.events;
DROP TABLE sqitch.dependencies;
DROP TABLE sqitch.changes;
SET search_path = public, pg_catalog;

DROP TABLE public.user_preferences;
DROP TABLE public.user_permissions;
DROP TABLE public.teams;
DROP TABLE public.team_members;
DROP TABLE public.sources;
DROP TABLE public.scans;
DROP TABLE public.scan_rule_results;
DROP TABLE public.scan_node_results;
DROP TABLE public.role_permissions;
DROP TABLE public.patch_runs;
DROP TABLE public.patch_node_results;
DROP TABLE public.packages_installed;
DROP TABLE public.packages_install;
DROP TABLE public.packages_available;
DROP TABLE public.package_confs;
DROP TABLE public.package_conf_profiles;
DROP TABLE public.owners;
DROP TABLE public.nodes;
DROP TABLE public.jobs;
DROP TABLE public.job_tasks;
DROP TABLE public.job_runs;
DROP TABLE public.hardening_config;
DROP TABLE public.environments;
DROP TABLE public.access_keys;
DROP TYPE public.source;
DROP EXTENSION plpgsql;
DROP SCHEMA sqitch;
DROP SCHEMA public;
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: chef-pgsql
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO "chef-pgsql";

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: chef-pgsql
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- Name: sqitch; Type: SCHEMA; Schema: -; Owner: chef-pgsql
--

CREATE SCHEMA sqitch;


ALTER SCHEMA sqitch OWNER TO "chef-pgsql";

--
-- Name: SCHEMA sqitch; Type: COMMENT; Schema: -; Owner: chef-pgsql
--

COMMENT ON SCHEMA sqitch IS 'Sqitch database deployment metadata v1.0.';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: source; Type: TYPE; Schema: public; Owner: chef-pgsql
--

CREATE TYPE source AS ENUM (
    'chef'
);


ALTER TYPE source OWNER TO "chef-pgsql";

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: access_keys; Type: TABLE; Schema: public; Owner: chef-pgsql
--

CREATE TABLE access_keys (
    owner text NOT NULL,
    id text NOT NULL,
    name text,
    public text,
    private text
);


ALTER TABLE access_keys OWNER TO "chef-pgsql";

--
-- Name: environments; Type: TABLE; Schema: public; Owner: chef-pgsql
--

CREATE TABLE environments (
    id text NOT NULL,
    owner text NOT NULL,
    name text,
    last_scan timestamp with time zone,
    compliance_status real,
    patchlevel_status real,
    unknown_status real
);


ALTER TABLE environments OWNER TO "chef-pgsql";

--
-- Name: hardening_config; Type: TABLE; Schema: public; Owner: chef-pgsql
--

CREATE TABLE hardening_config (
    id text NOT NULL,
    node text,
    environment text,
    owner text,
    conf_owner text,
    conf_profile text,
    json_attribute text,
    json_value text
);


ALTER TABLE hardening_config OWNER TO "chef-pgsql";

--
-- Name: job_runs; Type: TABLE; Schema: public; Owner: chef-pgsql
--

CREATE TABLE job_runs (
    job text NOT NULL,
    owner text NOT NULL,
    run_id text NOT NULL,
    type text,
    start timestamp with time zone
);


ALTER TABLE job_runs OWNER TO "chef-pgsql";

--
-- Name: job_tasks; Type: TABLE; Schema: public; Owner: chef-pgsql
--

CREATE TABLE job_tasks (
    id text NOT NULL,
    job text NOT NULL,
    owner text NOT NULL,
    type text,
    config text
);


ALTER TABLE job_tasks OWNER TO "chef-pgsql";

--
-- Name: jobs; Type: TABLE; Schema: public; Owner: chef-pgsql
--

CREATE TABLE jobs (
    id text NOT NULL,
    owner text NOT NULL,
    status text,
    name text,
    next_run timestamp with time zone,
    month text,
    day_of_month text,
    day_of_week text,
    hour text,
    minute text,
    date timestamp with time zone
);


ALTER TABLE jobs OWNER TO "chef-pgsql";

--
-- Name: nodes; Type: TABLE; Schema: public; Owner: chef-pgsql
--

CREATE TABLE nodes (
    id text NOT NULL,
    environment text NOT NULL,
    owner text NOT NULL,
    name text,
    hostname text,
    login_method text,
    login_user text,
    login_password text,
    login_key text,
    login_port integer,
    disable_sudo boolean,
    sudo_options text,
    sudo_password text,
    last_scan timestamp with time zone,
    last_scan_id text,
    os_family text,
    os_release text,
    os_arch text,
    compliance_status real,
    patchlevel_status real,
    unknown_status real
);


ALTER TABLE nodes OWNER TO "chef-pgsql";

--
-- Name: owners; Type: TABLE; Schema: public; Owner: chef-pgsql
--

CREATE TABLE owners (
    id text NOT NULL,
    pw text,
    name text,
    is_org boolean,
    login text NOT NULL,
    source text
);


ALTER TABLE owners OWNER TO "chef-pgsql";

--
-- Name: package_conf_profiles; Type: TABLE; Schema: public; Owner: chef-pgsql
--

CREATE TABLE package_conf_profiles (
    owner text NOT NULL,
    id text NOT NULL,
    release text,
    name text
);


ALTER TABLE package_conf_profiles OWNER TO "chef-pgsql";

--
-- Name: package_confs; Type: TABLE; Schema: public; Owner: chef-pgsql
--

CREATE TABLE package_confs (
    owner text,
    profile text NOT NULL,
    id text NOT NULL,
    name text,
    pkgversion text,
    arch text,
    repo text,
    type text,
    action text,
    available_since timestamp with time zone,
    min_criticality real,
    max_criticality real
);


ALTER TABLE package_confs OWNER TO "chef-pgsql";

--
-- Name: packages_available; Type: TABLE; Schema: public; Owner: chef-pgsql
--

CREATE TABLE packages_available (
    criticality real,
    oldversion text,
    scan text NOT NULL,
    node text NOT NULL,
    environment text NOT NULL,
    name text NOT NULL,
    pkgversion text NOT NULL,
    arch text NOT NULL,
    repo text,
    type text
);


ALTER TABLE packages_available OWNER TO "chef-pgsql";

--
-- Name: packages_install; Type: TABLE; Schema: public; Owner: chef-pgsql
--

CREATE TABLE packages_install (
    node text,
    environment text,
    name text,
    pkgversion text,
    arch text,
    repo text,
    type text,
    id text NOT NULL,
    patch text,
    owner text
);


ALTER TABLE packages_install OWNER TO "chef-pgsql";

--
-- Name: packages_installed; Type: TABLE; Schema: public; Owner: chef-pgsql
--

CREATE TABLE packages_installed (
    scan text NOT NULL,
    node text NOT NULL,
    environment text NOT NULL,
    name text NOT NULL,
    pkgversion text NOT NULL,
    arch text NOT NULL,
    repo text,
    type text
);


ALTER TABLE packages_installed OWNER TO "chef-pgsql";

--
-- Name: patch_node_results; Type: TABLE; Schema: public; Owner: chef-pgsql
--

CREATE TABLE patch_node_results (
    owner text NOT NULL,
    patch text NOT NULL,
    environment text NOT NULL,
    node text NOT NULL,
    success_rate real,
    package_cnt integer,
    log text
);


ALTER TABLE patch_node_results OWNER TO "chef-pgsql";

--
-- Name: patch_runs; Type: TABLE; Schema: public; Owner: chef-pgsql
--

CREATE TABLE patch_runs (
    id text NOT NULL,
    owner text,
    start timestamp with time zone,
    "end" timestamp with time zone,
    cnt_nodes integer,
    skip_count integer,
    failure_count integer,
    success_count integer
);


ALTER TABLE patch_runs OWNER TO "chef-pgsql";

--
-- Name: role_permissions; Type: TABLE; Schema: public; Owner: chef-pgsql
--

CREATE TABLE role_permissions (
    id text NOT NULL,
    owner text,
    team text,
    environment text,
    node text,
    key text,
    value text
);


ALTER TABLE role_permissions OWNER TO "chef-pgsql";

--
-- Name: scan_node_results; Type: TABLE; Schema: public; Owner: chef-pgsql
--

CREATE TABLE scan_node_results (
    scan text NOT NULL,
    environment text NOT NULL,
    node text NOT NULL,
    compliance_status real,
    patchlevel_status real,
    unknown_status real,
    os_family text,
    os_release text,
    os_arch text,
    rules_success integer,
    rules_minor integer,
    rules_major integer,
    rules_critical integer,
    rules_skipped integer,
    rules_total integer,
    patch_success integer,
    patch_minor integer,
    patch_major integer,
    patch_critical integer,
    patch_unknown integer,
    patch_total integer,
    connect_success boolean NOT NULL,
    connect_message text NOT NULL
);


ALTER TABLE scan_node_results OWNER TO "chef-pgsql";

--
-- Name: scan_rule_results; Type: TABLE; Schema: public; Owner: chef-pgsql
--

CREATE TABLE scan_rule_results (
    node text NOT NULL,
    environment text NOT NULL,
    scan text NOT NULL,
    profile_owner text NOT NULL,
    profile_id text NOT NULL,
    rule text NOT NULL,
    impact real,
    failures integer,
    skipped boolean,
    log text
);


ALTER TABLE scan_rule_results OWNER TO "chef-pgsql";

--
-- Name: scans; Type: TABLE; Schema: public; Owner: chef-pgsql
--

CREATE TABLE scans (
    id text NOT NULL,
    owner text,
    start timestamp with time zone,
    "end" timestamp with time zone,
    cnt_nodes integer,
    cnt_compliance integer,
    cnt_patchlevel integer,
    compliance_status real,
    patchlevel_status real,
    unknown_status real,
    rules_success integer,
    rules_minor integer,
    rules_major integer,
    rules_critical integer,
    rules_skipped integer,
    rules_total integer,
    patch_success integer,
    patch_minor integer,
    patch_major integer,
    patch_critical integer,
    patch_unknown integer,
    patch_total integer,
    cnt_failed_scans integer NOT NULL
);


ALTER TABLE scans OWNER TO "chef-pgsql";

--
-- Name: sources; Type: TABLE; Schema: public; Owner: chef-pgsql
--

CREATE TABLE sources (
    id text NOT NULL,
    info json,
    type source
);


ALTER TABLE sources OWNER TO "chef-pgsql";

--
-- Name: team_members; Type: TABLE; Schema: public; Owner: chef-pgsql
--

CREATE TABLE team_members (
    team text NOT NULL,
    org text NOT NULL,
    "user" text NOT NULL
);


ALTER TABLE team_members OWNER TO "chef-pgsql";

--
-- Name: teams; Type: TABLE; Schema: public; Owner: chef-pgsql
--

CREATE TABLE teams (
    id text NOT NULL,
    org text NOT NULL,
    name text
);


ALTER TABLE teams OWNER TO "chef-pgsql";

--
-- Name: user_permissions; Type: TABLE; Schema: public; Owner: chef-pgsql
--

CREATE TABLE user_permissions (
    id text NOT NULL,
    key text NOT NULL,
    value text
);


ALTER TABLE user_permissions OWNER TO "chef-pgsql";

--
-- Name: user_preferences; Type: TABLE; Schema: public; Owner: chef-pgsql
--

CREATE TABLE user_preferences (
    id text NOT NULL,
    key text NOT NULL,
    value text
);


ALTER TABLE user_preferences OWNER TO "chef-pgsql";

SET search_path = sqitch, pg_catalog;

--
-- Name: changes; Type: TABLE; Schema: sqitch; Owner: chef-pgsql
--

CREATE TABLE changes (
    change_id text NOT NULL,
    change text NOT NULL,
    project text NOT NULL,
    note text DEFAULT ''::text NOT NULL,
    committed_at timestamp with time zone DEFAULT clock_timestamp() NOT NULL,
    committer_name text NOT NULL,
    committer_email text NOT NULL,
    planned_at timestamp with time zone NOT NULL,
    planner_name text NOT NULL,
    planner_email text NOT NULL
);


ALTER TABLE changes OWNER TO "chef-pgsql";

--
-- Name: TABLE changes; Type: COMMENT; Schema: sqitch; Owner: chef-pgsql
--

COMMENT ON TABLE changes IS 'Tracks the changes currently deployed to the database.';


--
-- Name: COLUMN changes.change_id; Type: COMMENT; Schema: sqitch; Owner: chef-pgsql
--

COMMENT ON COLUMN changes.change_id IS 'Change primary key.';


--
-- Name: COLUMN changes.change; Type: COMMENT; Schema: sqitch; Owner: chef-pgsql
--

COMMENT ON COLUMN changes.change IS 'Name of a deployed change.';


--
-- Name: COLUMN changes.project; Type: COMMENT; Schema: sqitch; Owner: chef-pgsql
--

COMMENT ON COLUMN changes.project IS 'Name of the Sqitch project to which the change belongs.';


--
-- Name: COLUMN changes.note; Type: COMMENT; Schema: sqitch; Owner: chef-pgsql
--

COMMENT ON COLUMN changes.note IS 'Description of the change.';


--
-- Name: COLUMN changes.committed_at; Type: COMMENT; Schema: sqitch; Owner: chef-pgsql
--

COMMENT ON COLUMN changes.committed_at IS 'Date the change was deployed.';


--
-- Name: COLUMN changes.committer_name; Type: COMMENT; Schema: sqitch; Owner: chef-pgsql
--

COMMENT ON COLUMN changes.committer_name IS 'Name of the user who deployed the change.';


--
-- Name: COLUMN changes.committer_email; Type: COMMENT; Schema: sqitch; Owner: chef-pgsql
--

COMMENT ON COLUMN changes.committer_email IS 'Email address of the user who deployed the change.';


--
-- Name: COLUMN changes.planned_at; Type: COMMENT; Schema: sqitch; Owner: chef-pgsql
--

COMMENT ON COLUMN changes.planned_at IS 'Date the change was added to the plan.';


--
-- Name: COLUMN changes.planner_name; Type: COMMENT; Schema: sqitch; Owner: chef-pgsql
--

COMMENT ON COLUMN changes.planner_name IS 'Name of the user who planed the change.';


--
-- Name: COLUMN changes.planner_email; Type: COMMENT; Schema: sqitch; Owner: chef-pgsql
--

COMMENT ON COLUMN changes.planner_email IS 'Email address of the user who planned the change.';


--
-- Name: dependencies; Type: TABLE; Schema: sqitch; Owner: chef-pgsql
--

CREATE TABLE dependencies (
    change_id text NOT NULL,
    type text NOT NULL,
    dependency text NOT NULL,
    dependency_id text,
    CONSTRAINT dependencies_check CHECK ((((type = 'require'::text) AND (dependency_id IS NOT NULL)) OR ((type = 'conflict'::text) AND (dependency_id IS NULL))))
);


ALTER TABLE dependencies OWNER TO "chef-pgsql";

--
-- Name: TABLE dependencies; Type: COMMENT; Schema: sqitch; Owner: chef-pgsql
--

COMMENT ON TABLE dependencies IS 'Tracks the currently satisfied dependencies.';


--
-- Name: COLUMN dependencies.change_id; Type: COMMENT; Schema: sqitch; Owner: chef-pgsql
--

COMMENT ON COLUMN dependencies.change_id IS 'ID of the depending change.';


--
-- Name: COLUMN dependencies.type; Type: COMMENT; Schema: sqitch; Owner: chef-pgsql
--

COMMENT ON COLUMN dependencies.type IS 'Type of dependency.';


--
-- Name: COLUMN dependencies.dependency; Type: COMMENT; Schema: sqitch; Owner: chef-pgsql
--

COMMENT ON COLUMN dependencies.dependency IS 'Dependency name.';


--
-- Name: COLUMN dependencies.dependency_id; Type: COMMENT; Schema: sqitch; Owner: chef-pgsql
--

COMMENT ON COLUMN dependencies.dependency_id IS 'Change ID the dependency resolves to.';


--
-- Name: events; Type: TABLE; Schema: sqitch; Owner: chef-pgsql
--

CREATE TABLE events (
    event text NOT NULL,
    change_id text NOT NULL,
    change text NOT NULL,
    project text NOT NULL,
    note text DEFAULT ''::text NOT NULL,
    requires text[] DEFAULT '{}'::text[] NOT NULL,
    conflicts text[] DEFAULT '{}'::text[] NOT NULL,
    tags text[] DEFAULT '{}'::text[] NOT NULL,
    committed_at timestamp with time zone DEFAULT clock_timestamp() NOT NULL,
    committer_name text NOT NULL,
    committer_email text NOT NULL,
    planned_at timestamp with time zone NOT NULL,
    planner_name text NOT NULL,
    planner_email text NOT NULL,
    CONSTRAINT events_event_check CHECK ((event = ANY (ARRAY['deploy'::text, 'revert'::text, 'fail'::text])))
);


ALTER TABLE events OWNER TO "chef-pgsql";

--
-- Name: TABLE events; Type: COMMENT; Schema: sqitch; Owner: chef-pgsql
--

COMMENT ON TABLE events IS 'Contains full history of all deployment events.';


--
-- Name: COLUMN events.event; Type: COMMENT; Schema: sqitch; Owner: chef-pgsql
--

COMMENT ON COLUMN events.event IS 'Type of event.';


--
-- Name: COLUMN events.change_id; Type: COMMENT; Schema: sqitch; Owner: chef-pgsql
--

COMMENT ON COLUMN events.change_id IS 'Change ID.';


--
-- Name: COLUMN events.change; Type: COMMENT; Schema: sqitch; Owner: chef-pgsql
--

COMMENT ON COLUMN events.change IS 'Change name.';


--
-- Name: COLUMN events.project; Type: COMMENT; Schema: sqitch; Owner: chef-pgsql
--

COMMENT ON COLUMN events.project IS 'Name of the Sqitch project to which the change belongs.';


--
-- Name: COLUMN events.note; Type: COMMENT; Schema: sqitch; Owner: chef-pgsql
--

COMMENT ON COLUMN events.note IS 'Description of the change.';


--
-- Name: COLUMN events.requires; Type: COMMENT; Schema: sqitch; Owner: chef-pgsql
--

COMMENT ON COLUMN events.requires IS 'Array of the names of required changes.';


--
-- Name: COLUMN events.conflicts; Type: COMMENT; Schema: sqitch; Owner: chef-pgsql
--

COMMENT ON COLUMN events.conflicts IS 'Array of the names of conflicting changes.';


--
-- Name: COLUMN events.tags; Type: COMMENT; Schema: sqitch; Owner: chef-pgsql
--

COMMENT ON COLUMN events.tags IS 'Tags associated with the change.';


--
-- Name: COLUMN events.committed_at; Type: COMMENT; Schema: sqitch; Owner: chef-pgsql
--

COMMENT ON COLUMN events.committed_at IS 'Date the event was committed.';


--
-- Name: COLUMN events.committer_name; Type: COMMENT; Schema: sqitch; Owner: chef-pgsql
--

COMMENT ON COLUMN events.committer_name IS 'Name of the user who committed the event.';


--
-- Name: COLUMN events.committer_email; Type: COMMENT; Schema: sqitch; Owner: chef-pgsql
--

COMMENT ON COLUMN events.committer_email IS 'Email address of the user who committed the event.';


--
-- Name: COLUMN events.planned_at; Type: COMMENT; Schema: sqitch; Owner: chef-pgsql
--

COMMENT ON COLUMN events.planned_at IS 'Date the event was added to the plan.';


--
-- Name: COLUMN events.planner_name; Type: COMMENT; Schema: sqitch; Owner: chef-pgsql
--

COMMENT ON COLUMN events.planner_name IS 'Name of the user who planed the change.';


--
-- Name: COLUMN events.planner_email; Type: COMMENT; Schema: sqitch; Owner: chef-pgsql
--

COMMENT ON COLUMN events.planner_email IS 'Email address of the user who plan planned the change.';


--
-- Name: projects; Type: TABLE; Schema: sqitch; Owner: chef-pgsql
--

CREATE TABLE projects (
    project text NOT NULL,
    uri text,
    created_at timestamp with time zone DEFAULT clock_timestamp() NOT NULL,
    creator_name text NOT NULL,
    creator_email text NOT NULL
);


ALTER TABLE projects OWNER TO "chef-pgsql";

--
-- Name: TABLE projects; Type: COMMENT; Schema: sqitch; Owner: chef-pgsql
--

COMMENT ON TABLE projects IS 'Sqitch projects deployed to this database.';


--
-- Name: COLUMN projects.project; Type: COMMENT; Schema: sqitch; Owner: chef-pgsql
--

COMMENT ON COLUMN projects.project IS 'Unique Name of a project.';


--
-- Name: COLUMN projects.uri; Type: COMMENT; Schema: sqitch; Owner: chef-pgsql
--

COMMENT ON COLUMN projects.uri IS 'Optional project URI';


--
-- Name: COLUMN projects.created_at; Type: COMMENT; Schema: sqitch; Owner: chef-pgsql
--

COMMENT ON COLUMN projects.created_at IS 'Date the project was added to the database.';


--
-- Name: COLUMN projects.creator_name; Type: COMMENT; Schema: sqitch; Owner: chef-pgsql
--

COMMENT ON COLUMN projects.creator_name IS 'Name of the user who added the project.';


--
-- Name: COLUMN projects.creator_email; Type: COMMENT; Schema: sqitch; Owner: chef-pgsql
--

COMMENT ON COLUMN projects.creator_email IS 'Email address of the user who added the project.';


--
-- Name: tags; Type: TABLE; Schema: sqitch; Owner: chef-pgsql
--

CREATE TABLE tags (
    tag_id text NOT NULL,
    tag text NOT NULL,
    project text NOT NULL,
    change_id text NOT NULL,
    note text DEFAULT ''::text NOT NULL,
    committed_at timestamp with time zone DEFAULT clock_timestamp() NOT NULL,
    committer_name text NOT NULL,
    committer_email text NOT NULL,
    planned_at timestamp with time zone NOT NULL,
    planner_name text NOT NULL,
    planner_email text NOT NULL
);


ALTER TABLE tags OWNER TO "chef-pgsql";

--
-- Name: TABLE tags; Type: COMMENT; Schema: sqitch; Owner: chef-pgsql
--

COMMENT ON TABLE tags IS 'Tracks the tags currently applied to the database.';


--
-- Name: COLUMN tags.tag_id; Type: COMMENT; Schema: sqitch; Owner: chef-pgsql
--

COMMENT ON COLUMN tags.tag_id IS 'Tag primary key.';


--
-- Name: COLUMN tags.tag; Type: COMMENT; Schema: sqitch; Owner: chef-pgsql
--

COMMENT ON COLUMN tags.tag IS 'Project-unique tag name.';


--
-- Name: COLUMN tags.project; Type: COMMENT; Schema: sqitch; Owner: chef-pgsql
--

COMMENT ON COLUMN tags.project IS 'Name of the Sqitch project to which the tag belongs.';


--
-- Name: COLUMN tags.change_id; Type: COMMENT; Schema: sqitch; Owner: chef-pgsql
--

COMMENT ON COLUMN tags.change_id IS 'ID of last change deployed before the tag was applied.';


--
-- Name: COLUMN tags.note; Type: COMMENT; Schema: sqitch; Owner: chef-pgsql
--

COMMENT ON COLUMN tags.note IS 'Description of the tag.';


--
-- Name: COLUMN tags.committed_at; Type: COMMENT; Schema: sqitch; Owner: chef-pgsql
--

COMMENT ON COLUMN tags.committed_at IS 'Date the tag was applied to the database.';


--
-- Name: COLUMN tags.committer_name; Type: COMMENT; Schema: sqitch; Owner: chef-pgsql
--

COMMENT ON COLUMN tags.committer_name IS 'Name of the user who applied the tag.';


--
-- Name: COLUMN tags.committer_email; Type: COMMENT; Schema: sqitch; Owner: chef-pgsql
--

COMMENT ON COLUMN tags.committer_email IS 'Email address of the user who applied the tag.';


--
-- Name: COLUMN tags.planned_at; Type: COMMENT; Schema: sqitch; Owner: chef-pgsql
--

COMMENT ON COLUMN tags.planned_at IS 'Date the tag was added to the plan.';


--
-- Name: COLUMN tags.planner_name; Type: COMMENT; Schema: sqitch; Owner: chef-pgsql
--

COMMENT ON COLUMN tags.planner_name IS 'Name of the user who planed the tag.';


--
-- Name: COLUMN tags.planner_email; Type: COMMENT; Schema: sqitch; Owner: chef-pgsql
--

COMMENT ON COLUMN tags.planner_email IS 'Email address of the user who planned the tag.';


SET search_path = public, pg_catalog;

--
-- Data for Name: access_keys; Type: TABLE DATA; Schema: public; Owner: chef-pgsql
--

COPY access_keys (owner, id, name, public, private) FROM stdin;
ac36a30b-fe17-4684-54bf-2ed5501d6e7b	2de3086b-3e02-4f32-76dc-a4898770e0ea	id_rsa		-----BEGIN RSA PRIVATE KEY-----\nMIIEpAIBAAKCAQEA1IpwLVLgW72/JkshmPYymEtlIT3VBgTj+t502RCg+txUgPzS\negqoUaFldf0tojfPJc19IP0OpJCX1xZjtyStEXj357EY3PA0P+A5gvwIgOcdnngL\nc3cCW64237S/VR62NeELUgA5puFUZ7MvO2MtFWU5vFtBAyO9lrfxCLdPPck7Cb1U\nhDgImJzStoChwTv8xJk4EinWy0Pj4exovv6+zcOK0n7t6GilhGNj0usAnYsMfhg8\n8mTWxWnhzwkc8Fo3JBNDCMHo/cNT2ezucLoA3n3Z1Q7a9Wsj0Tdf9fxpjYlcJNY0\nrt3ol5uLlObv8RjZGuDrJkNRc90+HlcisGzq8QIDAQABAoIBAEzQs/ZNi7TcgSdP\n5BaqdGLCbQx0kncYcWUL3WNONUA1PX1Y4qElFOxbzpW0KTgFv6JEAENZ8l7bu2UL\nPILGiJ5WABMG2JuRXPDxExgaCuC7puLNNCZJDtsfvclgQ/55mRUj/rlmR2/e5GiO\nRDXMhFDFQvambHq8Ahtk44Jo7gS/+oTPHRq5Q2XUNES3yOhB81GiDMoxuEGTVoUh\nGKgy/vzwnM78fHqOveWzlMcK4/XGOKSwvHcz/jEKExYX33e8B0m5FaDR5CHd83cD\nN7sdxM1tTl7egVJKdhqlcI3YWchxp8ubv++KSBN5NnWZvSFJFJ16BeKxZ5zUuJUw\nIammaVkCgYEA/wBOGpSP0j70L1YNovsyt0Z8Rn764El2xjARvFSGq11EQ4QViQ0B\nFh0EarxHi8XBK8ngf9o/fJJBhSftuRopNHk0l+gwwkds7Gu0tUp0T7H2x7hstWEM\nsGu4pws3TDxVjXnQ1wrcyvwx5ua+4OObHPI6YNVOH+LT1Qg+VsCO+N8CgYEA1V+O\norCTwxpOXj0FDz6fmD5lPr3vRuIrnuk3oA8feuqngkeLnjyT2MOiY3nyWDHAxdjM\niB0iYDg2hOZ0G33fkkQlVrISCbpFUBin0cGA0CiXoYLu4c3p2VkMjfOwCvTdQPBe\n1wXhQfJLrxyzBWacu86RtY/5/TWu7oCMdJaoBi8CgYEAohrRi/gxTZiTppvv41IJ\nNZVrX21NktNg3DCmtbCOQ9XwlXMcNZm8vRAJRMkYOnSmjm2xd9WIUmqvmDR/3RIS\na7c5hfAnPvok9k6p/C2urxMVLHXDNbLSXDy+kAKDTsV0JZHw/yN6pNeZ6Y16foBy\nlP4vumsfVQnfXCf3aTLUMMUCgYEAyUjbxZ3Nxr+KLlxh6X+qDnTODeIfVz8E52Qa\nlWOuzsWOP9g+XYfH8TScfDsN4yUMNZfPWpghVaOxyq2b2lNkFRc0IhTZ71NJD8Yy\nii2A1t10LWjW8SzO7bqTnVXFPJDCKACZdz6UwSFRRGBOgUnLkV/NFPo9WiDKZTPf\nTBzTZQECgYB0G46X7GHg9wJdIl7LPwTatloFMQ0U5vOXY4qOg9L8JmIm0FLaYQWU\nJGgbOnqrapS46a1VFLb5nubEl9nsZr0FFOJ0eINtmGIW/0JQ8RICVgowTEfl1d1Q\nano4hH3ZAVy6fOitGeIRHTwKeXt+TzKHV1Oggzfcg4wKcFFd9aO0dA==\n-----END RSA PRIVATE KEY-----
\.


--
-- Data for Name: environments; Type: TABLE DATA; Schema: public; Owner: chef-pgsql
--

COPY environments (id, owner, name, last_scan, compliance_status, patchlevel_status, unknown_status) FROM stdin;
86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ac36a30b-fe17-4684-54bf-2ed5501d6e7b	site_config	2016-08-17 16:10:56.611158+00	0	0.0134228189	0
ccba775a-8376-4210-6938-5275e192ec11	ac36a30b-fe17-4684-54bf-2ed5501d6e7b	windows	2016-08-17 16:20:21.030986+00	1	0	0
77528987-44b8-4322-6ae7-aa3ee87553c1	ac36a30b-fe17-4684-54bf-2ed5501d6e7b	ecommerce	2016-11-02 21:26:26.749595+00	1	0	0
\.


--
-- Data for Name: hardening_config; Type: TABLE DATA; Schema: public; Owner: chef-pgsql
--

COPY hardening_config (id, node, environment, owner, conf_owner, conf_profile, json_attribute, json_value) FROM stdin;
\.


--
-- Data for Name: job_runs; Type: TABLE DATA; Schema: public; Owner: chef-pgsql
--

COPY job_runs (job, owner, run_id, type, start) FROM stdin;
\.


--
-- Data for Name: job_tasks; Type: TABLE DATA; Schema: public; Owner: chef-pgsql
--

COPY job_tasks (id, job, owner, type, config) FROM stdin;
\.


--
-- Data for Name: jobs; Type: TABLE DATA; Schema: public; Owner: chef-pgsql
--

COPY jobs (id, owner, status, name, next_run, month, day_of_month, day_of_week, hour, minute, date) FROM stdin;
\.


--
-- Data for Name: nodes; Type: TABLE DATA; Schema: public; Owner: chef-pgsql
--

COPY nodes (id, environment, owner, name, hostname, login_method, login_user, login_password, login_key, login_port, disable_sudo, sudo_options, sudo_password, last_scan, last_scan_id, os_family, os_release, os_arch, compliance_status, patchlevel_status, unknown_status) FROM stdin;
c42d6910-6f13-43c7-5067-69d628fb1aed	77528987-44b8-4322-6ae7-aa3ee87553c1	ac36a30b-fe17-4684-54bf-2ed5501d6e7b	union.automate-demo.com	union.automate-demo.com	sshKey	ubuntu		2de3086b-3e02-4f32-76dc-a4898770e0ea	0	f			2016-11-02 21:26:26.749595+00	f9a766b4-9950-4f36-6c90-2eff1d972556	debian	14.04	x86_64	1	-1	0
cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ac36a30b-fe17-4684-54bf-2ed5501d6e7b	union.automate-demo.com	union.automate-demo.com	sshKey	ubuntu		2de3086b-3e02-4f32-76dc-a4898770e0ea	0	f			2016-08-17 16:10:56.611158+00	7bdfc437-dc36-4efe-77c7-0aae5672cf29	ubuntu	14.04		-1	0.0134228189	0
0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ac36a30b-fe17-4684-54bf-2ed5501d6e7b	delivered.automate-demo.com	delivered.automate-demo.com	sshKey	ubuntu		2de3086b-3e02-4f32-76dc-a4898770e0ea	0	f			2016-08-17 16:10:56.611158+00	7bdfc437-dc36-4efe-77c7-0aae5672cf29	ubuntu	14.04		-1	0.0134228189	0
ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ac36a30b-fe17-4684-54bf-2ed5501d6e7b	rehearsal.automate-demo.com	rehearsal.automate-demo.com	sshKey	ubuntu		2de3086b-3e02-4f32-76dc-a4898770e0ea	0	f			2016-08-17 16:10:56.611158+00	7bdfc437-dc36-4efe-77c7-0aae5672cf29	ubuntu	14.04		-1	0.0134228189	0
e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ac36a30b-fe17-4684-54bf-2ed5501d6e7b	acceptance.automate-demo.com	acceptance.automate-demo.com	sshKey	ubuntu		2de3086b-3e02-4f32-76dc-a4898770e0ea	0	f			2016-08-17 16:10:56.611158+00	7bdfc437-dc36-4efe-77c7-0aae5672cf29	ubuntu	14.04		-1	0.0134228189	0
c48446a6-cf9a-4b8c-587a-0f24b7b128d0	77528987-44b8-4322-6ae7-aa3ee87553c1	ac36a30b-fe17-4684-54bf-2ed5501d6e7b	delivered.automate-demo.com	delivered.automate-demo.com	sshKey	ubuntu		2de3086b-3e02-4f32-76dc-a4898770e0ea	0	f			2016-11-02 21:26:26.749595+00	f9a766b4-9950-4f36-6c90-2eff1d972556	debian	14.04	x86_64	1	-1	0
c958f232-6656-4bd8-58a9-85def6e7705a	ccba775a-8376-4210-6938-5275e192ec11	ac36a30b-fe17-4684-54bf-2ed5501d6e7b	Windows 2012 R2	172.31.54.201	winrm	Administrator	RL9@T40BTmXh		5985	f			2016-08-17 16:20:21.030986+00	b3d705aa-d756-4acb-4b12-a302bc36554f	windows	6.3.9600	64-bit	1	-1	0
ff0fe8f0-6059-4386-4287-d6636afaf6e0	77528987-44b8-4322-6ae7-aa3ee87553c1	ac36a30b-fe17-4684-54bf-2ed5501d6e7b	rehearsal.automate-demo.com	rehearsal.automate-demo.com	sshKey	ubuntu		2de3086b-3e02-4f32-76dc-a4898770e0ea	0	f			2016-11-02 21:26:26.749595+00	f9a766b4-9950-4f36-6c90-2eff1d972556	debian	14.04	x86_64	1	-1	0
0e711c41-418d-4fb4-4249-8eb6c3ba0f13	77528987-44b8-4322-6ae7-aa3ee87553c1	ac36a30b-fe17-4684-54bf-2ed5501d6e7b	ecomacceptance.automate-demo.com	ecomacceptance.automate-demo.com	sshKey	ubuntu		2de3086b-3e02-4f32-76dc-a4898770e0ea	0	f			2016-11-02 21:26:26.749595+00	f9a766b4-9950-4f36-6c90-2eff1d972556	debian	14.04	x86_64	1	-1	0
\.


--
-- Data for Name: owners; Type: TABLE DATA; Schema: public; Owner: chef-pgsql
--

COPY owners (id, pw, name, is_org, login, source) FROM stdin;
e3254379-4459-482e-6e63-549f2b646195	DKJT/7TtUNaIjiEWoG6/DEL7ai7i150lpgoc8I4v/wSJ2fFGM+gTSfILSF1YxZ/3AEAAAAgAAAABAAAA+WZfR1vcWDPI3rcLnmvY2KC67sIZltwIT/U3B1NiJtw=	admin	f	admin	\N
ac36a30b-fe17-4684-54bf-2ed5501d6e7b	kQ6PUkxwzIdpFKXkzqnOCWxDriCs9Aq+/X2g3LX6kyH4wG2wjwwD6Ld/MZgg7CrGAEAAAAgAAAABAAAA01xrPx6m/l9xkd3tXi7PmcVSzsrxEK0yFMwz+RGaNOU=	workstation-1	f	workstation-1	\N
\.


--
-- Data for Name: package_conf_profiles; Type: TABLE DATA; Schema: public; Owner: chef-pgsql
--

COPY package_conf_profiles (owner, id, release, name) FROM stdin;
\.


--
-- Data for Name: package_confs; Type: TABLE DATA; Schema: public; Owner: chef-pgsql
--

COPY package_confs (owner, profile, id, name, pkgversion, arch, repo, type, action, available_since, min_criticality, max_criticality) FROM stdin;
\.


--
-- Data for Name: packages_available; Type: TABLE DATA; Schema: public; Owner: chef-pgsql
--

COPY packages_available (criticality, oldversion, scan, node, environment, name, pkgversion, arch, repo, type) FROM stdin;
0.100000001	1:0.196.14	7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	update-manager-core	1:0.196.19	all	Ubuntu:14.04/trusty-updates	deb
0.100000001	1:0.196.14	7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python3-update-manager	1:0.196.19	all	Ubuntu:14.04/trusty-updates	deb
0.100000001	0.154.1ubuntu1	7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	update-notifier-common	0.154.1ubuntu2	all	Ubuntu:14.04/trusty-updates	deb
0.5	1:6.6p1-2ubuntu2.7	7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	openssh-sftp-server	1:6.6p1-2ubuntu2.8	amd64	Ubuntu:14.04/trusty-updates	deb
0.5	1:6.6p1-2ubuntu2.7	7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	openssh-server	1:6.6p1-2ubuntu2.8	amd64	Ubuntu:14.04/trusty-updates	deb
0.5	1:6.6p1-2ubuntu2.7	7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	openssh-client	1:6.6p1-2ubuntu2.8	amd64	Ubuntu:14.04/trusty-updates	deb
0.100000001	1:0.196.14	7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	update-manager-core	1:0.196.19	all	Ubuntu:14.04/trusty-updates	deb
0.100000001	1:0.196.14	7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python3-update-manager	1:0.196.19	all	Ubuntu:14.04/trusty-updates	deb
0.100000001	0.154.1ubuntu1	7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	update-notifier-common	0.154.1ubuntu2	all	Ubuntu:14.04/trusty-updates	deb
0.5	1:6.6p1-2ubuntu2.7	7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	openssh-sftp-server	1:6.6p1-2ubuntu2.8	amd64	Ubuntu:14.04/trusty-updates	deb
0.5	1:6.6p1-2ubuntu2.7	7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	openssh-server	1:6.6p1-2ubuntu2.8	amd64	Ubuntu:14.04/trusty-updates	deb
0.5	1:6.6p1-2ubuntu2.7	7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	openssh-client	1:6.6p1-2ubuntu2.8	amd64	Ubuntu:14.04/trusty-updates	deb
0.100000001	1:0.196.14	7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	update-manager-core	1:0.196.19	all	Ubuntu:14.04/trusty-updates	deb
0.100000001	1:0.196.14	7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python3-update-manager	1:0.196.19	all	Ubuntu:14.04/trusty-updates	deb
0.100000001	0.154.1ubuntu1	7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	update-notifier-common	0.154.1ubuntu2	all	Ubuntu:14.04/trusty-updates	deb
0.5	1:6.6p1-2ubuntu2.7	7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	openssh-sftp-server	1:6.6p1-2ubuntu2.8	amd64	Ubuntu:14.04/trusty-updates	deb
0.5	1:6.6p1-2ubuntu2.7	7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	openssh-server	1:6.6p1-2ubuntu2.8	amd64	Ubuntu:14.04/trusty-updates	deb
0.5	1:6.6p1-2ubuntu2.7	7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	openssh-client	1:6.6p1-2ubuntu2.8	amd64	Ubuntu:14.04/trusty-updates	deb
0.100000001	1:0.196.14	7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	update-manager-core	1:0.196.19	all	Ubuntu:14.04/trusty-updates	deb
0.100000001	1:0.196.14	7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python3-update-manager	1:0.196.19	all	Ubuntu:14.04/trusty-updates	deb
0.100000001	0.154.1ubuntu1	7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	update-notifier-common	0.154.1ubuntu2	all	Ubuntu:14.04/trusty-updates	deb
0.5	1:6.6p1-2ubuntu2.7	7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	openssh-sftp-server	1:6.6p1-2ubuntu2.8	amd64	Ubuntu:14.04/trusty-updates	deb
0.5	1:6.6p1-2ubuntu2.7	7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	openssh-server	1:6.6p1-2ubuntu2.8	amd64	Ubuntu:14.04/trusty-updates	deb
0.5	1:6.6p1-2ubuntu2.7	7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	openssh-client	1:6.6p1-2ubuntu2.8	amd64	Ubuntu:14.04/trusty-updates	deb
\.


--
-- Data for Name: packages_install; Type: TABLE DATA; Schema: public; Owner: chef-pgsql
--

COPY packages_install (node, environment, name, pkgversion, arch, repo, type, id, patch, owner) FROM stdin;
\.


--
-- Data for Name: packages_installed; Type: TABLE DATA; Schema: public; Owner: chef-pgsql
--

COPY packages_installed (scan, node, environment, name, pkgversion, arch, repo, type) FROM stdin;
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	accountsservice	0.6.35-0ubuntu7.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	acpid	1:2.0.21-1ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	adduser	3.113+nmu3ubuntu3	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	apparmor	2.8.95~2430-0ubuntu5.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	apport	2.14.1-0ubuntu3.21	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	apport-symptoms	0.20	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	apt	1.0.1ubuntu2.14	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	apt-transport-https	1.0.1ubuntu2.14	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	apt-utils	1.0.1ubuntu2.14	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	apt-xapian-index	0.45ubuntu4	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	aptitude	0.6.8.2-1ubuntu4	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	aptitude-common	0.6.8.2-1ubuntu4	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	at	3.1.14-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	base-files	7.2ubuntu5.5	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	base-passwd	3.5.33	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	bash	4.3-7ubuntu1.5	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	bash-completion	1:2.1-4ubuntu0.2	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	bc	1.06.95-8ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	bind9-host	1:9.9.5.dfsg-3ubuntu0.8	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	bsdmainutils	9.0.5ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	bsdutils	1:2.20.1-5.1ubuntu20.7	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	busybox-initramfs	1:1.21.0-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	busybox-static	1:1.21.0-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	byobu	5.77-0ubuntu1.2	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	bzip2	1.0.6-5	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ca-certificates	20160104ubuntu0.14.04.1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	chef	12.13.37-1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	cloud-guest-utils	0.27-0ubuntu9.2	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	cloud-init	0.7.5-0ubuntu1.19	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	command-not-found	0.3ubuntu12	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	command-not-found-data	0.3ubuntu12	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	console-setup	1.70ubuntu8	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	coreutils	8.21-1ubuntu5.4	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	cpio	2.11+dfsg-1ubuntu1.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	cron	3.0pl1-124ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	cryptsetup	2:1.6.1-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	cryptsetup-bin	2:1.6.1-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	curl	7.35.0-1ubuntu2.8	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	dash	0.5.7-4ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	dbus	1.6.18-0ubuntu4.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	debconf	1.5.51ubuntu2	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	debconf-i18n	1.5.51ubuntu2	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	debianutils	4.4	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	dh-python	1.20140128-1ubuntu8.2	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	diffutils	1:3.3-1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	dmidecode	2.12-2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	dmsetup	2:1.02.77-6ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	dnsutils	1:9.9.5.dfsg-3ubuntu0.8	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	dosfstools	3.0.26-1ubuntu0.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	dpkg	1.17.5ubuntu5.7	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	e2fslibs	1.42.9-3ubuntu1.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	e2fsprogs	1.42.9-3ubuntu1.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	eatmydata	26-2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ed	1.9-2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	eject	2.1.5+deb1+cvs20081104-13.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ethtool	1:3.13-1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	file	1:5.14-2ubuntu3.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	findutils	4.4.2-7	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	fonts-ubuntu-font-family-console	0.80-0ubuntu6	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	friendly-recovery	0.2.25	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ftp	0.17-28	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	fuse	2.9.2-4ubuntu4.14.04.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	gawk	1:4.0.1+dfsg-2.1ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	gcc-4.8-base	4.8.4-2ubuntu1~14.04.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	gcc-4.9-base	4.9.3-0ubuntu4	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	gdisk	0.8.8-1ubuntu0.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	geoip-database	20140313-1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	gettext-base	0.18.3.1-1ubuntu3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	gir1.2-glib-2.0	1.40.0-1ubuntu0.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	gnupg	1.4.16-1ubuntu2.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	gpgv	1.4.16-1ubuntu2.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	grep	2.16-1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	groff-base	1.22.2-5	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	grub-common	2.02~beta2-9ubuntu1.12	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	grub-gfxpayload-lists	0.6	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	grub-legacy-ec2	0.7.5-0ubuntu1.19	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	grub-pc	2.02~beta2-9ubuntu1.12	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	grub-pc-bin	2.02~beta2-9ubuntu1.12	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	grub2-common	2.02~beta2-9ubuntu1.12	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	gzip	1.6-3ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	hdparm	9.43-1ubuntu3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	hostname	3.15ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ifupdown	0.7.47.2ubuntu4.4	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	info	5.2.0.dfsg.1-2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	init-system-helpers	1.14	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	initramfs-tools	0.103ubuntu4.4	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	initramfs-tools-bin	0.103ubuntu4.4	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	initscripts	2.88dsf-41ubuntu6.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	insserv	1.14.0-5ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	install-info	5.2.0.dfsg.1-2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	iproute2	3.12.0-2ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	iptables	1.4.21-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	iputils-ping	3:20121221-4ubuntu1.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	iputils-tracepath	3:20121221-4ubuntu1.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	irqbalance	1.0.6-2ubuntu0.14.04.4	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	isc-dhcp-client	4.2.4-7ubuntu12.5	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	isc-dhcp-common	4.2.4-7ubuntu12.5	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	iso-codes	3.52-1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	kbd	1.15.5-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	keyboard-configuration	1.70ubuntu8	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	klibc-utils	2.0.3-0ubuntu1.14.04.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	kmod	15-0ubuntu6	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	krb5-locales	1.12+dfsg-2ubuntu5.2	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	landscape-client	14.12-0ubuntu0.14.04	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	landscape-common	14.12-0ubuntu0.14.04	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	language-selector-common	0.129.3	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	laptop-detect	0.13.7ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	less	458-2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libaccountsservice0	0.6.35-0ubuntu7.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libacl1	2.2.52-1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libapparmor-perl	2.8.95~2430-0ubuntu5.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libapparmor1	2.8.95~2430-0ubuntu5.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libapt-inst1.5	1.0.1ubuntu2.14	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libapt-pkg4.12	1.0.1ubuntu2.14	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libarchive-extract-perl	0.70-1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libasn1-8-heimdal	1.6~git20131207+dfsg-1ubuntu1.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libasprintf0c2	0.18.3.1-1ubuntu3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libattr1	1:2.4.47-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libaudit-common	1:2.3.2-2ubuntu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libaudit1	1:2.3.2-2ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libbind9-90	1:9.9.5.dfsg-3ubuntu0.8	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libblkid1	2.20.1-5.1ubuntu20.7	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libboost-iostreams1.54.0	1.54.0-4ubuntu3.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libbsd0	0.6.0-2ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libbz2-1.0	1.0.6-5	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libc-bin	2.19-0ubuntu6.9	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libc6	2.19-0ubuntu6.9	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libcap-ng0	0.7.3-1ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libcap2	1:2.24-0ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libcap2-bin	1:2.24-0ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libcgmanager0	0.24-0ubuntu7.5	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libck-connector0	0.4.5-3.1ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libclass-accessor-perl	0.34-1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libcomerr2	1.42.9-3ubuntu1.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libcryptsetup4	2:1.6.1-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libcurl3	7.35.0-1ubuntu2.8	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libcurl3-gnutls	7.35.0-1ubuntu2.8	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libcwidget3	0.5.16-3.5ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libdb5.3	5.3.28-3ubuntu3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libdbus-1-3	1.6.18-0ubuntu4.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libdbus-glib-1-2	0.100.2-1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libdebconfclient0	0.187ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libdevmapper1.02.1	2:1.02.77-6ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libdns100	1:9.9.5.dfsg-3ubuntu0.8	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libdrm2	2.4.67-1ubuntu0.14.04.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libdumbnet1	1.12-4build1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libedit2	3.1-20130712-2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libelf1	0.158-0ubuntu5.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libept1.4.12	1.0.12	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libestr0	0.1.9-0ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libevent-2.0-5	2.0.21-stable-1ubuntu1.14.04.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libexpat1	2.1.0-4ubuntu1.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libffi6	3.1~rc1+r3.0.13-12ubuntu0.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libfreetype6	2.5.2-1ubuntu2.5	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libfribidi0	0.19.6-1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libfuse2	2.9.2-4ubuntu4.14.04.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libgc1c2	1:7.2d-5ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libgcc1	1:4.9.3-0ubuntu4	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libgck-1-0	3.10.1-1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libgcr-3-common	3.10.1-1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libgcr-base-3-1	3.10.1-1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libgcrypt11	1.5.3-2ubuntu4.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libgdbm3	1.8.3-12build1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libgeoip1	1.6.0-1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libgirepository-1.0-1	1.40.0-1ubuntu0.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libglib2.0-0	2.40.2-0ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libglib2.0-data	2.40.2-0ubuntu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libgnutls-openssl27	2.12.23-12ubuntu2.5	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libgnutls26	2.12.23-12ubuntu2.5	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libgpg-error0	1.12-0.2ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libgpm2	1.20.4-6.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libgssapi-krb5-2	1.12+dfsg-2ubuntu5.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libgssapi3-heimdal	1.6~git20131207+dfsg-1ubuntu1.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libhcrypto4-heimdal	1.6~git20131207+dfsg-1ubuntu1.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libheimbase1-heimdal	1.6~git20131207+dfsg-1ubuntu1.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libheimntlm0-heimdal	1.6~git20131207+dfsg-1ubuntu1.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libhx509-5-heimdal	1.6~git20131207+dfsg-1ubuntu1.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libicu52	52.1-3ubuntu0.4	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libidn11	1.28-1ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libio-string-perl	1.08-3	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libisc95	1:9.9.5.dfsg-3ubuntu0.8	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libisccc90	1:9.9.5.dfsg-3ubuntu0.8	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libisccfg90	1:9.9.5.dfsg-3ubuntu0.8	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libjson-c2	0.11-3ubuntu1.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libjson0	0.11-3ubuntu1.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libk5crypto3	1.12+dfsg-2ubuntu5.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libkeyutils1	1.5.6-1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libklibc	2.0.3-0ubuntu1.14.04.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libkmod2	15-0ubuntu6	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libkrb5-26-heimdal	1.6~git20131207+dfsg-1ubuntu1.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libkrb5-3	1.12+dfsg-2ubuntu5.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libkrb5support0	1.12+dfsg-2ubuntu5.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libldap-2.4-2	2.4.31-1+nmu2ubuntu8.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	liblocale-gettext-perl	1.05-7build3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	liblockfile-bin	1.09-6ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	liblockfile1	1.09-6ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	liblog-message-simple-perl	0.10-1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	liblwres90	1:9.9.5.dfsg-3ubuntu0.8	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	liblzma5	5.1.1alpha+20120614-2ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libmagic1	1:5.14-2ubuntu3.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libmodule-pluggable-perl	5.1-1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libmount1	2.20.1-5.1ubuntu20.7	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libmpdec2	2.4.0-6	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libncurses5	5.9+20140118-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libncursesw5	5.9+20140118-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libnewt0.52	0.52.15-2ubuntu5	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libnfnetlink0	1.0.1-2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libnih-dbus1	1.0.3-4ubuntu25	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libnih1	1.0.3-4ubuntu25	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libnuma1	2.0.9~rc5-1ubuntu3.14.04.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libp11-kit0	0.20.2-2ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpam-cap	1:2.24-0ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpam-modules	1.1.8-1ubuntu2.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpam-modules-bin	1.1.8-1ubuntu2.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpam-runtime	1.1.8-1ubuntu2.2	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpam-systemd	204-5ubuntu20.19	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpam0g	1.1.8-1ubuntu2.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libparse-debianchangelog-perl	1.2.0-1ubuntu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libparted0debian1	2.3-19ubuntu1.14.04.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpcap0.8	1.5.3-2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpci3	1:3.2.1-1ubuntu5.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpcre3	1:8.31-2ubuntu2.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpipeline1	1.3.0-1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libplymouth2	0.8.8-0ubuntu17.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpng12-0	1.2.50-1ubuntu2.14.04.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpod-latex-perl	0.61-1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpolkit-agent-1-0	0.105-4ubuntu3.14.04.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpolkit-backend-1-0	0.105-4ubuntu3.14.04.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpolkit-gobject-1-0	0.105-4ubuntu3.14.04.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpopt0	1.16-8ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libprocps3	1:3.3.9-1ubuntu2.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpython-stdlib	2.7.5-5ubuntu3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpython2.7	2.7.6-8ubuntu0.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpython2.7-minimal	2.7.6-8ubuntu0.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpython2.7-stdlib	2.7.6-8ubuntu0.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpython3-stdlib	3.4.0-0ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpython3.4-minimal	3.4.3-1ubuntu1~14.04.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpython3.4-stdlib	3.4.3-1ubuntu1~14.04.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libreadline6	6.3-4ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libroken18-heimdal	1.6~git20131207+dfsg-1ubuntu1.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	librtmp0	2.4+20121230.gitdf6c518-1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libsasl2-2	2.1.25.dfsg1-17build1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libsasl2-modules	2.1.25.dfsg1-17build1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libsasl2-modules-db	2.1.25.dfsg1-17build1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libselinux1	2.2.2-1ubuntu0.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libsemanage-common	2.2-1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libsemanage1	2.2-1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libsepol1	2.2-1ubuntu0.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libsigc++-2.0-0c2a	2.2.10-0.2ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libsigsegv2	2.10-2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libslang2	2.2.4-15ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libsqlite3-0	3.8.2-1ubuntu2.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libss2	1.42.9-3ubuntu1.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libssl1.0.0	1.0.1f-1ubuntu2.19	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libstdc++6	4.8.4-2ubuntu1~14.04.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libsub-name-perl	0.05-1build4	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libsystemd-daemon0	204-5ubuntu20.19	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libsystemd-login0	204-5ubuntu20.19	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libtasn1-6	3.4-3ubuntu0.4	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libterm-ui-perl	0.42-1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libtext-charwidth-perl	0.04-7build3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libtext-iconv-perl	1.7-5build2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libtext-soundex-perl	3.4-1build1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libtext-wrapi18n-perl	0.06-7	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libtimedate-perl	2.3000-1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libtinfo5	5.9+20140118-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libudev1	204-5ubuntu20.19	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libusb-0.1-4	2:0.1.12-23.3ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libusb-1.0-0	2:1.0.17-1ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libustr-1.0-1	1.0.4-3ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libuuid1	2.20.1-5.1ubuntu20.7	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libwind0-heimdal	1.6~git20131207+dfsg-1ubuntu1.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libwrap0	7.6.q-25	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libx11-6	2:1.6.2-1ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libx11-data	2:1.6.2-1ubuntu2	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libxapian22	1.2.16-2ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libxau6	1:1.0.8-1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libxcb1	1.10-2ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libxdmcp6	1:1.1.1-1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libxext6	2:1.3.2-1ubuntu0.0.14.04.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libxml2	2.9.1+dfsg1-3ubuntu4.8	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libxmuu1	2:1.1.1-1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libxtables10	1.4.21-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libyaml-0-2	0.1.4-3ubuntu3.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	linux-headers-3.13.0-93	3.13.0-93.140	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	linux-headers-3.13.0-93-generic	3.13.0-93.140	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	linux-headers-generic	3.13.0.93.100	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	linux-headers-virtual	3.13.0.93.100	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	linux-image-3.13.0-93-generic	3.13.0-93.140	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	linux-image-virtual	3.13.0.93.100	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	linux-virtual	3.13.0.93.100	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	locales	2.13+git20120306-12.1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	lockfile-progs	0.1.17	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	login	1:4.1.5.1-1ubuntu9.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	logrotate	3.8.7-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	lsb-base	4.1+Debian11ubuntu6.1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	lsb-release	4.1+Debian11ubuntu6.1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	lshw	02.16-2ubuntu1.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	lsof	4.86+dfsg-1ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ltrace	0.7.3-4ubuntu5.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	makedev	2.3.1-93ubuntu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	man-db	2.6.7.1-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	manpages	3.54-1ubuntu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	mawk	1.3.3-17ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	mime-support	3.54ubuntu1.1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	mlocate	0.26-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	module-init-tools	15-0ubuntu6	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	mount	2.20.1-5.1ubuntu20.7	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	mountall	2.53	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	mtr-tiny	0.85-2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	multiarch-support	2.19-0ubuntu6.9	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	nano	2.2.6-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ncurses-base	5.9+20140118-1ubuntu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ncurses-bin	5.9+20140118-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ncurses-term	5.9+20140118-1ubuntu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	net-tools	1.60-25ubuntu2.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	netbase	5.2	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	netcat-openbsd	1.105-7ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ntfs-3g	1:2013.1.13AR.1-2ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ntpdate	1:4.2.6.p5+dfsg-3ubuntu2.14.04.8	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	open-vm-tools	2:9.4.0-1280544-5ubuntu6.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	openssh-client	1:6.6p1-2ubuntu2.7	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	openssh-server	1:6.6p1-2ubuntu2.7	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	openssh-sftp-server	1:6.6p1-2ubuntu2.7	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	openssl	1.0.1f-1ubuntu2.19	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	os-prober	1.63ubuntu1.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	overlayroot	0.25ubuntu1.14.04.1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	parted	2.3-19ubuntu1.14.04.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	passwd	1:4.1.5.1-1ubuntu9.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	patch	2.7.1-4ubuntu2.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	pciutils	1:3.2.1-1ubuntu5.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	perl	5.18.2-2ubuntu1.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	perl-base	5.18.2-2ubuntu1.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	perl-modules	5.18.2-2ubuntu1.1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	plymouth	0.8.8-0ubuntu17.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	plymouth-theme-ubuntu-text	0.8.8-0ubuntu17.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	policykit-1	0.105-4ubuntu3.14.04.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	pollinate	4.7-0ubuntu1.4	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	popularity-contest	1.57ubuntu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	powermgmt-base	1.31build1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ppp	2.4.5-5.1ubuntu2.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	pppconfig	2.3.19ubuntu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	pppoeconf	1.20ubuntu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	procps	1:3.3.9-1ubuntu2.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	psmisc	22.20-1ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	push-jobs-client	2.1.1-1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python	2.7.5-5ubuntu3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-apt	0.9.3.5ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-apt-common	0.9.3.5ubuntu2	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-chardet	2.0.1-2build2	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-cheetah	2.4.4-3.fakesyncbuild1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-configobj	4.7.2+ds-5build1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-debian	0.1.21+nmu2ubuntu2	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-gdbm	2.7.5-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-json-pointer	1.0-2build1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-jsonpatch	1.3-4	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-minimal	2.7.5-5ubuntu3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-oauth	1.0.1-3build2	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-openssl	0.13-2ubuntu6	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-pam	0.4.2-13.1ubuntu3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-pkg-resources	3.3-1ubuntu2	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-prettytable	0.7.2-2ubuntu2	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-pycurl	7.19.3-0ubuntu3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-requests	2.2.1-1ubuntu0.3	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-serial	2.6-1build1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-six	1.5.2-1ubuntu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-twisted-bin	13.2.0-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-twisted-core	13.2.0-1ubuntu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-twisted-names	13.2.0-1ubuntu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-twisted-web	13.2.0-1ubuntu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-urllib3	1.7.1-1ubuntu4	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-xapian	1.2.16-2ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-yaml	3.10-4ubuntu0.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-zope.interface	4.0.5-1ubuntu4	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python2.7	2.7.6-8ubuntu0.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python2.7-minimal	2.7.6-8ubuntu0.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python3	3.4.0-0ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python3-apport	2.14.1-0ubuntu3.21	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python3-apt	0.9.3.5ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python3-commandnotfound	0.3ubuntu12	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python3-dbus	1.2.0-2build2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python3-distupgrade	1:0.220.8	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python3-gdbm	3.4.3-1~14.04.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python3-gi	3.12.0-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python3-minimal	3.4.0-0ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python3-newt	0.52.15-2ubuntu5	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python3-problem-report	2.14.1-0ubuntu3.21	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python3-pycurl	7.19.3-0ubuntu3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python3-software-properties	0.92.37.7	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python3-update-manager	1:0.196.14	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python3.4	3.4.3-1ubuntu1~14.04.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python3.4-minimal	3.4.3-1ubuntu1~14.04.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	readline-common	6.3-4ubuntu2	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	resolvconf	1.69ubuntu1.1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	rsync	3.1.0-2ubuntu0.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	rsyslog	7.4.4-1ubuntu2.6	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	run-one	1.17-0ubuntu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	screen	4.1.0~20120320gitdb59704-9	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	sed	4.2.2-4ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	sensible-utils	0.0.9	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	sgml-base	1.26+nmu4ubuntu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	shared-mime-info	1.2-0ubuntu3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	software-properties-common	0.92.37.7	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ssh-import-id	3.21-0ubuntu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	strace	4.8-1ubuntu5	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	sudo	1.8.9p5-1ubuntu1.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	systemd-services	204-5ubuntu20.19	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	systemd-shim	6-2bzr1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	sysv-rc	2.88dsf-41ubuntu6.3	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	sysvinit-utils	2.88dsf-41ubuntu6.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	tar	1.27.1-1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	tasksel	2.88ubuntu15	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	tasksel-data	2.88ubuntu15	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	tcpd	7.6.q-25	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	tcpdump	4.5.1-2ubuntu1.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	telnet	0.17-36build2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	time	1.7-24	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	tmux	1.8-5	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	tzdata	2016f-0ubuntu0.14.04	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ubuntu-keyring	2012.05.19	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ubuntu-minimal	1.325	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ubuntu-release-upgrader-core	1:0.220.8	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ubuntu-standard	1.325	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ucf	3.0027+nmu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	udev	204-5ubuntu20.19	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ufw	0.34~rc-0ubuntu2	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	unattended-upgrades	0.82.1ubuntu2.4	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	update-manager-core	1:0.196.14	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	update-notifier-common	0.154.1ubuntu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	upstart	1.12.1-0ubuntu4.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ureadahead	0.100.0-16	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	usbutils	1:007-2ubuntu1.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	util-linux	2.20.1-5.1ubuntu20.7	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	uuid-runtime	2.20.1-5.1ubuntu20.7	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	vim	2:7.4.052-1ubuntu3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	vim-common	2:7.4.052-1ubuntu3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	vim-runtime	2:7.4.052-1ubuntu3	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	vim-tiny	2:7.4.052-1ubuntu3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	w3m	0.5.3-15	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	wget	1.15-1ubuntu1.14.04.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	whiptail	0.52.15-2ubuntu5	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	xauth	1:1.0.7-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	xkb-data	2.10.1-1ubuntu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	xml-core	0.13+nmu2	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	xz-utils	5.1.1alpha+20120614-2ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	zerofree	1.0.2-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	cd9bf95f-f2e7-467c-5738-15b322e0ba65	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	zlib1g	1:1.2.8.dfsg-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	accountsservice	0.6.35-0ubuntu7.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	acpid	1:2.0.21-1ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	adduser	3.113+nmu3ubuntu3	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	apparmor	2.8.95~2430-0ubuntu5.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	apport	2.14.1-0ubuntu3.21	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	apport-symptoms	0.20	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	apt	1.0.1ubuntu2.14	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	apt-transport-https	1.0.1ubuntu2.14	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	apt-utils	1.0.1ubuntu2.14	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	apt-xapian-index	0.45ubuntu4	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	aptitude	0.6.8.2-1ubuntu4	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	aptitude-common	0.6.8.2-1ubuntu4	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	at	3.1.14-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	base-files	7.2ubuntu5.5	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	base-passwd	3.5.33	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	bash	4.3-7ubuntu1.5	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	bash-completion	1:2.1-4ubuntu0.2	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	bc	1.06.95-8ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	bind9-host	1:9.9.5.dfsg-3ubuntu0.8	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	bsdmainutils	9.0.5ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	bsdutils	1:2.20.1-5.1ubuntu20.7	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	busybox-initramfs	1:1.21.0-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	busybox-static	1:1.21.0-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	byobu	5.77-0ubuntu1.2	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	bzip2	1.0.6-5	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ca-certificates	20160104ubuntu0.14.04.1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	chef	12.13.37-1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	cloud-guest-utils	0.27-0ubuntu9.2	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	cloud-init	0.7.5-0ubuntu1.19	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	command-not-found	0.3ubuntu12	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	command-not-found-data	0.3ubuntu12	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	console-setup	1.70ubuntu8	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	coreutils	8.21-1ubuntu5.4	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	cpio	2.11+dfsg-1ubuntu1.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	cron	3.0pl1-124ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	cryptsetup	2:1.6.1-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	cryptsetup-bin	2:1.6.1-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	curl	7.35.0-1ubuntu2.8	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	dash	0.5.7-4ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	dbus	1.6.18-0ubuntu4.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	debconf	1.5.51ubuntu2	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	debconf-i18n	1.5.51ubuntu2	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	debianutils	4.4	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	dh-python	1.20140128-1ubuntu8.2	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	diffutils	1:3.3-1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	dmidecode	2.12-2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	dmsetup	2:1.02.77-6ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	dnsutils	1:9.9.5.dfsg-3ubuntu0.8	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	dosfstools	3.0.26-1ubuntu0.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	dpkg	1.17.5ubuntu5.7	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	e2fslibs	1.42.9-3ubuntu1.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	e2fsprogs	1.42.9-3ubuntu1.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	eatmydata	26-2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ed	1.9-2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	eject	2.1.5+deb1+cvs20081104-13.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ethtool	1:3.13-1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	file	1:5.14-2ubuntu3.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	findutils	4.4.2-7	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	fonts-ubuntu-font-family-console	0.80-0ubuntu6	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	friendly-recovery	0.2.25	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ftp	0.17-28	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	fuse	2.9.2-4ubuntu4.14.04.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	gawk	1:4.0.1+dfsg-2.1ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	gcc-4.8-base	4.8.4-2ubuntu1~14.04.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	gcc-4.9-base	4.9.3-0ubuntu4	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	gdisk	0.8.8-1ubuntu0.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	geoip-database	20140313-1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	gettext-base	0.18.3.1-1ubuntu3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	gir1.2-glib-2.0	1.40.0-1ubuntu0.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	gnupg	1.4.16-1ubuntu2.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	gpgv	1.4.16-1ubuntu2.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	grep	2.16-1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	groff-base	1.22.2-5	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	grub-common	2.02~beta2-9ubuntu1.12	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	grub-gfxpayload-lists	0.6	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	grub-legacy-ec2	0.7.5-0ubuntu1.19	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	grub-pc	2.02~beta2-9ubuntu1.12	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	grub-pc-bin	2.02~beta2-9ubuntu1.12	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	grub2-common	2.02~beta2-9ubuntu1.12	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	gzip	1.6-3ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	hdparm	9.43-1ubuntu3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	hostname	3.15ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ifupdown	0.7.47.2ubuntu4.4	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	info	5.2.0.dfsg.1-2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	init-system-helpers	1.14	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	initramfs-tools	0.103ubuntu4.4	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	initramfs-tools-bin	0.103ubuntu4.4	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	initscripts	2.88dsf-41ubuntu6.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	insserv	1.14.0-5ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	install-info	5.2.0.dfsg.1-2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	iproute2	3.12.0-2ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	iptables	1.4.21-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	iputils-ping	3:20121221-4ubuntu1.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	iputils-tracepath	3:20121221-4ubuntu1.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	irqbalance	1.0.6-2ubuntu0.14.04.4	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	isc-dhcp-client	4.2.4-7ubuntu12.5	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	isc-dhcp-common	4.2.4-7ubuntu12.5	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	iso-codes	3.52-1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	kbd	1.15.5-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	keyboard-configuration	1.70ubuntu8	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	klibc-utils	2.0.3-0ubuntu1.14.04.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	kmod	15-0ubuntu6	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	krb5-locales	1.12+dfsg-2ubuntu5.2	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	landscape-client	14.12-0ubuntu0.14.04	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	landscape-common	14.12-0ubuntu0.14.04	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	language-selector-common	0.129.3	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	laptop-detect	0.13.7ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	less	458-2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libaccountsservice0	0.6.35-0ubuntu7.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libacl1	2.2.52-1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libapparmor-perl	2.8.95~2430-0ubuntu5.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libapparmor1	2.8.95~2430-0ubuntu5.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libapt-inst1.5	1.0.1ubuntu2.14	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libapt-pkg4.12	1.0.1ubuntu2.14	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libarchive-extract-perl	0.70-1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libasn1-8-heimdal	1.6~git20131207+dfsg-1ubuntu1.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libasprintf0c2	0.18.3.1-1ubuntu3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libattr1	1:2.4.47-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libaudit-common	1:2.3.2-2ubuntu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libaudit1	1:2.3.2-2ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libbind9-90	1:9.9.5.dfsg-3ubuntu0.8	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libblkid1	2.20.1-5.1ubuntu20.7	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libboost-iostreams1.54.0	1.54.0-4ubuntu3.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libbsd0	0.6.0-2ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libbz2-1.0	1.0.6-5	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libc-bin	2.19-0ubuntu6.9	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libc6	2.19-0ubuntu6.9	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libcap-ng0	0.7.3-1ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libcap2	1:2.24-0ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libcap2-bin	1:2.24-0ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libcgmanager0	0.24-0ubuntu7.5	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libck-connector0	0.4.5-3.1ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libclass-accessor-perl	0.34-1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libcomerr2	1.42.9-3ubuntu1.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libcryptsetup4	2:1.6.1-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libcurl3	7.35.0-1ubuntu2.8	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libcurl3-gnutls	7.35.0-1ubuntu2.8	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libcwidget3	0.5.16-3.5ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libdb5.3	5.3.28-3ubuntu3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libdbus-1-3	1.6.18-0ubuntu4.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libdbus-glib-1-2	0.100.2-1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libdebconfclient0	0.187ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libdevmapper1.02.1	2:1.02.77-6ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libdns100	1:9.9.5.dfsg-3ubuntu0.8	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libdrm2	2.4.67-1ubuntu0.14.04.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libdumbnet1	1.12-4build1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libedit2	3.1-20130712-2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libelf1	0.158-0ubuntu5.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libept1.4.12	1.0.12	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libestr0	0.1.9-0ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libevent-2.0-5	2.0.21-stable-1ubuntu1.14.04.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libexpat1	2.1.0-4ubuntu1.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libffi6	3.1~rc1+r3.0.13-12ubuntu0.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libfreetype6	2.5.2-1ubuntu2.5	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libfribidi0	0.19.6-1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libfuse2	2.9.2-4ubuntu4.14.04.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libgc1c2	1:7.2d-5ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libgcc1	1:4.9.3-0ubuntu4	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libgck-1-0	3.10.1-1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libgcr-3-common	3.10.1-1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libgcr-base-3-1	3.10.1-1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libgcrypt11	1.5.3-2ubuntu4.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libgdbm3	1.8.3-12build1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libgeoip1	1.6.0-1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libgirepository-1.0-1	1.40.0-1ubuntu0.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libglib2.0-0	2.40.2-0ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libglib2.0-data	2.40.2-0ubuntu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libgnutls-openssl27	2.12.23-12ubuntu2.5	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libgnutls26	2.12.23-12ubuntu2.5	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libgpg-error0	1.12-0.2ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libgpm2	1.20.4-6.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libgssapi-krb5-2	1.12+dfsg-2ubuntu5.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libgssapi3-heimdal	1.6~git20131207+dfsg-1ubuntu1.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libhcrypto4-heimdal	1.6~git20131207+dfsg-1ubuntu1.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libheimbase1-heimdal	1.6~git20131207+dfsg-1ubuntu1.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libheimntlm0-heimdal	1.6~git20131207+dfsg-1ubuntu1.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libhx509-5-heimdal	1.6~git20131207+dfsg-1ubuntu1.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libicu52	52.1-3ubuntu0.4	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libidn11	1.28-1ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libio-string-perl	1.08-3	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libisc95	1:9.9.5.dfsg-3ubuntu0.8	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libisccc90	1:9.9.5.dfsg-3ubuntu0.8	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libisccfg90	1:9.9.5.dfsg-3ubuntu0.8	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libjson-c2	0.11-3ubuntu1.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libjson0	0.11-3ubuntu1.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libk5crypto3	1.12+dfsg-2ubuntu5.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libkeyutils1	1.5.6-1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libklibc	2.0.3-0ubuntu1.14.04.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libkmod2	15-0ubuntu6	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libkrb5-26-heimdal	1.6~git20131207+dfsg-1ubuntu1.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libkrb5-3	1.12+dfsg-2ubuntu5.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libkrb5support0	1.12+dfsg-2ubuntu5.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libldap-2.4-2	2.4.31-1+nmu2ubuntu8.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	liblocale-gettext-perl	1.05-7build3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	liblockfile-bin	1.09-6ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	liblockfile1	1.09-6ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	liblog-message-simple-perl	0.10-1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	liblwres90	1:9.9.5.dfsg-3ubuntu0.8	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	liblzma5	5.1.1alpha+20120614-2ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libmagic1	1:5.14-2ubuntu3.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libmodule-pluggable-perl	5.1-1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libmount1	2.20.1-5.1ubuntu20.7	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libmpdec2	2.4.0-6	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libncurses5	5.9+20140118-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libncursesw5	5.9+20140118-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libnewt0.52	0.52.15-2ubuntu5	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libnfnetlink0	1.0.1-2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libnih-dbus1	1.0.3-4ubuntu25	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libnih1	1.0.3-4ubuntu25	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libnuma1	2.0.9~rc5-1ubuntu3.14.04.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libp11-kit0	0.20.2-2ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpam-cap	1:2.24-0ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpam-modules	1.1.8-1ubuntu2.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpam-modules-bin	1.1.8-1ubuntu2.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpam-runtime	1.1.8-1ubuntu2.2	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpam-systemd	204-5ubuntu20.19	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpam0g	1.1.8-1ubuntu2.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libparse-debianchangelog-perl	1.2.0-1ubuntu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libparted0debian1	2.3-19ubuntu1.14.04.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpcap0.8	1.5.3-2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpci3	1:3.2.1-1ubuntu5.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpcre3	1:8.31-2ubuntu2.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpipeline1	1.3.0-1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libplymouth2	0.8.8-0ubuntu17.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpng12-0	1.2.50-1ubuntu2.14.04.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpod-latex-perl	0.61-1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpolkit-agent-1-0	0.105-4ubuntu3.14.04.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpolkit-backend-1-0	0.105-4ubuntu3.14.04.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpolkit-gobject-1-0	0.105-4ubuntu3.14.04.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpopt0	1.16-8ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libprocps3	1:3.3.9-1ubuntu2.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpython-stdlib	2.7.5-5ubuntu3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpython2.7	2.7.6-8ubuntu0.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpython2.7-minimal	2.7.6-8ubuntu0.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpython2.7-stdlib	2.7.6-8ubuntu0.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpython3-stdlib	3.4.0-0ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpython3.4-minimal	3.4.3-1ubuntu1~14.04.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpython3.4-stdlib	3.4.3-1ubuntu1~14.04.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libreadline6	6.3-4ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libroken18-heimdal	1.6~git20131207+dfsg-1ubuntu1.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	librtmp0	2.4+20121230.gitdf6c518-1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libsasl2-2	2.1.25.dfsg1-17build1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libsasl2-modules	2.1.25.dfsg1-17build1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libsasl2-modules-db	2.1.25.dfsg1-17build1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libselinux1	2.2.2-1ubuntu0.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libsemanage-common	2.2-1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libsemanage1	2.2-1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libsepol1	2.2-1ubuntu0.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libsigc++-2.0-0c2a	2.2.10-0.2ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libsigsegv2	2.10-2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libslang2	2.2.4-15ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libsqlite3-0	3.8.2-1ubuntu2.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libss2	1.42.9-3ubuntu1.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libssl1.0.0	1.0.1f-1ubuntu2.19	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libstdc++6	4.8.4-2ubuntu1~14.04.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libsub-name-perl	0.05-1build4	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libsystemd-daemon0	204-5ubuntu20.19	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libsystemd-login0	204-5ubuntu20.19	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libtasn1-6	3.4-3ubuntu0.4	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libterm-ui-perl	0.42-1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libtext-charwidth-perl	0.04-7build3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libtext-iconv-perl	1.7-5build2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libtext-soundex-perl	3.4-1build1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libtext-wrapi18n-perl	0.06-7	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libtimedate-perl	2.3000-1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libtinfo5	5.9+20140118-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libudev1	204-5ubuntu20.19	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libusb-0.1-4	2:0.1.12-23.3ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libusb-1.0-0	2:1.0.17-1ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libustr-1.0-1	1.0.4-3ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libuuid1	2.20.1-5.1ubuntu20.7	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libwind0-heimdal	1.6~git20131207+dfsg-1ubuntu1.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libwrap0	7.6.q-25	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libx11-6	2:1.6.2-1ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libx11-data	2:1.6.2-1ubuntu2	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libxapian22	1.2.16-2ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libxau6	1:1.0.8-1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libxcb1	1.10-2ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libxdmcp6	1:1.1.1-1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libxext6	2:1.3.2-1ubuntu0.0.14.04.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libxml2	2.9.1+dfsg1-3ubuntu4.8	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libxmuu1	2:1.1.1-1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libxtables10	1.4.21-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libyaml-0-2	0.1.4-3ubuntu3.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	linux-headers-3.13.0-93	3.13.0-93.140	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	linux-headers-3.13.0-93-generic	3.13.0-93.140	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	linux-headers-generic	3.13.0.93.100	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	linux-headers-virtual	3.13.0.93.100	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	linux-image-3.13.0-93-generic	3.13.0-93.140	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	linux-image-virtual	3.13.0.93.100	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	linux-virtual	3.13.0.93.100	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	locales	2.13+git20120306-12.1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	lockfile-progs	0.1.17	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	login	1:4.1.5.1-1ubuntu9.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	logrotate	3.8.7-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	lsb-base	4.1+Debian11ubuntu6.1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	lsb-release	4.1+Debian11ubuntu6.1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	lshw	02.16-2ubuntu1.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	lsof	4.86+dfsg-1ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ltrace	0.7.3-4ubuntu5.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	makedev	2.3.1-93ubuntu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	man-db	2.6.7.1-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	manpages	3.54-1ubuntu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	mawk	1.3.3-17ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	mime-support	3.54ubuntu1.1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	mlocate	0.26-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	module-init-tools	15-0ubuntu6	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	mount	2.20.1-5.1ubuntu20.7	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	mountall	2.53	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	mtr-tiny	0.85-2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	multiarch-support	2.19-0ubuntu6.9	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	nano	2.2.6-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ncurses-base	5.9+20140118-1ubuntu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ncurses-bin	5.9+20140118-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ncurses-term	5.9+20140118-1ubuntu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	net-tools	1.60-25ubuntu2.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	netbase	5.2	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	netcat-openbsd	1.105-7ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ntfs-3g	1:2013.1.13AR.1-2ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ntpdate	1:4.2.6.p5+dfsg-3ubuntu2.14.04.8	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	open-vm-tools	2:9.4.0-1280544-5ubuntu6.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	openssh-client	1:6.6p1-2ubuntu2.7	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	openssh-server	1:6.6p1-2ubuntu2.7	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	openssh-sftp-server	1:6.6p1-2ubuntu2.7	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	openssl	1.0.1f-1ubuntu2.19	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	os-prober	1.63ubuntu1.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	overlayroot	0.25ubuntu1.14.04.1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	parted	2.3-19ubuntu1.14.04.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	passwd	1:4.1.5.1-1ubuntu9.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	patch	2.7.1-4ubuntu2.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	pciutils	1:3.2.1-1ubuntu5.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	perl	5.18.2-2ubuntu1.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	perl-base	5.18.2-2ubuntu1.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	perl-modules	5.18.2-2ubuntu1.1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	plymouth	0.8.8-0ubuntu17.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	plymouth-theme-ubuntu-text	0.8.8-0ubuntu17.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	policykit-1	0.105-4ubuntu3.14.04.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	pollinate	4.7-0ubuntu1.4	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	popularity-contest	1.57ubuntu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	powermgmt-base	1.31build1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ppp	2.4.5-5.1ubuntu2.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	pppconfig	2.3.19ubuntu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	pppoeconf	1.20ubuntu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	procps	1:3.3.9-1ubuntu2.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	psmisc	22.20-1ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	push-jobs-client	2.1.1-1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python	2.7.5-5ubuntu3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-apt	0.9.3.5ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-apt-common	0.9.3.5ubuntu2	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-chardet	2.0.1-2build2	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-cheetah	2.4.4-3.fakesyncbuild1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-configobj	4.7.2+ds-5build1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-debian	0.1.21+nmu2ubuntu2	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-gdbm	2.7.5-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-json-pointer	1.0-2build1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-jsonpatch	1.3-4	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-minimal	2.7.5-5ubuntu3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-oauth	1.0.1-3build2	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-openssl	0.13-2ubuntu6	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-pam	0.4.2-13.1ubuntu3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-pkg-resources	3.3-1ubuntu2	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-prettytable	0.7.2-2ubuntu2	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-pycurl	7.19.3-0ubuntu3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-requests	2.2.1-1ubuntu0.3	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-serial	2.6-1build1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-six	1.5.2-1ubuntu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-twisted-bin	13.2.0-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-twisted-core	13.2.0-1ubuntu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-twisted-names	13.2.0-1ubuntu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-twisted-web	13.2.0-1ubuntu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-urllib3	1.7.1-1ubuntu4	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-xapian	1.2.16-2ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-yaml	3.10-4ubuntu0.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-zope.interface	4.0.5-1ubuntu4	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python2.7	2.7.6-8ubuntu0.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python2.7-minimal	2.7.6-8ubuntu0.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python3	3.4.0-0ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python3-apport	2.14.1-0ubuntu3.21	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python3-apt	0.9.3.5ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python3-commandnotfound	0.3ubuntu12	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python3-dbus	1.2.0-2build2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python3-distupgrade	1:0.220.8	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python3-gdbm	3.4.3-1~14.04.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python3-gi	3.12.0-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python3-minimal	3.4.0-0ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python3-newt	0.52.15-2ubuntu5	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python3-problem-report	2.14.1-0ubuntu3.21	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python3-pycurl	7.19.3-0ubuntu3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python3-software-properties	0.92.37.7	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python3-update-manager	1:0.196.14	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python3.4	3.4.3-1ubuntu1~14.04.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python3.4-minimal	3.4.3-1ubuntu1~14.04.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	readline-common	6.3-4ubuntu2	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	resolvconf	1.69ubuntu1.1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	rsync	3.1.0-2ubuntu0.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	rsyslog	7.4.4-1ubuntu2.6	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	run-one	1.17-0ubuntu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	screen	4.1.0~20120320gitdb59704-9	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	sed	4.2.2-4ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	sensible-utils	0.0.9	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	sgml-base	1.26+nmu4ubuntu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	shared-mime-info	1.2-0ubuntu3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	software-properties-common	0.92.37.7	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ssh-import-id	3.21-0ubuntu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	strace	4.8-1ubuntu5	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	sudo	1.8.9p5-1ubuntu1.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	systemd-services	204-5ubuntu20.19	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	systemd-shim	6-2bzr1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	sysv-rc	2.88dsf-41ubuntu6.3	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	sysvinit-utils	2.88dsf-41ubuntu6.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	tar	1.27.1-1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	tasksel	2.88ubuntu15	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	tasksel-data	2.88ubuntu15	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	tcpd	7.6.q-25	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	tcpdump	4.5.1-2ubuntu1.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	telnet	0.17-36build2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	time	1.7-24	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	tmux	1.8-5	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	tzdata	2016f-0ubuntu0.14.04	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ubuntu-keyring	2012.05.19	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ubuntu-minimal	1.325	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ubuntu-release-upgrader-core	1:0.220.8	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ubuntu-standard	1.325	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ucf	3.0027+nmu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	udev	204-5ubuntu20.19	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ufw	0.34~rc-0ubuntu2	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	unattended-upgrades	0.82.1ubuntu2.4	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	update-manager-core	1:0.196.14	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	update-notifier-common	0.154.1ubuntu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	upstart	1.12.1-0ubuntu4.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ureadahead	0.100.0-16	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	usbutils	1:007-2ubuntu1.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	util-linux	2.20.1-5.1ubuntu20.7	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	uuid-runtime	2.20.1-5.1ubuntu20.7	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	vim	2:7.4.052-1ubuntu3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	vim-common	2:7.4.052-1ubuntu3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	vim-runtime	2:7.4.052-1ubuntu3	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	vim-tiny	2:7.4.052-1ubuntu3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	w3m	0.5.3-15	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	wget	1.15-1ubuntu1.14.04.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	whiptail	0.52.15-2ubuntu5	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	xauth	1:1.0.7-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	xkb-data	2.10.1-1ubuntu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	xml-core	0.13+nmu2	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	xz-utils	5.1.1alpha+20120614-2ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	zerofree	1.0.2-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	zlib1g	1:1.2.8.dfsg-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	accountsservice	0.6.35-0ubuntu7.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	acpid	1:2.0.21-1ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	adduser	3.113+nmu3ubuntu3	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	apparmor	2.8.95~2430-0ubuntu5.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	apport	2.14.1-0ubuntu3.21	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	apport-symptoms	0.20	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	apt	1.0.1ubuntu2.14	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	apt-transport-https	1.0.1ubuntu2.14	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	apt-utils	1.0.1ubuntu2.14	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	apt-xapian-index	0.45ubuntu4	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	aptitude	0.6.8.2-1ubuntu4	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	aptitude-common	0.6.8.2-1ubuntu4	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	at	3.1.14-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	base-files	7.2ubuntu5.5	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	base-passwd	3.5.33	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	bash	4.3-7ubuntu1.5	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	bash-completion	1:2.1-4ubuntu0.2	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	bc	1.06.95-8ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	bind9-host	1:9.9.5.dfsg-3ubuntu0.8	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	bsdmainutils	9.0.5ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	bsdutils	1:2.20.1-5.1ubuntu20.7	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	busybox-initramfs	1:1.21.0-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	busybox-static	1:1.21.0-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	byobu	5.77-0ubuntu1.2	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	bzip2	1.0.6-5	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ca-certificates	20160104ubuntu0.14.04.1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	chef	12.13.37-1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	cloud-guest-utils	0.27-0ubuntu9.2	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	cloud-init	0.7.5-0ubuntu1.19	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	command-not-found	0.3ubuntu12	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	command-not-found-data	0.3ubuntu12	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	console-setup	1.70ubuntu8	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	coreutils	8.21-1ubuntu5.4	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	cpio	2.11+dfsg-1ubuntu1.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	cron	3.0pl1-124ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	cryptsetup	2:1.6.1-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	cryptsetup-bin	2:1.6.1-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	curl	7.35.0-1ubuntu2.8	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	dash	0.5.7-4ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	dbus	1.6.18-0ubuntu4.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	debconf	1.5.51ubuntu2	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	debconf-i18n	1.5.51ubuntu2	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	debianutils	4.4	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	dh-python	1.20140128-1ubuntu8.2	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	diffutils	1:3.3-1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	dmidecode	2.12-2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	dmsetup	2:1.02.77-6ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	dnsutils	1:9.9.5.dfsg-3ubuntu0.8	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	dosfstools	3.0.26-1ubuntu0.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	dpkg	1.17.5ubuntu5.7	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	e2fslibs	1.42.9-3ubuntu1.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	e2fsprogs	1.42.9-3ubuntu1.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	eatmydata	26-2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ed	1.9-2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	eject	2.1.5+deb1+cvs20081104-13.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ethtool	1:3.13-1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	file	1:5.14-2ubuntu3.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	findutils	4.4.2-7	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	fonts-ubuntu-font-family-console	0.80-0ubuntu6	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	friendly-recovery	0.2.25	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ftp	0.17-28	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	fuse	2.9.2-4ubuntu4.14.04.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	gawk	1:4.0.1+dfsg-2.1ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	gcc-4.8-base	4.8.4-2ubuntu1~14.04.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	gcc-4.9-base	4.9.3-0ubuntu4	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	gdisk	0.8.8-1ubuntu0.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	geoip-database	20140313-1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	gettext-base	0.18.3.1-1ubuntu3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	gir1.2-glib-2.0	1.40.0-1ubuntu0.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	gnupg	1.4.16-1ubuntu2.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	gpgv	1.4.16-1ubuntu2.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	grep	2.16-1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	groff-base	1.22.2-5	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	grub-common	2.02~beta2-9ubuntu1.12	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	grub-gfxpayload-lists	0.6	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	grub-legacy-ec2	0.7.5-0ubuntu1.19	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	grub-pc	2.02~beta2-9ubuntu1.12	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	grub-pc-bin	2.02~beta2-9ubuntu1.12	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	grub2-common	2.02~beta2-9ubuntu1.12	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	gzip	1.6-3ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	hdparm	9.43-1ubuntu3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	hostname	3.15ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ifupdown	0.7.47.2ubuntu4.4	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	info	5.2.0.dfsg.1-2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	init-system-helpers	1.14	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	initramfs-tools	0.103ubuntu4.4	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	initramfs-tools-bin	0.103ubuntu4.4	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	initscripts	2.88dsf-41ubuntu6.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	insserv	1.14.0-5ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	install-info	5.2.0.dfsg.1-2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	iproute2	3.12.0-2ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	iptables	1.4.21-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	iputils-ping	3:20121221-4ubuntu1.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	iputils-tracepath	3:20121221-4ubuntu1.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	irqbalance	1.0.6-2ubuntu0.14.04.4	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	isc-dhcp-client	4.2.4-7ubuntu12.5	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	isc-dhcp-common	4.2.4-7ubuntu12.5	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	iso-codes	3.52-1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	kbd	1.15.5-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	keyboard-configuration	1.70ubuntu8	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	klibc-utils	2.0.3-0ubuntu1.14.04.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	kmod	15-0ubuntu6	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	krb5-locales	1.12+dfsg-2ubuntu5.2	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	landscape-client	14.12-0ubuntu0.14.04	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	landscape-common	14.12-0ubuntu0.14.04	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	language-selector-common	0.129.3	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	laptop-detect	0.13.7ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	less	458-2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libaccountsservice0	0.6.35-0ubuntu7.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libacl1	2.2.52-1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libapparmor-perl	2.8.95~2430-0ubuntu5.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libapparmor1	2.8.95~2430-0ubuntu5.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libapt-inst1.5	1.0.1ubuntu2.14	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libapt-pkg4.12	1.0.1ubuntu2.14	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libarchive-extract-perl	0.70-1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libasn1-8-heimdal	1.6~git20131207+dfsg-1ubuntu1.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libasprintf0c2	0.18.3.1-1ubuntu3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libattr1	1:2.4.47-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libaudit-common	1:2.3.2-2ubuntu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libaudit1	1:2.3.2-2ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libbind9-90	1:9.9.5.dfsg-3ubuntu0.8	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libblkid1	2.20.1-5.1ubuntu20.7	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libboost-iostreams1.54.0	1.54.0-4ubuntu3.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libbsd0	0.6.0-2ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libbz2-1.0	1.0.6-5	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libc-bin	2.19-0ubuntu6.9	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libc6	2.19-0ubuntu6.9	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libcap-ng0	0.7.3-1ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libcap2	1:2.24-0ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libcap2-bin	1:2.24-0ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libcgmanager0	0.24-0ubuntu7.5	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libck-connector0	0.4.5-3.1ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libclass-accessor-perl	0.34-1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libcomerr2	1.42.9-3ubuntu1.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libcryptsetup4	2:1.6.1-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libcurl3	7.35.0-1ubuntu2.8	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libcurl3-gnutls	7.35.0-1ubuntu2.8	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libcwidget3	0.5.16-3.5ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libdb5.3	5.3.28-3ubuntu3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libdbus-1-3	1.6.18-0ubuntu4.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libdbus-glib-1-2	0.100.2-1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libdebconfclient0	0.187ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libdevmapper1.02.1	2:1.02.77-6ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libdns100	1:9.9.5.dfsg-3ubuntu0.8	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libdrm2	2.4.67-1ubuntu0.14.04.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libdumbnet1	1.12-4build1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libedit2	3.1-20130712-2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libelf1	0.158-0ubuntu5.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libept1.4.12	1.0.12	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libestr0	0.1.9-0ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libevent-2.0-5	2.0.21-stable-1ubuntu1.14.04.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libexpat1	2.1.0-4ubuntu1.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libffi6	3.1~rc1+r3.0.13-12ubuntu0.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libfreetype6	2.5.2-1ubuntu2.5	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libfribidi0	0.19.6-1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libfuse2	2.9.2-4ubuntu4.14.04.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libgc1c2	1:7.2d-5ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libgcc1	1:4.9.3-0ubuntu4	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libgck-1-0	3.10.1-1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libgcr-3-common	3.10.1-1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libgcr-base-3-1	3.10.1-1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libgcrypt11	1.5.3-2ubuntu4.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libgdbm3	1.8.3-12build1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libgeoip1	1.6.0-1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libgirepository-1.0-1	1.40.0-1ubuntu0.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libglib2.0-0	2.40.2-0ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libglib2.0-data	2.40.2-0ubuntu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libgnutls-openssl27	2.12.23-12ubuntu2.5	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libgnutls26	2.12.23-12ubuntu2.5	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libgpg-error0	1.12-0.2ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libgpm2	1.20.4-6.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libgssapi-krb5-2	1.12+dfsg-2ubuntu5.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libgssapi3-heimdal	1.6~git20131207+dfsg-1ubuntu1.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libhcrypto4-heimdal	1.6~git20131207+dfsg-1ubuntu1.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libheimbase1-heimdal	1.6~git20131207+dfsg-1ubuntu1.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libheimntlm0-heimdal	1.6~git20131207+dfsg-1ubuntu1.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libhx509-5-heimdal	1.6~git20131207+dfsg-1ubuntu1.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libicu52	52.1-3ubuntu0.4	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libidn11	1.28-1ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libio-string-perl	1.08-3	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libisc95	1:9.9.5.dfsg-3ubuntu0.8	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libisccc90	1:9.9.5.dfsg-3ubuntu0.8	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libisccfg90	1:9.9.5.dfsg-3ubuntu0.8	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libjson-c2	0.11-3ubuntu1.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libjson0	0.11-3ubuntu1.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libk5crypto3	1.12+dfsg-2ubuntu5.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libkeyutils1	1.5.6-1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libklibc	2.0.3-0ubuntu1.14.04.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libkmod2	15-0ubuntu6	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libkrb5-26-heimdal	1.6~git20131207+dfsg-1ubuntu1.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libkrb5-3	1.12+dfsg-2ubuntu5.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libkrb5support0	1.12+dfsg-2ubuntu5.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libldap-2.4-2	2.4.31-1+nmu2ubuntu8.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	liblocale-gettext-perl	1.05-7build3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	liblockfile-bin	1.09-6ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	liblockfile1	1.09-6ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	liblog-message-simple-perl	0.10-1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	liblwres90	1:9.9.5.dfsg-3ubuntu0.8	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	liblzma5	5.1.1alpha+20120614-2ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libmagic1	1:5.14-2ubuntu3.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libmodule-pluggable-perl	5.1-1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libmount1	2.20.1-5.1ubuntu20.7	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libmpdec2	2.4.0-6	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libncurses5	5.9+20140118-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libncursesw5	5.9+20140118-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libnewt0.52	0.52.15-2ubuntu5	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libnfnetlink0	1.0.1-2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libnih-dbus1	1.0.3-4ubuntu25	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libnih1	1.0.3-4ubuntu25	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libnuma1	2.0.9~rc5-1ubuntu3.14.04.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libp11-kit0	0.20.2-2ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpam-cap	1:2.24-0ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpam-modules	1.1.8-1ubuntu2.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpam-modules-bin	1.1.8-1ubuntu2.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpam-runtime	1.1.8-1ubuntu2.2	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpam-systemd	204-5ubuntu20.19	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpam0g	1.1.8-1ubuntu2.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libparse-debianchangelog-perl	1.2.0-1ubuntu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libparted0debian1	2.3-19ubuntu1.14.04.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpcap0.8	1.5.3-2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpci3	1:3.2.1-1ubuntu5.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpcre3	1:8.31-2ubuntu2.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpipeline1	1.3.0-1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libplymouth2	0.8.8-0ubuntu17.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpng12-0	1.2.50-1ubuntu2.14.04.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpod-latex-perl	0.61-1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpolkit-agent-1-0	0.105-4ubuntu3.14.04.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpolkit-backend-1-0	0.105-4ubuntu3.14.04.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpolkit-gobject-1-0	0.105-4ubuntu3.14.04.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpopt0	1.16-8ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libprocps3	1:3.3.9-1ubuntu2.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpython-stdlib	2.7.5-5ubuntu3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpython2.7	2.7.6-8ubuntu0.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpython2.7-minimal	2.7.6-8ubuntu0.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpython2.7-stdlib	2.7.6-8ubuntu0.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpython3-stdlib	3.4.0-0ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpython3.4-minimal	3.4.3-1ubuntu1~14.04.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpython3.4-stdlib	3.4.3-1ubuntu1~14.04.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libreadline6	6.3-4ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libroken18-heimdal	1.6~git20131207+dfsg-1ubuntu1.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	librtmp0	2.4+20121230.gitdf6c518-1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libsasl2-2	2.1.25.dfsg1-17build1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libsasl2-modules	2.1.25.dfsg1-17build1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libsasl2-modules-db	2.1.25.dfsg1-17build1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libselinux1	2.2.2-1ubuntu0.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libsemanage-common	2.2-1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libsemanage1	2.2-1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libsepol1	2.2-1ubuntu0.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libsigc++-2.0-0c2a	2.2.10-0.2ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libsigsegv2	2.10-2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libslang2	2.2.4-15ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libsqlite3-0	3.8.2-1ubuntu2.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libss2	1.42.9-3ubuntu1.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libssl1.0.0	1.0.1f-1ubuntu2.19	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libstdc++6	4.8.4-2ubuntu1~14.04.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libsub-name-perl	0.05-1build4	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libsystemd-daemon0	204-5ubuntu20.19	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libsystemd-login0	204-5ubuntu20.19	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libtasn1-6	3.4-3ubuntu0.4	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libterm-ui-perl	0.42-1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libtext-charwidth-perl	0.04-7build3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libtext-iconv-perl	1.7-5build2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libtext-soundex-perl	3.4-1build1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libtext-wrapi18n-perl	0.06-7	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libtimedate-perl	2.3000-1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libtinfo5	5.9+20140118-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libudev1	204-5ubuntu20.19	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libusb-0.1-4	2:0.1.12-23.3ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libusb-1.0-0	2:1.0.17-1ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libustr-1.0-1	1.0.4-3ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libuuid1	2.20.1-5.1ubuntu20.7	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libwind0-heimdal	1.6~git20131207+dfsg-1ubuntu1.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libwrap0	7.6.q-25	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libx11-6	2:1.6.2-1ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libx11-data	2:1.6.2-1ubuntu2	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libxapian22	1.2.16-2ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libxau6	1:1.0.8-1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libxcb1	1.10-2ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libxdmcp6	1:1.1.1-1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libxext6	2:1.3.2-1ubuntu0.0.14.04.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libxml2	2.9.1+dfsg1-3ubuntu4.8	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libxmuu1	2:1.1.1-1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libxtables10	1.4.21-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libyaml-0-2	0.1.4-3ubuntu3.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	linux-headers-3.13.0-93	3.13.0-93.140	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	linux-headers-3.13.0-93-generic	3.13.0-93.140	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	linux-headers-generic	3.13.0.93.100	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	linux-headers-virtual	3.13.0.93.100	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	linux-image-3.13.0-93-generic	3.13.0-93.140	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	linux-image-virtual	3.13.0.93.100	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	linux-virtual	3.13.0.93.100	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	locales	2.13+git20120306-12.1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	lockfile-progs	0.1.17	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	login	1:4.1.5.1-1ubuntu9.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	logrotate	3.8.7-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	lsb-base	4.1+Debian11ubuntu6.1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	lsb-release	4.1+Debian11ubuntu6.1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	lshw	02.16-2ubuntu1.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	lsof	4.86+dfsg-1ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ltrace	0.7.3-4ubuntu5.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	makedev	2.3.1-93ubuntu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	man-db	2.6.7.1-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	manpages	3.54-1ubuntu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	mawk	1.3.3-17ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	mime-support	3.54ubuntu1.1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	mlocate	0.26-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	module-init-tools	15-0ubuntu6	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	mount	2.20.1-5.1ubuntu20.7	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	mountall	2.53	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	mtr-tiny	0.85-2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	multiarch-support	2.19-0ubuntu6.9	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	nano	2.2.6-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ncurses-base	5.9+20140118-1ubuntu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ncurses-bin	5.9+20140118-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ncurses-term	5.9+20140118-1ubuntu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	net-tools	1.60-25ubuntu2.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	netbase	5.2	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	netcat-openbsd	1.105-7ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ntfs-3g	1:2013.1.13AR.1-2ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ntpdate	1:4.2.6.p5+dfsg-3ubuntu2.14.04.8	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	open-vm-tools	2:9.4.0-1280544-5ubuntu6.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	openssh-client	1:6.6p1-2ubuntu2.7	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	openssh-server	1:6.6p1-2ubuntu2.7	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	openssh-sftp-server	1:6.6p1-2ubuntu2.7	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	openssl	1.0.1f-1ubuntu2.19	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	os-prober	1.63ubuntu1.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	overlayroot	0.25ubuntu1.14.04.1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	parted	2.3-19ubuntu1.14.04.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	passwd	1:4.1.5.1-1ubuntu9.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	patch	2.7.1-4ubuntu2.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	pciutils	1:3.2.1-1ubuntu5.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	perl	5.18.2-2ubuntu1.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	perl-base	5.18.2-2ubuntu1.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	perl-modules	5.18.2-2ubuntu1.1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	plymouth	0.8.8-0ubuntu17.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	plymouth-theme-ubuntu-text	0.8.8-0ubuntu17.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	policykit-1	0.105-4ubuntu3.14.04.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	pollinate	4.7-0ubuntu1.4	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	popularity-contest	1.57ubuntu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	powermgmt-base	1.31build1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ppp	2.4.5-5.1ubuntu2.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	pppconfig	2.3.19ubuntu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	pppoeconf	1.20ubuntu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	procps	1:3.3.9-1ubuntu2.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	psmisc	22.20-1ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	push-jobs-client	2.1.1-1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python	2.7.5-5ubuntu3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-apt	0.9.3.5ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-apt-common	0.9.3.5ubuntu2	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-chardet	2.0.1-2build2	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-cheetah	2.4.4-3.fakesyncbuild1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-configobj	4.7.2+ds-5build1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-debian	0.1.21+nmu2ubuntu2	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-gdbm	2.7.5-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-json-pointer	1.0-2build1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-jsonpatch	1.3-4	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-minimal	2.7.5-5ubuntu3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-oauth	1.0.1-3build2	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-openssl	0.13-2ubuntu6	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-pam	0.4.2-13.1ubuntu3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-pkg-resources	3.3-1ubuntu2	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-prettytable	0.7.2-2ubuntu2	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-pycurl	7.19.3-0ubuntu3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-requests	2.2.1-1ubuntu0.3	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-serial	2.6-1build1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-six	1.5.2-1ubuntu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-twisted-bin	13.2.0-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-twisted-core	13.2.0-1ubuntu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-twisted-names	13.2.0-1ubuntu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-twisted-web	13.2.0-1ubuntu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-urllib3	1.7.1-1ubuntu4	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-xapian	1.2.16-2ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-yaml	3.10-4ubuntu0.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-zope.interface	4.0.5-1ubuntu4	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python2.7	2.7.6-8ubuntu0.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python2.7-minimal	2.7.6-8ubuntu0.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python3	3.4.0-0ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python3-apport	2.14.1-0ubuntu3.21	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python3-apt	0.9.3.5ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python3-commandnotfound	0.3ubuntu12	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python3-dbus	1.2.0-2build2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python3-distupgrade	1:0.220.8	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python3-gdbm	3.4.3-1~14.04.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python3-gi	3.12.0-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python3-minimal	3.4.0-0ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python3-newt	0.52.15-2ubuntu5	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python3-problem-report	2.14.1-0ubuntu3.21	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python3-pycurl	7.19.3-0ubuntu3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python3-software-properties	0.92.37.7	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python3-update-manager	1:0.196.14	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python3.4	3.4.3-1ubuntu1~14.04.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python3.4-minimal	3.4.3-1ubuntu1~14.04.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	readline-common	6.3-4ubuntu2	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	resolvconf	1.69ubuntu1.1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	rsync	3.1.0-2ubuntu0.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	rsyslog	7.4.4-1ubuntu2.6	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	run-one	1.17-0ubuntu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	screen	4.1.0~20120320gitdb59704-9	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	sed	4.2.2-4ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	sensible-utils	0.0.9	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	sgml-base	1.26+nmu4ubuntu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	shared-mime-info	1.2-0ubuntu3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	software-properties-common	0.92.37.7	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ssh-import-id	3.21-0ubuntu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	strace	4.8-1ubuntu5	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	sudo	1.8.9p5-1ubuntu1.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	systemd-services	204-5ubuntu20.19	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	systemd-shim	6-2bzr1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	sysv-rc	2.88dsf-41ubuntu6.3	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	sysvinit-utils	2.88dsf-41ubuntu6.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	tar	1.27.1-1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	tasksel	2.88ubuntu15	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	tasksel-data	2.88ubuntu15	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	tcpd	7.6.q-25	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	tcpdump	4.5.1-2ubuntu1.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	telnet	0.17-36build2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	time	1.7-24	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	tmux	1.8-5	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	tzdata	2016f-0ubuntu0.14.04	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ubuntu-keyring	2012.05.19	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ubuntu-minimal	1.325	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ubuntu-release-upgrader-core	1:0.220.8	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ubuntu-standard	1.325	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ucf	3.0027+nmu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	udev	204-5ubuntu20.19	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ufw	0.34~rc-0ubuntu2	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	unattended-upgrades	0.82.1ubuntu2.4	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	update-manager-core	1:0.196.14	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	update-notifier-common	0.154.1ubuntu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	upstart	1.12.1-0ubuntu4.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ureadahead	0.100.0-16	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	usbutils	1:007-2ubuntu1.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	util-linux	2.20.1-5.1ubuntu20.7	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	uuid-runtime	2.20.1-5.1ubuntu20.7	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	vim	2:7.4.052-1ubuntu3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	vim-common	2:7.4.052-1ubuntu3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	vim-runtime	2:7.4.052-1ubuntu3	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	vim-tiny	2:7.4.052-1ubuntu3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	w3m	0.5.3-15	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	wget	1.15-1ubuntu1.14.04.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	whiptail	0.52.15-2ubuntu5	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	xauth	1:1.0.7-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	xkb-data	2.10.1-1ubuntu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	xml-core	0.13+nmu2	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	xz-utils	5.1.1alpha+20120614-2ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	zerofree	1.0.2-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	zlib1g	1:1.2.8.dfsg-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	accountsservice	0.6.35-0ubuntu7.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	acpid	1:2.0.21-1ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	adduser	3.113+nmu3ubuntu3	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	apparmor	2.8.95~2430-0ubuntu5.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	apport	2.14.1-0ubuntu3.21	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	apport-symptoms	0.20	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	apt	1.0.1ubuntu2.14	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	apt-transport-https	1.0.1ubuntu2.14	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	apt-utils	1.0.1ubuntu2.14	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	apt-xapian-index	0.45ubuntu4	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	aptitude	0.6.8.2-1ubuntu4	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	aptitude-common	0.6.8.2-1ubuntu4	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	at	3.1.14-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	base-files	7.2ubuntu5.5	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	base-passwd	3.5.33	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	bash	4.3-7ubuntu1.5	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	bash-completion	1:2.1-4ubuntu0.2	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	bc	1.06.95-8ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	bind9-host	1:9.9.5.dfsg-3ubuntu0.8	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	bsdmainutils	9.0.5ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	bsdutils	1:2.20.1-5.1ubuntu20.7	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	busybox-initramfs	1:1.21.0-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	busybox-static	1:1.21.0-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	byobu	5.77-0ubuntu1.2	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	bzip2	1.0.6-5	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ca-certificates	20160104ubuntu0.14.04.1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	chef	12.13.37-1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	cloud-guest-utils	0.27-0ubuntu9.2	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	cloud-init	0.7.5-0ubuntu1.19	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	command-not-found	0.3ubuntu12	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	command-not-found-data	0.3ubuntu12	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	console-setup	1.70ubuntu8	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	coreutils	8.21-1ubuntu5.4	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	cpio	2.11+dfsg-1ubuntu1.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	cron	3.0pl1-124ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	cryptsetup	2:1.6.1-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	cryptsetup-bin	2:1.6.1-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	curl	7.35.0-1ubuntu2.8	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	dash	0.5.7-4ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	dbus	1.6.18-0ubuntu4.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	debconf	1.5.51ubuntu2	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	debconf-i18n	1.5.51ubuntu2	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	debianutils	4.4	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	dh-python	1.20140128-1ubuntu8.2	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	diffutils	1:3.3-1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	dmidecode	2.12-2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	dmsetup	2:1.02.77-6ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	dnsutils	1:9.9.5.dfsg-3ubuntu0.8	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	dosfstools	3.0.26-1ubuntu0.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	dpkg	1.17.5ubuntu5.7	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	e2fslibs	1.42.9-3ubuntu1.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	e2fsprogs	1.42.9-3ubuntu1.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	eatmydata	26-2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ed	1.9-2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	eject	2.1.5+deb1+cvs20081104-13.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ethtool	1:3.13-1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	file	1:5.14-2ubuntu3.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	findutils	4.4.2-7	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	fonts-ubuntu-font-family-console	0.80-0ubuntu6	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	friendly-recovery	0.2.25	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ftp	0.17-28	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	fuse	2.9.2-4ubuntu4.14.04.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	gawk	1:4.0.1+dfsg-2.1ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	gcc-4.8-base	4.8.4-2ubuntu1~14.04.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	gcc-4.9-base	4.9.3-0ubuntu4	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	gdisk	0.8.8-1ubuntu0.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	geoip-database	20140313-1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	gettext-base	0.18.3.1-1ubuntu3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	gir1.2-glib-2.0	1.40.0-1ubuntu0.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	gnupg	1.4.16-1ubuntu2.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	gpgv	1.4.16-1ubuntu2.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	grep	2.16-1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	groff-base	1.22.2-5	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	grub-common	2.02~beta2-9ubuntu1.12	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	grub-gfxpayload-lists	0.6	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	grub-legacy-ec2	0.7.5-0ubuntu1.19	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	grub-pc	2.02~beta2-9ubuntu1.12	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	grub-pc-bin	2.02~beta2-9ubuntu1.12	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	grub2-common	2.02~beta2-9ubuntu1.12	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	gzip	1.6-3ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	hdparm	9.43-1ubuntu3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	hostname	3.15ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ifupdown	0.7.47.2ubuntu4.4	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	info	5.2.0.dfsg.1-2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	init-system-helpers	1.14	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	initramfs-tools	0.103ubuntu4.4	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	initramfs-tools-bin	0.103ubuntu4.4	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	initscripts	2.88dsf-41ubuntu6.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	insserv	1.14.0-5ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	install-info	5.2.0.dfsg.1-2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	iproute2	3.12.0-2ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	iptables	1.4.21-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	iputils-ping	3:20121221-4ubuntu1.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	iputils-tracepath	3:20121221-4ubuntu1.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	irqbalance	1.0.6-2ubuntu0.14.04.4	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	isc-dhcp-client	4.2.4-7ubuntu12.5	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	isc-dhcp-common	4.2.4-7ubuntu12.5	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	iso-codes	3.52-1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	kbd	1.15.5-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	keyboard-configuration	1.70ubuntu8	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	klibc-utils	2.0.3-0ubuntu1.14.04.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	kmod	15-0ubuntu6	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	krb5-locales	1.12+dfsg-2ubuntu5.2	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	landscape-client	14.12-0ubuntu0.14.04	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	landscape-common	14.12-0ubuntu0.14.04	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	language-selector-common	0.129.3	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	laptop-detect	0.13.7ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	less	458-2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libaccountsservice0	0.6.35-0ubuntu7.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libacl1	2.2.52-1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libapparmor-perl	2.8.95~2430-0ubuntu5.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libapparmor1	2.8.95~2430-0ubuntu5.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libapt-inst1.5	1.0.1ubuntu2.14	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libapt-pkg4.12	1.0.1ubuntu2.14	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libarchive-extract-perl	0.70-1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libasn1-8-heimdal	1.6~git20131207+dfsg-1ubuntu1.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libasprintf0c2	0.18.3.1-1ubuntu3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libattr1	1:2.4.47-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libaudit-common	1:2.3.2-2ubuntu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libaudit1	1:2.3.2-2ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libbind9-90	1:9.9.5.dfsg-3ubuntu0.8	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libblkid1	2.20.1-5.1ubuntu20.7	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libboost-iostreams1.54.0	1.54.0-4ubuntu3.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libbsd0	0.6.0-2ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libbz2-1.0	1.0.6-5	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libc-bin	2.19-0ubuntu6.9	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libc6	2.19-0ubuntu6.9	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libcap-ng0	0.7.3-1ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libcap2	1:2.24-0ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libcap2-bin	1:2.24-0ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libcgmanager0	0.24-0ubuntu7.5	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libck-connector0	0.4.5-3.1ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libclass-accessor-perl	0.34-1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libcomerr2	1.42.9-3ubuntu1.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libcryptsetup4	2:1.6.1-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libcurl3	7.35.0-1ubuntu2.8	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libcurl3-gnutls	7.35.0-1ubuntu2.8	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libcwidget3	0.5.16-3.5ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libdb5.3	5.3.28-3ubuntu3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libdbus-1-3	1.6.18-0ubuntu4.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libdbus-glib-1-2	0.100.2-1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libdebconfclient0	0.187ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libdevmapper1.02.1	2:1.02.77-6ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libdns100	1:9.9.5.dfsg-3ubuntu0.8	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libdrm2	2.4.67-1ubuntu0.14.04.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libdumbnet1	1.12-4build1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libedit2	3.1-20130712-2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libelf1	0.158-0ubuntu5.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libept1.4.12	1.0.12	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libestr0	0.1.9-0ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libevent-2.0-5	2.0.21-stable-1ubuntu1.14.04.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libexpat1	2.1.0-4ubuntu1.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libffi6	3.1~rc1+r3.0.13-12ubuntu0.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libfreetype6	2.5.2-1ubuntu2.5	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libfribidi0	0.19.6-1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libfuse2	2.9.2-4ubuntu4.14.04.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libgc1c2	1:7.2d-5ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libgcc1	1:4.9.3-0ubuntu4	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libgck-1-0	3.10.1-1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libgcr-3-common	3.10.1-1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libgcr-base-3-1	3.10.1-1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libgcrypt11	1.5.3-2ubuntu4.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libgdbm3	1.8.3-12build1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libgeoip1	1.6.0-1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libgirepository-1.0-1	1.40.0-1ubuntu0.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libglib2.0-0	2.40.2-0ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libglib2.0-data	2.40.2-0ubuntu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libgnutls-openssl27	2.12.23-12ubuntu2.5	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libgnutls26	2.12.23-12ubuntu2.5	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libgpg-error0	1.12-0.2ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libgpm2	1.20.4-6.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libgssapi-krb5-2	1.12+dfsg-2ubuntu5.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libgssapi3-heimdal	1.6~git20131207+dfsg-1ubuntu1.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libhcrypto4-heimdal	1.6~git20131207+dfsg-1ubuntu1.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libheimbase1-heimdal	1.6~git20131207+dfsg-1ubuntu1.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libheimntlm0-heimdal	1.6~git20131207+dfsg-1ubuntu1.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libhx509-5-heimdal	1.6~git20131207+dfsg-1ubuntu1.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libicu52	52.1-3ubuntu0.4	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libidn11	1.28-1ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libio-string-perl	1.08-3	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libisc95	1:9.9.5.dfsg-3ubuntu0.8	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libisccc90	1:9.9.5.dfsg-3ubuntu0.8	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libisccfg90	1:9.9.5.dfsg-3ubuntu0.8	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libjson-c2	0.11-3ubuntu1.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libjson0	0.11-3ubuntu1.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libk5crypto3	1.12+dfsg-2ubuntu5.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libkeyutils1	1.5.6-1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libklibc	2.0.3-0ubuntu1.14.04.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libkmod2	15-0ubuntu6	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libkrb5-26-heimdal	1.6~git20131207+dfsg-1ubuntu1.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libkrb5-3	1.12+dfsg-2ubuntu5.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libkrb5support0	1.12+dfsg-2ubuntu5.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libldap-2.4-2	2.4.31-1+nmu2ubuntu8.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	liblocale-gettext-perl	1.05-7build3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	liblockfile-bin	1.09-6ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	liblockfile1	1.09-6ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	liblog-message-simple-perl	0.10-1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	liblwres90	1:9.9.5.dfsg-3ubuntu0.8	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	liblzma5	5.1.1alpha+20120614-2ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libmagic1	1:5.14-2ubuntu3.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libmodule-pluggable-perl	5.1-1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libmount1	2.20.1-5.1ubuntu20.7	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libmpdec2	2.4.0-6	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libncurses5	5.9+20140118-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libncursesw5	5.9+20140118-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libnewt0.52	0.52.15-2ubuntu5	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libnfnetlink0	1.0.1-2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libnih-dbus1	1.0.3-4ubuntu25	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libnih1	1.0.3-4ubuntu25	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libnuma1	2.0.9~rc5-1ubuntu3.14.04.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libp11-kit0	0.20.2-2ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpam-cap	1:2.24-0ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpam-modules	1.1.8-1ubuntu2.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpam-modules-bin	1.1.8-1ubuntu2.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpam-runtime	1.1.8-1ubuntu2.2	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpam-systemd	204-5ubuntu20.19	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpam0g	1.1.8-1ubuntu2.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libparse-debianchangelog-perl	1.2.0-1ubuntu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libparted0debian1	2.3-19ubuntu1.14.04.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpcap0.8	1.5.3-2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpci3	1:3.2.1-1ubuntu5.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpcre3	1:8.31-2ubuntu2.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpipeline1	1.3.0-1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libplymouth2	0.8.8-0ubuntu17.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpng12-0	1.2.50-1ubuntu2.14.04.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpod-latex-perl	0.61-1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpolkit-agent-1-0	0.105-4ubuntu3.14.04.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpolkit-backend-1-0	0.105-4ubuntu3.14.04.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpolkit-gobject-1-0	0.105-4ubuntu3.14.04.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpopt0	1.16-8ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libprocps3	1:3.3.9-1ubuntu2.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpython-stdlib	2.7.5-5ubuntu3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpython2.7	2.7.6-8ubuntu0.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpython2.7-minimal	2.7.6-8ubuntu0.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpython2.7-stdlib	2.7.6-8ubuntu0.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpython3-stdlib	3.4.0-0ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpython3.4-minimal	3.4.3-1ubuntu1~14.04.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libpython3.4-stdlib	3.4.3-1ubuntu1~14.04.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libreadline6	6.3-4ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libroken18-heimdal	1.6~git20131207+dfsg-1ubuntu1.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	librtmp0	2.4+20121230.gitdf6c518-1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libsasl2-2	2.1.25.dfsg1-17build1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libsasl2-modules	2.1.25.dfsg1-17build1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libsasl2-modules-db	2.1.25.dfsg1-17build1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libselinux1	2.2.2-1ubuntu0.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libsemanage-common	2.2-1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libsemanage1	2.2-1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libsepol1	2.2-1ubuntu0.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libsigc++-2.0-0c2a	2.2.10-0.2ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libsigsegv2	2.10-2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libslang2	2.2.4-15ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libsqlite3-0	3.8.2-1ubuntu2.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libss2	1.42.9-3ubuntu1.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libssl1.0.0	1.0.1f-1ubuntu2.19	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libstdc++6	4.8.4-2ubuntu1~14.04.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libsub-name-perl	0.05-1build4	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libsystemd-daemon0	204-5ubuntu20.19	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libsystemd-login0	204-5ubuntu20.19	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libtasn1-6	3.4-3ubuntu0.4	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libterm-ui-perl	0.42-1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libtext-charwidth-perl	0.04-7build3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libtext-iconv-perl	1.7-5build2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libtext-soundex-perl	3.4-1build1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libtext-wrapi18n-perl	0.06-7	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libtimedate-perl	2.3000-1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libtinfo5	5.9+20140118-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libudev1	204-5ubuntu20.19	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libusb-0.1-4	2:0.1.12-23.3ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libusb-1.0-0	2:1.0.17-1ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libustr-1.0-1	1.0.4-3ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libuuid1	2.20.1-5.1ubuntu20.7	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libwind0-heimdal	1.6~git20131207+dfsg-1ubuntu1.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libwrap0	7.6.q-25	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libx11-6	2:1.6.2-1ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libx11-data	2:1.6.2-1ubuntu2	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libxapian22	1.2.16-2ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libxau6	1:1.0.8-1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libxcb1	1.10-2ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libxdmcp6	1:1.1.1-1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libxext6	2:1.3.2-1ubuntu0.0.14.04.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libxml2	2.9.1+dfsg1-3ubuntu4.8	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libxmuu1	2:1.1.1-1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libxtables10	1.4.21-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	libyaml-0-2	0.1.4-3ubuntu3.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	linux-headers-3.13.0-93	3.13.0-93.140	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	linux-headers-3.13.0-93-generic	3.13.0-93.140	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	linux-headers-generic	3.13.0.93.100	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	linux-headers-virtual	3.13.0.93.100	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	linux-image-3.13.0-93-generic	3.13.0-93.140	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	linux-image-virtual	3.13.0.93.100	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	linux-virtual	3.13.0.93.100	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	locales	2.13+git20120306-12.1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	lockfile-progs	0.1.17	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	login	1:4.1.5.1-1ubuntu9.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	logrotate	3.8.7-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	lsb-base	4.1+Debian11ubuntu6.1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	lsb-release	4.1+Debian11ubuntu6.1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	lshw	02.16-2ubuntu1.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	lsof	4.86+dfsg-1ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ltrace	0.7.3-4ubuntu5.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	makedev	2.3.1-93ubuntu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	man-db	2.6.7.1-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	manpages	3.54-1ubuntu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	mawk	1.3.3-17ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	mime-support	3.54ubuntu1.1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	mlocate	0.26-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	module-init-tools	15-0ubuntu6	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	mount	2.20.1-5.1ubuntu20.7	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	mountall	2.53	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	mtr-tiny	0.85-2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	multiarch-support	2.19-0ubuntu6.9	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	nano	2.2.6-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ncurses-base	5.9+20140118-1ubuntu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ncurses-bin	5.9+20140118-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ncurses-term	5.9+20140118-1ubuntu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	net-tools	1.60-25ubuntu2.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	netbase	5.2	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	netcat-openbsd	1.105-7ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ntfs-3g	1:2013.1.13AR.1-2ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ntpdate	1:4.2.6.p5+dfsg-3ubuntu2.14.04.8	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	open-vm-tools	2:9.4.0-1280544-5ubuntu6.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	openssh-client	1:6.6p1-2ubuntu2.7	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	openssh-server	1:6.6p1-2ubuntu2.7	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	openssh-sftp-server	1:6.6p1-2ubuntu2.7	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	openssl	1.0.1f-1ubuntu2.19	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	os-prober	1.63ubuntu1.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	overlayroot	0.25ubuntu1.14.04.1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	parted	2.3-19ubuntu1.14.04.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	passwd	1:4.1.5.1-1ubuntu9.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	patch	2.7.1-4ubuntu2.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	pciutils	1:3.2.1-1ubuntu5.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	perl	5.18.2-2ubuntu1.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	perl-base	5.18.2-2ubuntu1.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	perl-modules	5.18.2-2ubuntu1.1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	plymouth	0.8.8-0ubuntu17.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	plymouth-theme-ubuntu-text	0.8.8-0ubuntu17.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	policykit-1	0.105-4ubuntu3.14.04.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	pollinate	4.7-0ubuntu1.4	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	popularity-contest	1.57ubuntu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	powermgmt-base	1.31build1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ppp	2.4.5-5.1ubuntu2.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	pppconfig	2.3.19ubuntu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	pppoeconf	1.20ubuntu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	procps	1:3.3.9-1ubuntu2.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	psmisc	22.20-1ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	push-jobs-client	2.1.1-1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python	2.7.5-5ubuntu3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-apt	0.9.3.5ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-apt-common	0.9.3.5ubuntu2	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-chardet	2.0.1-2build2	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-cheetah	2.4.4-3.fakesyncbuild1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-configobj	4.7.2+ds-5build1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-debian	0.1.21+nmu2ubuntu2	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-gdbm	2.7.5-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-json-pointer	1.0-2build1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-jsonpatch	1.3-4	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-minimal	2.7.5-5ubuntu3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-oauth	1.0.1-3build2	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-openssl	0.13-2ubuntu6	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-pam	0.4.2-13.1ubuntu3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-pkg-resources	3.3-1ubuntu2	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-prettytable	0.7.2-2ubuntu2	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-pycurl	7.19.3-0ubuntu3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-requests	2.2.1-1ubuntu0.3	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-serial	2.6-1build1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-six	1.5.2-1ubuntu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-twisted-bin	13.2.0-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-twisted-core	13.2.0-1ubuntu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-twisted-names	13.2.0-1ubuntu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-twisted-web	13.2.0-1ubuntu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-urllib3	1.7.1-1ubuntu4	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-xapian	1.2.16-2ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-yaml	3.10-4ubuntu0.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python-zope.interface	4.0.5-1ubuntu4	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python2.7	2.7.6-8ubuntu0.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python2.7-minimal	2.7.6-8ubuntu0.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python3	3.4.0-0ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python3-apport	2.14.1-0ubuntu3.21	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python3-apt	0.9.3.5ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python3-commandnotfound	0.3ubuntu12	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python3-dbus	1.2.0-2build2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python3-distupgrade	1:0.220.8	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python3-gdbm	3.4.3-1~14.04.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python3-gi	3.12.0-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python3-minimal	3.4.0-0ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python3-newt	0.52.15-2ubuntu5	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python3-problem-report	2.14.1-0ubuntu3.21	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python3-pycurl	7.19.3-0ubuntu3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python3-software-properties	0.92.37.7	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python3-update-manager	1:0.196.14	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python3.4	3.4.3-1ubuntu1~14.04.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	python3.4-minimal	3.4.3-1ubuntu1~14.04.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	readline-common	6.3-4ubuntu2	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	resolvconf	1.69ubuntu1.1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	rsync	3.1.0-2ubuntu0.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	rsyslog	7.4.4-1ubuntu2.6	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	run-one	1.17-0ubuntu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	screen	4.1.0~20120320gitdb59704-9	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	sed	4.2.2-4ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	sensible-utils	0.0.9	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	sgml-base	1.26+nmu4ubuntu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	shared-mime-info	1.2-0ubuntu3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	software-properties-common	0.92.37.7	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ssh-import-id	3.21-0ubuntu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	strace	4.8-1ubuntu5	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	sudo	1.8.9p5-1ubuntu1.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	systemd-services	204-5ubuntu20.19	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	systemd-shim	6-2bzr1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	sysv-rc	2.88dsf-41ubuntu6.3	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	sysvinit-utils	2.88dsf-41ubuntu6.3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	tar	1.27.1-1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	tasksel	2.88ubuntu15	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	tasksel-data	2.88ubuntu15	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	tcpd	7.6.q-25	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	tcpdump	4.5.1-2ubuntu1.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	telnet	0.17-36build2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	time	1.7-24	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	tmux	1.8-5	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	tzdata	2016f-0ubuntu0.14.04	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ubuntu-keyring	2012.05.19	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ubuntu-minimal	1.325	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ubuntu-release-upgrader-core	1:0.220.8	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ubuntu-standard	1.325	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ucf	3.0027+nmu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	udev	204-5ubuntu20.19	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ufw	0.34~rc-0ubuntu2	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	unattended-upgrades	0.82.1ubuntu2.4	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	update-manager-core	1:0.196.14	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	update-notifier-common	0.154.1ubuntu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	upstart	1.12.1-0ubuntu4.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ureadahead	0.100.0-16	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	usbutils	1:007-2ubuntu1.1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	util-linux	2.20.1-5.1ubuntu20.7	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	uuid-runtime	2.20.1-5.1ubuntu20.7	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	vim	2:7.4.052-1ubuntu3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	vim-common	2:7.4.052-1ubuntu3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	vim-runtime	2:7.4.052-1ubuntu3	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	vim-tiny	2:7.4.052-1ubuntu3	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	w3m	0.5.3-15	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	wget	1.15-1ubuntu1.14.04.2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	whiptail	0.52.15-2ubuntu5	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	xauth	1:1.0.7-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	xkb-data	2.10.1-1ubuntu1	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	xml-core	0.13+nmu2	all		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	xz-utils	5.1.1alpha+20120614-2ubuntu2	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	zerofree	1.0.2-1ubuntu1	amd64		deb
7bdfc437-dc36-4efe-77c7-0aae5672cf29	e5cb0934-4379-4dd8-433f-27f3b4be3a95	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	zlib1g	1:1.2.8.dfsg-1ubuntu1	amd64		deb
\.


--
-- Data for Name: patch_node_results; Type: TABLE DATA; Schema: public; Owner: chef-pgsql
--

COPY patch_node_results (owner, patch, environment, node, success_rate, package_cnt, log) FROM stdin;
\.


--
-- Data for Name: patch_runs; Type: TABLE DATA; Schema: public; Owner: chef-pgsql
--

COPY patch_runs (id, owner, start, "end", cnt_nodes, skip_count, failure_count, success_count) FROM stdin;
\.


--
-- Data for Name: role_permissions; Type: TABLE DATA; Schema: public; Owner: chef-pgsql
--

COPY role_permissions (id, owner, team, environment, node, key, value) FROM stdin;
\.


--
-- Data for Name: scan_node_results; Type: TABLE DATA; Schema: public; Owner: chef-pgsql
--

COPY scan_node_results (scan, environment, node, compliance_status, patchlevel_status, unknown_status, os_family, os_release, os_arch, rules_success, rules_minor, rules_major, rules_critical, rules_skipped, rules_total, patch_success, patch_minor, patch_major, patch_critical, patch_unknown, patch_total, connect_success, connect_message) FROM stdin;
7bdfc437-dc36-4efe-77c7-0aae5672cf29	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	cd9bf95f-f2e7-467c-5738-15b322e0ba65	-1	0.0134228189	0	ubuntu	14.04		0	0	0	0	0	0	441	3	3	0	0	447	t	
7bdfc437-dc36-4efe-77c7-0aae5672cf29	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	0e96ec57-46db-4fe8-5809-bb2cf683cb7b	-1	0.0134228189	0	ubuntu	14.04		0	0	0	0	0	0	441	3	3	0	0	447	t	
7bdfc437-dc36-4efe-77c7-0aae5672cf29	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	ccca5c8f-f8d2-4dce-4d57-a98d15dbb214	-1	0.0134228189	0	ubuntu	14.04		0	0	0	0	0	0	441	3	3	0	0	447	t	
7bdfc437-dc36-4efe-77c7-0aae5672cf29	86a4db7a-5431-4f9b-5d8f-38ea26b3ec53	e5cb0934-4379-4dd8-433f-27f3b4be3a95	-1	0.0134228189	0	ubuntu	14.04		0	0	0	0	0	0	441	3	3	0	0	447	t	
51427610-f4b0-4a28-775d-6df5814b48be	ccba775a-8376-4210-6938-5275e192ec11	c958f232-6656-4bd8-58a9-85def6e7705a	-1	-1	0				0	0	0	0	0	0	0	0	0	0	0	0	f	Failed to verify connectivity to winrm://Administrator@172.31.54.135:5985 using login password : exit status 1, \n/opt/chef-compliance/embedded/lib/ruby/gems/2.2.0/gems/inspec-0.23/lib/inspec/profile_context.rb:37:in `instance_eval': WinRM::WinRMAuthorizationError (WinRM::WinRMAuthorizationError)\n\tfrom /opt/chef-compliance/embedded/lib/ruby/gems/2.2.0/gems/winrm-1.8.1/lib/winrm/http/response_handler.rb:50:in `raise_if_error'\n\tfrom /opt/chef-compliance/embedded/lib/ruby/gems/2.2.0/gems/winrm-1.8.1/lib/winrm/http/response_handler.rb:35:in `parse_to_xml'\n\tfrom /opt/chef-compliance/embedded/lib/ruby/gems/2.2.0/gems/winrm-1.8.1/lib/winrm/http/transport.rb:200:in `send_request'\n\tfrom /opt/chef-compliance/embedded/lib/ruby/gems/2.2.0/gems/winrm-1.8.1/lib/winrm/http/transport.rb:195:in `send_request'\n\tfrom /opt/chef-compliance/embedded/lib/ruby/gems/2.2.0/gems/winrm-1.8.1/lib/winrm/winrm_service.rb:492:in `send_message'\n\tfrom /opt/chef-compliance/embedded/lib/ruby/gems/2.2.0/gems/winrm-1.8.1/lib/winrm/winrm_service.rb:393:in `run_wql'\n\tfrom /opt/chef-compliance/embedded/lib/ruby/gems/2.2.0/gems/winrm-1.8.1/lib/winrm/command_executor.rb:190:in `os_version'\n\tfrom /opt/chef-compliance/embedded/lib/ruby/gems/2.2.0/gems/winrm-1.8.1/lib/winrm/command_executor.rb:149:in `code_page'\n\tfrom /opt/chef-compliance/embedded/lib/ruby/gems/2.2.0/gems/winrm-1.8.1/lib/winrm/command_executor.rb:72:in `block in open'\n\tfrom /opt/chef-compliance/embedded/lib/ruby/gems/2.2.0/gems/winrm-1.8.1/lib/winrm/command_executor.rb:222:in `retryable'\n\tfrom /opt/chef-compliance/embedded/lib/ruby/gems/2.2.0/gems/winrm-1.8.1/lib/winrm/command_executor.rb:71:in `open'\n\tfrom /opt/chef-compliance/embedded/lib/ruby/gems/2.2.0/gems/winrm-1.8.1/lib/winrm/winrm_service.rb:359:in `create_executor'\n\tfrom /opt/chef-compliance/embedded/lib/ruby/gems/2.2.0/gems/r-train-0.12.1/lib/train/transports/winrm_connection.rb:176:in `session'\n\tfrom /opt/chef-compliance/embedded/lib/ruby/gems/2.2.0/gems/r-train-0.12.1/lib/train/transports/winrm_connection.rb:64:in `run_command'\n\tfrom /opt/chef-compliance/embedded/lib/ruby/gems/2.2.0/gems/r-train-0.12.1/lib/train/extras/os_detect_windows.rb:13:in `detect_windows'\n\tfrom /opt/chef-compliance/embedded/lib/ruby/gems/2.2.0/gems/r-train-0.12.1/lib/train/extras/os_common.rb:110:in `detect_family_type'\n\tfrom /opt/chef-compliance/embedded/lib/ruby/gems/2.2.0/gems/r-train-0.12.1/lib/train/extras/os_common.rb:83:in `detect_family'\n\tfrom /opt/chef-compliance/embedded/lib/ruby/gems/2.2.0/gems/r-train-0.12.1/lib/train/extras/os_common.rb:26:in `initialize'\n\tfrom /opt/chef-compliance/embedded/lib/ruby/gems/2.2.0/gems/r-train-0.12.1/lib/train/transports/winrm_connection.rb:190:in `initialize'\n\tfrom /opt/chef-compliance/embedded/lib/ruby/gems/2.2.0/gems/r-train-0.12.1/lib/train/transports/winrm_connection.rb:52:in `new'\n\tfrom /opt/chef-compliance/embedded/lib/ruby/gems/2.2.0/gems/r-train-0.12.1/lib/train/transports/winrm_connection.rb:52:in `os'\n\tfrom /opt/chef-compliance/embedded/lib/ruby/gems/2.2.0/gems/inspec-0.23/lib/resources/os.rb:47:in `params'\n\tfrom (eval):1:in `load'\n\tfrom /opt/chef-compliance/embedded/lib/ruby/gems/2.2.0/gems/inspec-0.23/lib/inspec/profile_context.rb:37:in `instance_eval'\n\tfrom /opt/chef-compliance/embedded/lib/ruby/gems/2.2.0/gems/inspec-0.23/lib/inspec/profile_context.rb:37:in `load'\n\tfrom /opt/chef-compliance/embedded/lib/ruby/gems/2.2.0/gems/inspec-0.23/lib/inspec/cli.rb:162:in `run_command'\n\tfrom /opt/chef-compliance/embedded/lib/ruby/gems/2.2.0/gems/inspec-0.23/lib/inspec/cli.rb:120:in `detect'\n\tfrom /opt/chef-compliance/embedded/lib/ruby/gems/2.2.0/gems/thor-0.19.1/lib/thor/command.rb:27:in `run'\n\tfrom /opt/chef-compliance/embedded/lib/ruby/gems/2.2.0/gems/thor-0.19.1/lib/thor/invocation.rb:126:in `invoke_command'\n\tfrom /opt/chef-compliance/embedded/lib/ruby/gems/2.2.0/gems/thor-0.19.1/lib/thor.rb:359:in `dispatch'\n\tfrom /opt/chef-compliance/embedded/lib/ruby/gems/2.2.0/gems/thor-0.19.1/lib/thor/base.rb:440:in `start'\n\tfrom /opt/chef-compliance/embedded/lib/ruby/gems/2.2.0/gems/inspec-0.23/bin/inspec:9:in `<top (required)>'\n\tfrom /opt/chef-compliance/embedded/bin/inspec:22:in `load'\n\tfrom /opt/chef-compliance/embedded/bin/inspec:22:in `<main>'\n
1bb07dbd-d13a-454e-4ab2-e8e7bd5c87bc	ccba775a-8376-4210-6938-5275e192ec11	c958f232-6656-4bd8-58a9-85def6e7705a	-1	-1	0				0	0	0	0	0	0	0	0	0	0	0	0	f	Failed to connect to winrm://Administrator@172.31.54.135:5985 using login password, connection timed out after 30s
b3d705aa-d756-4acb-4b12-a302bc36554f	ccba775a-8376-4210-6938-5275e192ec11	c958f232-6656-4bd8-58a9-85def6e7705a	1	-1	0	windows	6.3.9600	64-bit	17	4	0	21	0	42	0	0	0	0	0	0	t	
f9a766b4-9950-4f36-6c90-2eff1d972556	77528987-44b8-4322-6ae7-aa3ee87553c1	c42d6910-6f13-43c7-5067-69d628fb1aed	1	-1	0	debian	14.04	x86_64	2	0	3	1	0	6	0	0	0	0	0	0	t	
f9a766b4-9950-4f36-6c90-2eff1d972556	77528987-44b8-4322-6ae7-aa3ee87553c1	c48446a6-cf9a-4b8c-587a-0f24b7b128d0	1	-1	0	debian	14.04	x86_64	2	0	3	1	0	6	0	0	0	0	0	0	t	
f9a766b4-9950-4f36-6c90-2eff1d972556	77528987-44b8-4322-6ae7-aa3ee87553c1	ff0fe8f0-6059-4386-4287-d6636afaf6e0	1	-1	0	debian	14.04	x86_64	2	0	3	1	0	6	0	0	0	0	0	0	t	
f9a766b4-9950-4f36-6c90-2eff1d972556	77528987-44b8-4322-6ae7-aa3ee87553c1	0e711c41-418d-4fb4-4249-8eb6c3ba0f13	1	-1	0	debian	14.04	x86_64	2	0	3	1	0	6	0	0	0	0	0	0	t	
\.


--
-- Data for Name: scan_rule_results; Type: TABLE DATA; Schema: public; Owner: chef-pgsql
--

COPY scan_rule_results (node, environment, scan, profile_owner, profile_id, rule, impact, failures, skipped, log) FROM stdin;
c958f232-6656-4bd8-58a9-85def6e7705a	ccba775a-8376-4210-6938-5275e192ec11	b3d705aa-d756-4acb-4b12-a302bc36554f	base	windows	windows-account-101	1	0	f	Security Policy EnableGuestAccount should eq 0
c958f232-6656-4bd8-58a9-85def6e7705a	ccba775a-8376-4210-6938-5275e192ec11	b3d705aa-d756-4acb-4b12-a302bc36554f	base	windows	windows-base-102	1	0	f	Registry Key HKLM\\System\\CurrentControlSet\\Services\\LanManServer\\Parameters should exist
c958f232-6656-4bd8-58a9-85def6e7705a	ccba775a-8376-4210-6938-5275e192ec11	b3d705aa-d756-4acb-4b12-a302bc36554f	base	windows	windows-base-201	1	1	f	Registry Key HKLM\\System\\CurrentControlSet\\Control\\Lsa should exist\nRegistry Key HKLM\\System\\CurrentControlSet\\Control\\Lsa LmCompatibilityLevel should eq 4
c958f232-6656-4bd8-58a9-85def6e7705a	ccba775a-8376-4210-6938-5275e192ec11	b3d705aa-d756-4acb-4b12-a302bc36554f	base	windows	cis-minimum-password-length-1.1.4	0.699999988	1	f	Security Policy MinimumPasswordLength should be >= 14
c958f232-6656-4bd8-58a9-85def6e7705a	ccba775a-8376-4210-6938-5275e192ec11	b3d705aa-d756-4acb-4b12-a302bc36554f	base	windows	windows-audit-205	1	0	f	Audit Policy Computer Account Management should not eq "No Auditing"
c958f232-6656-4bd8-58a9-85def6e7705a	ccba775a-8376-4210-6938-5275e192ec11	b3d705aa-d756-4acb-4b12-a302bc36554f	base	windows	windows-audit-103	0.100000001	1	f	Registry Key HKLM\\Software\\Policies\\Microsoft\\Windows\\EventLog\\System should exist\nRegistry Key HKLM\\Software\\Policies\\Microsoft\\Windows\\EventLog\\System MaxSize should not eq nil
c958f232-6656-4bd8-58a9-85def6e7705a	ccba775a-8376-4210-6938-5275e192ec11	b3d705aa-d756-4acb-4b12-a302bc36554f	base	windows	windows-account-104	1	1	f	Security Policy LockoutBadCount should not eq 0
c958f232-6656-4bd8-58a9-85def6e7705a	ccba775a-8376-4210-6938-5275e192ec11	b3d705aa-d756-4acb-4b12-a302bc36554f	base	windows	windows-account-105	1	0	f	Security Policy ResetLockoutCount should not eq 0
c958f232-6656-4bd8-58a9-85def6e7705a	ccba775a-8376-4210-6938-5275e192ec11	b3d705aa-d756-4acb-4b12-a302bc36554f	base	windows	windows-account-106	1	0	f	Security Policy LockoutDuration should not eq 0
c958f232-6656-4bd8-58a9-85def6e7705a	ccba775a-8376-4210-6938-5275e192ec11	b3d705aa-d756-4acb-4b12-a302bc36554f	base	windows	windows-base-203	1	1	f	Registry Key HKLM\\System\\CurrentControlSet\\Control\\Lsa\\MSV1_0 should exist\nRegistry Key HKLM\\System\\CurrentControlSet\\Control\\Lsa\\MSV1_0 NtlmMinServerSec should eq 537395200
c958f232-6656-4bd8-58a9-85def6e7705a	ccba775a-8376-4210-6938-5275e192ec11	b3d705aa-d756-4acb-4b12-a302bc36554f	base	windows	cis-password-complexity-1.1.6	0.699999988	0	f	Security Policy ClearTextPassword should eq 0
c958f232-6656-4bd8-58a9-85def6e7705a	ccba775a-8376-4210-6938-5275e192ec11	b3d705aa-d756-4acb-4b12-a302bc36554f	base	windows	windows-audit-100	0.100000001	1	f	Registry Key HKLM\\Software\\Policies\\Microsoft\\Windows\\EventLog\\Application should exist\nRegistry Key HKLM\\Software\\Policies\\Microsoft\\Windows\\EventLog\\Application MaxSize should not eq nil
c958f232-6656-4bd8-58a9-85def6e7705a	ccba775a-8376-4210-6938-5275e192ec11	b3d705aa-d756-4acb-4b12-a302bc36554f	base	windows	windows-audit-202	1	0	f	Audit Policy Kerberos Service Ticket Operations should not eq "No Auditing"
c958f232-6656-4bd8-58a9-85def6e7705a	ccba775a-8376-4210-6938-5275e192ec11	b3d705aa-d756-4acb-4b12-a302bc36554f	base	windows	windows-audit-203	1	1	f	Audit Policy Other Account Logon Events should not eq "No Auditing"
c958f232-6656-4bd8-58a9-85def6e7705a	ccba775a-8376-4210-6938-5275e192ec11	b3d705aa-d756-4acb-4b12-a302bc36554f	base	windows	windows-audit-204	1	1	f	Audit Policy Application Group Management should not eq "No Auditing"
c958f232-6656-4bd8-58a9-85def6e7705a	ccba775a-8376-4210-6938-5275e192ec11	b3d705aa-d756-4acb-4b12-a302bc36554f	base	windows	cis-act-as-os-2.2.3	0.699999988	0	f	Security Policy SeTcbPrivilege should be nil
c958f232-6656-4bd8-58a9-85def6e7705a	ccba775a-8376-4210-6938-5275e192ec11	b3d705aa-d756-4acb-4b12-a302bc36554f	base	windows	windows-rdp-101	1	1	f	Registry Key HKLM\\SOFTWARE\\Policies\\Microsoft\\Windows NT\\Terminal Services should exist\nRegistry Key HKLM\\SOFTWARE\\Policies\\Microsoft\\Windows NT\\Terminal Services MinEncryptionLevel should eq 3
c958f232-6656-4bd8-58a9-85def6e7705a	ccba775a-8376-4210-6938-5275e192ec11	b3d705aa-d756-4acb-4b12-a302bc36554f	base	windows	cis-account-lockout-duration-1.2.1	0.699999988	1	f	Security Policy LockoutDuration should be >= 15
c958f232-6656-4bd8-58a9-85def6e7705a	ccba775a-8376-4210-6938-5275e192ec11	b3d705aa-d756-4acb-4b12-a302bc36554f	base	windows	windows-base-104	1	0	f	Registry Key HKLM\\System\\CurrentControlSet\\Services\\LanmanWorkstation\\Parameters should exist
c958f232-6656-4bd8-58a9-85def6e7705a	ccba775a-8376-4210-6938-5275e192ec11	b3d705aa-d756-4acb-4b12-a302bc36554f	base	windows	windows-base-202	1	1	f	Registry Key HKLM\\System\\CurrentControlSet\\Control\\Lsa\\MSV1_0 should exist\nRegistry Key HKLM\\System\\CurrentControlSet\\Control\\Lsa\\MSV1_0 NtlmMinClientSec should eq 537395200
c958f232-6656-4bd8-58a9-85def6e7705a	ccba775a-8376-4210-6938-5275e192ec11	b3d705aa-d756-4acb-4b12-a302bc36554f	base	windows	cis-access-cred-manager-2.2.1	0.699999988	0	f	Security Policy SeTrustedCredManAccessPrivilege should be nil
c958f232-6656-4bd8-58a9-85def6e7705a	ccba775a-8376-4210-6938-5275e192ec11	b3d705aa-d756-4acb-4b12-a302bc36554f	base	windows	cis-maximum-password-age-1.1.2	0.699999988	0	f	Security Policy MaximumPasswordAge should be <= 60
c958f232-6656-4bd8-58a9-85def6e7705a	ccba775a-8376-4210-6938-5275e192ec11	b3d705aa-d756-4acb-4b12-a302bc36554f	base	windows	windows-audit-206	1	1	f	Audit Policy Distribution Group Management should not eq "No Auditing"
c958f232-6656-4bd8-58a9-85def6e7705a	ccba775a-8376-4210-6938-5275e192ec11	b3d705aa-d756-4acb-4b12-a302bc36554f	base	windows	windows-account-103	1	1	f	Security Policy MinimumPasswordLength should not eq 0
c958f232-6656-4bd8-58a9-85def6e7705a	ccba775a-8376-4210-6938-5275e192ec11	b3d705aa-d756-4acb-4b12-a302bc36554f	base	windows	windows-base-103	1	1	f	Registry Key HKLM\\System\\CurrentControlSet\\Services\\LanManServer\\Parameters should exist\nRegistry Key HKLM\\System\\CurrentControlSet\\Services\\LanManServer\\Parameters NullSessionShares should eq [""]
c958f232-6656-4bd8-58a9-85def6e7705a	ccba775a-8376-4210-6938-5275e192ec11	b3d705aa-d756-4acb-4b12-a302bc36554f	base	windows	cis-network-access-2.2.2	0.699999988	0	f	Security Policy SeNetworkLogonRight should not be nil
c958f232-6656-4bd8-58a9-85def6e7705a	ccba775a-8376-4210-6938-5275e192ec11	b3d705aa-d756-4acb-4b12-a302bc36554f	base	windows	windows-rdp-100	1	1	f	Registry Key HKLM\\SOFTWARE\\Policies\\Microsoft\\Windows NT\\Terminal Services should exist\nRegistry Key HKLM\\SOFTWARE\\Policies\\Microsoft\\Windows NT\\Terminal Services fPromptForPassword should eq 1
c958f232-6656-4bd8-58a9-85def6e7705a	ccba775a-8376-4210-6938-5275e192ec11	b3d705aa-d756-4acb-4b12-a302bc36554f	base	windows	cis-enforce-password-history-1.1.1	0.699999988	1	f	Security Policy PasswordHistorySize should be >= 24
c958f232-6656-4bd8-58a9-85def6e7705a	ccba775a-8376-4210-6938-5275e192ec11	b3d705aa-d756-4acb-4b12-a302bc36554f	base	windows	cis-minimum-password-age-1.1.3	0.699999988	1	f	Security Policy MinimumPasswordAge should be >= 1
c958f232-6656-4bd8-58a9-85def6e7705a	ccba775a-8376-4210-6938-5275e192ec11	b3d705aa-d756-4acb-4b12-a302bc36554f	base	windows	windows-audit-101	0.100000001	1	f	Registry Key HKLM\\Software\\Policies\\Microsoft\\Windows\\EventLog\\Security should exist\nRegistry Key HKLM\\Software\\Policies\\Microsoft\\Windows\\EventLog\\Security MaxSize should not eq nil
c958f232-6656-4bd8-58a9-85def6e7705a	ccba775a-8376-4210-6938-5275e192ec11	b3d705aa-d756-4acb-4b12-a302bc36554f	base	windows	cis-account-lockout-threshold-1.2.2	0.699999988	1	f	Security Policy LockoutBadCount should be <= 10\nSecurity Policy LockoutBadCount should be > 0
c958f232-6656-4bd8-58a9-85def6e7705a	ccba775a-8376-4210-6938-5275e192ec11	b3d705aa-d756-4acb-4b12-a302bc36554f	base	windows	windows-account-100	1	1	f	Security Policy SeRemoteInteractiveLogonRight should eq "*S-1-5-32-544"
c958f232-6656-4bd8-58a9-85def6e7705a	ccba775a-8376-4210-6938-5275e192ec11	b3d705aa-d756-4acb-4b12-a302bc36554f	base	windows	windows-base-101	1	0	f	Registry Key HKLM\\System\\CurrentControlSet\\Control\\Session Manager should exist
c958f232-6656-4bd8-58a9-85def6e7705a	ccba775a-8376-4210-6938-5275e192ec11	b3d705aa-d756-4acb-4b12-a302bc36554f	base	windows	cis-add-workstations-2.2.4	0.699999988	1	f	Security Policy SeMachineAccountPrivilege should eq "*S-1-5-32-544"
c958f232-6656-4bd8-58a9-85def6e7705a	ccba775a-8376-4210-6938-5275e192ec11	b3d705aa-d756-4acb-4b12-a302bc36554f	base	windows	windows-ie-102	1	1	f	Registry Key HKLM\\Software\\Policies\\Microsoft\\Windows\\CurrentVersion\\Internet Settings\\Zones\\3 should exist\nRegistry Key HKLM\\Software\\Policies\\Microsoft\\Windows\\CurrentVersion\\Internet Settings\\Zones\\3 270C should eq 0
c958f232-6656-4bd8-58a9-85def6e7705a	ccba775a-8376-4210-6938-5275e192ec11	b3d705aa-d756-4acb-4b12-a302bc36554f	base	windows	windows-account-102	1	0	f	Security Policy PasswordComplexity should eq 1
c958f232-6656-4bd8-58a9-85def6e7705a	ccba775a-8376-4210-6938-5275e192ec11	b3d705aa-d756-4acb-4b12-a302bc36554f	base	windows	windows-base-100	1	0	f	File c:/windows should be directory
c958f232-6656-4bd8-58a9-85def6e7705a	ccba775a-8376-4210-6938-5275e192ec11	b3d705aa-d756-4acb-4b12-a302bc36554f	base	windows	windows-audit-201	1	0	f	Audit Policy Kerberos Authentication Service should not eq "No Auditing"
c958f232-6656-4bd8-58a9-85def6e7705a	ccba775a-8376-4210-6938-5275e192ec11	b3d705aa-d756-4acb-4b12-a302bc36554f	base	windows	cis-reset-account-lockout-1.2.3	0.699999988	1	f	Security Policy ResetLockoutCount should be >= 15
c958f232-6656-4bd8-58a9-85def6e7705a	ccba775a-8376-4210-6938-5275e192ec11	b3d705aa-d756-4acb-4b12-a302bc36554f	base	windows	windows-audit-102	0.100000001	1	f	Registry Key HKLM\\Software\\Policies\\Microsoft\\Windows\\EventLog\\Setup should exist\nRegistry Key HKLM\\Software\\Policies\\Microsoft\\Windows\\EventLog\\Setup MaxSize should not eq nil
c958f232-6656-4bd8-58a9-85def6e7705a	ccba775a-8376-4210-6938-5275e192ec11	b3d705aa-d756-4acb-4b12-a302bc36554f	base	windows	cis-adjust-memory-quotas-2.2.5	0.699999988	0	f	Security Policy SeIncreaseQuotaPrivilege should match /\\*S-1-5-19,?/
c958f232-6656-4bd8-58a9-85def6e7705a	ccba775a-8376-4210-6938-5275e192ec11	b3d705aa-d756-4acb-4b12-a302bc36554f	base	windows	windows-ie-101	1	1	f	Registry Key HKLM\\Software\\Policies\\Microsoft\\Internet Explorer\\Main should exist\nRegistry Key HKLM\\Software\\Policies\\Microsoft\\Internet Explorer\\Main Isolation64Bit should eq 1
c42d6910-6f13-43c7-5067-69d628fb1aed	77528987-44b8-4322-6ae7-aa3ee87553c1	f9a766b4-9950-4f36-6c90-2eff1d972556	admin	ssl-benchmark	tls1.0	0.5	1	f	Failure: SSL/TLS on union.automate-demo.com:443 with protocol == "tls1.0"\nFailure: SSL/TLS on union.automate-demo.com:443 with protocol == "tls1.0" should not be enabled\nFailure: SSL/TLS on union.automate-demo.com:443 with protocol == "tls1.0"\nFailure: SSL/TLS on union.automate-demo.com:443 with protocol == "tls1.0" should not be enabled
c42d6910-6f13-43c7-5067-69d628fb1aed	77528987-44b8-4322-6ae7-aa3ee87553c1	f9a766b4-9950-4f36-6c90-2eff1d972556	admin	ssl-benchmark	tls1.1	0.5	1	f	Failure: SSL/TLS on union.automate-demo.com:443 with protocol == "tls1.1"\nFailure: SSL/TLS on union.automate-demo.com:443 with protocol == "tls1.1" should not be enabled\nFailure: SSL/TLS on union.automate-demo.com:443 with protocol == "tls1.1"\nFailure: SSL/TLS on union.automate-demo.com:443 with protocol == "tls1.1" should not be enabled
c42d6910-6f13-43c7-5067-69d628fb1aed	77528987-44b8-4322-6ae7-aa3ee87553c1	f9a766b4-9950-4f36-6c90-2eff1d972556	admin	ssl-benchmark	rc4	0.5	1	f	Failure: SSL/TLS on union.automate-demo.com:443 with cipher == /rc4/i\nFailure: SSL/TLS on union.automate-demo.com:443 with cipher == /rc4/i should not be enabled\nFailure: SSL/TLS on union.automate-demo.com:443 with cipher == /rc4/i\nFailure: SSL/TLS on union.automate-demo.com:443 with cipher == /rc4/i should not be enabled
c42d6910-6f13-43c7-5067-69d628fb1aed	77528987-44b8-4322-6ae7-aa3ee87553c1	f9a766b4-9950-4f36-6c90-2eff1d972556	admin	ssl-benchmark	tls1.2	0.5	0	f	Success: SSL/TLS on union.automate-demo.com:443 with protocol == "tls1.2"\nSuccess: SSL/TLS on union.automate-demo.com:443 with protocol == "tls1.2" should be enabled\nSuccess: SSL/TLS on union.automate-demo.com:443 with protocol == "tls1.2"\nSuccess: SSL/TLS on union.automate-demo.com:443 with protocol == "tls1.2" should be enabled
c42d6910-6f13-43c7-5067-69d628fb1aed	77528987-44b8-4322-6ae7-aa3ee87553c1	f9a766b4-9950-4f36-6c90-2eff1d972556	admin	ssl-benchmark	ssl2	1	0	f	Success: SSL/TLS on union.automate-demo.com:443 with protocol == "ssl2"\nSuccess: SSL/TLS on union.automate-demo.com:443 with protocol == "ssl2" should not be enabled\nSuccess: SSL/TLS on union.automate-demo.com:443 with protocol == "ssl2"\nSuccess: SSL/TLS on union.automate-demo.com:443 with protocol == "ssl2" should not be enabled
c42d6910-6f13-43c7-5067-69d628fb1aed	77528987-44b8-4322-6ae7-aa3ee87553c1	f9a766b4-9950-4f36-6c90-2eff1d972556	admin	ssl-benchmark	ssl3	1	1	f	Failure: SSL/TLS on union.automate-demo.com:443 with protocol == "ssl3"\nFailure: SSL/TLS on union.automate-demo.com:443 with protocol == "ssl3" should not be enabled\nFailure: SSL/TLS on union.automate-demo.com:443 with protocol == "ssl3"\nFailure: SSL/TLS on union.automate-demo.com:443 with protocol == "ssl3" should not be enabled
c48446a6-cf9a-4b8c-587a-0f24b7b128d0	77528987-44b8-4322-6ae7-aa3ee87553c1	f9a766b4-9950-4f36-6c90-2eff1d972556	admin	ssl-benchmark	ssl2	1	0	f	Success: SSL/TLS on delivered.automate-demo.com:443 with protocol == "ssl2"\nSuccess: SSL/TLS on delivered.automate-demo.com:443 with protocol == "ssl2" should not be enabled\nSuccess: SSL/TLS on delivered.automate-demo.com:443 with protocol == "ssl2"\nSuccess: SSL/TLS on delivered.automate-demo.com:443 with protocol == "ssl2" should not be enabled
c48446a6-cf9a-4b8c-587a-0f24b7b128d0	77528987-44b8-4322-6ae7-aa3ee87553c1	f9a766b4-9950-4f36-6c90-2eff1d972556	admin	ssl-benchmark	ssl3	1	1	f	Failure: SSL/TLS on delivered.automate-demo.com:443 with protocol == "ssl3"\nFailure: SSL/TLS on delivered.automate-demo.com:443 with protocol == "ssl3" should not be enabled\nFailure: SSL/TLS on delivered.automate-demo.com:443 with protocol == "ssl3"\nFailure: SSL/TLS on delivered.automate-demo.com:443 with protocol == "ssl3" should not be enabled
c48446a6-cf9a-4b8c-587a-0f24b7b128d0	77528987-44b8-4322-6ae7-aa3ee87553c1	f9a766b4-9950-4f36-6c90-2eff1d972556	admin	ssl-benchmark	tls1.0	0.5	1	f	Failure: SSL/TLS on delivered.automate-demo.com:443 with protocol == "tls1.0"\nFailure: SSL/TLS on delivered.automate-demo.com:443 with protocol == "tls1.0" should not be enabled\nFailure: SSL/TLS on delivered.automate-demo.com:443 with protocol == "tls1.0"\nFailure: SSL/TLS on delivered.automate-demo.com:443 with protocol == "tls1.0" should not be enabled
c48446a6-cf9a-4b8c-587a-0f24b7b128d0	77528987-44b8-4322-6ae7-aa3ee87553c1	f9a766b4-9950-4f36-6c90-2eff1d972556	admin	ssl-benchmark	tls1.1	0.5	1	f	Failure: SSL/TLS on delivered.automate-demo.com:443 with protocol == "tls1.1"\nFailure: SSL/TLS on delivered.automate-demo.com:443 with protocol == "tls1.1" should not be enabled\nFailure: SSL/TLS on delivered.automate-demo.com:443 with protocol == "tls1.1"\nFailure: SSL/TLS on delivered.automate-demo.com:443 with protocol == "tls1.1" should not be enabled
c48446a6-cf9a-4b8c-587a-0f24b7b128d0	77528987-44b8-4322-6ae7-aa3ee87553c1	f9a766b4-9950-4f36-6c90-2eff1d972556	admin	ssl-benchmark	rc4	0.5	1	f	Failure: SSL/TLS on delivered.automate-demo.com:443 with cipher == /rc4/i\nFailure: SSL/TLS on delivered.automate-demo.com:443 with cipher == /rc4/i should not be enabled\nFailure: SSL/TLS on delivered.automate-demo.com:443 with cipher == /rc4/i\nFailure: SSL/TLS on delivered.automate-demo.com:443 with cipher == /rc4/i should not be enabled
c48446a6-cf9a-4b8c-587a-0f24b7b128d0	77528987-44b8-4322-6ae7-aa3ee87553c1	f9a766b4-9950-4f36-6c90-2eff1d972556	admin	ssl-benchmark	tls1.2	0.5	0	f	Success: SSL/TLS on delivered.automate-demo.com:443 with protocol == "tls1.2"\nSuccess: SSL/TLS on delivered.automate-demo.com:443 with protocol == "tls1.2" should be enabled\nSuccess: SSL/TLS on delivered.automate-demo.com:443 with protocol == "tls1.2"\nSuccess: SSL/TLS on delivered.automate-demo.com:443 with protocol == "tls1.2" should be enabled
ff0fe8f0-6059-4386-4287-d6636afaf6e0	77528987-44b8-4322-6ae7-aa3ee87553c1	f9a766b4-9950-4f36-6c90-2eff1d972556	admin	ssl-benchmark	rc4	0.5	1	f	Failure: SSL/TLS on rehearsal.automate-demo.com:443 with cipher == /rc4/i\nFailure: SSL/TLS on rehearsal.automate-demo.com:443 with cipher == /rc4/i should not be enabled\nFailure: SSL/TLS on rehearsal.automate-demo.com:443 with cipher == /rc4/i\nFailure: SSL/TLS on rehearsal.automate-demo.com:443 with cipher == /rc4/i should not be enabled
ff0fe8f0-6059-4386-4287-d6636afaf6e0	77528987-44b8-4322-6ae7-aa3ee87553c1	f9a766b4-9950-4f36-6c90-2eff1d972556	admin	ssl-benchmark	tls1.2	0.5	0	f	Success: SSL/TLS on rehearsal.automate-demo.com:443 with protocol == "tls1.2"\nSuccess: SSL/TLS on rehearsal.automate-demo.com:443 with protocol == "tls1.2" should be enabled\nSuccess: SSL/TLS on rehearsal.automate-demo.com:443 with protocol == "tls1.2"\nSuccess: SSL/TLS on rehearsal.automate-demo.com:443 with protocol == "tls1.2" should be enabled
ff0fe8f0-6059-4386-4287-d6636afaf6e0	77528987-44b8-4322-6ae7-aa3ee87553c1	f9a766b4-9950-4f36-6c90-2eff1d972556	admin	ssl-benchmark	ssl2	1	0	f	Success: SSL/TLS on rehearsal.automate-demo.com:443 with protocol == "ssl2"\nSuccess: SSL/TLS on rehearsal.automate-demo.com:443 with protocol == "ssl2" should not be enabled\nSuccess: SSL/TLS on rehearsal.automate-demo.com:443 with protocol == "ssl2"\nSuccess: SSL/TLS on rehearsal.automate-demo.com:443 with protocol == "ssl2" should not be enabled
ff0fe8f0-6059-4386-4287-d6636afaf6e0	77528987-44b8-4322-6ae7-aa3ee87553c1	f9a766b4-9950-4f36-6c90-2eff1d972556	admin	ssl-benchmark	ssl3	1	1	f	Failure: SSL/TLS on rehearsal.automate-demo.com:443 with protocol == "ssl3"\nFailure: SSL/TLS on rehearsal.automate-demo.com:443 with protocol == "ssl3" should not be enabled\nFailure: SSL/TLS on rehearsal.automate-demo.com:443 with protocol == "ssl3"\nFailure: SSL/TLS on rehearsal.automate-demo.com:443 with protocol == "ssl3" should not be enabled
ff0fe8f0-6059-4386-4287-d6636afaf6e0	77528987-44b8-4322-6ae7-aa3ee87553c1	f9a766b4-9950-4f36-6c90-2eff1d972556	admin	ssl-benchmark	tls1.0	0.5	1	f	Failure: SSL/TLS on rehearsal.automate-demo.com:443 with protocol == "tls1.0"\nFailure: SSL/TLS on rehearsal.automate-demo.com:443 with protocol == "tls1.0" should not be enabled\nFailure: SSL/TLS on rehearsal.automate-demo.com:443 with protocol == "tls1.0"\nFailure: SSL/TLS on rehearsal.automate-demo.com:443 with protocol == "tls1.0" should not be enabled
ff0fe8f0-6059-4386-4287-d6636afaf6e0	77528987-44b8-4322-6ae7-aa3ee87553c1	f9a766b4-9950-4f36-6c90-2eff1d972556	admin	ssl-benchmark	tls1.1	0.5	1	f	Failure: SSL/TLS on rehearsal.automate-demo.com:443 with protocol == "tls1.1"\nFailure: SSL/TLS on rehearsal.automate-demo.com:443 with protocol == "tls1.1" should not be enabled\nFailure: SSL/TLS on rehearsal.automate-demo.com:443 with protocol == "tls1.1"\nFailure: SSL/TLS on rehearsal.automate-demo.com:443 with protocol == "tls1.1" should not be enabled
0e711c41-418d-4fb4-4249-8eb6c3ba0f13	77528987-44b8-4322-6ae7-aa3ee87553c1	f9a766b4-9950-4f36-6c90-2eff1d972556	admin	ssl-benchmark	ssl3	1	1	f	Failure: SSL/TLS on ecomacceptance.automate-demo.com:443 with protocol == "ssl3"\nFailure: SSL/TLS on ecomacceptance.automate-demo.com:443 with protocol == "ssl3" should not be enabled\nFailure: SSL/TLS on ecomacceptance.automate-demo.com:443 with protocol == "ssl3"\nFailure: SSL/TLS on ecomacceptance.automate-demo.com:443 with protocol == "ssl3" should not be enabled
0e711c41-418d-4fb4-4249-8eb6c3ba0f13	77528987-44b8-4322-6ae7-aa3ee87553c1	f9a766b4-9950-4f36-6c90-2eff1d972556	admin	ssl-benchmark	tls1.0	0.5	1	f	Failure: SSL/TLS on ecomacceptance.automate-demo.com:443 with protocol == "tls1.0"\nFailure: SSL/TLS on ecomacceptance.automate-demo.com:443 with protocol == "tls1.0" should not be enabled\nFailure: SSL/TLS on ecomacceptance.automate-demo.com:443 with protocol == "tls1.0"\nFailure: SSL/TLS on ecomacceptance.automate-demo.com:443 with protocol == "tls1.0" should not be enabled
0e711c41-418d-4fb4-4249-8eb6c3ba0f13	77528987-44b8-4322-6ae7-aa3ee87553c1	f9a766b4-9950-4f36-6c90-2eff1d972556	admin	ssl-benchmark	tls1.1	0.5	1	f	Failure: SSL/TLS on ecomacceptance.automate-demo.com:443 with protocol == "tls1.1"\nFailure: SSL/TLS on ecomacceptance.automate-demo.com:443 with protocol == "tls1.1" should not be enabled\nFailure: SSL/TLS on ecomacceptance.automate-demo.com:443 with protocol == "tls1.1"\nFailure: SSL/TLS on ecomacceptance.automate-demo.com:443 with protocol == "tls1.1" should not be enabled
0e711c41-418d-4fb4-4249-8eb6c3ba0f13	77528987-44b8-4322-6ae7-aa3ee87553c1	f9a766b4-9950-4f36-6c90-2eff1d972556	admin	ssl-benchmark	rc4	0.5	1	f	Failure: SSL/TLS on ecomacceptance.automate-demo.com:443 with cipher == /rc4/i\nFailure: SSL/TLS on ecomacceptance.automate-demo.com:443 with cipher == /rc4/i should not be enabled\nFailure: SSL/TLS on ecomacceptance.automate-demo.com:443 with cipher == /rc4/i\nFailure: SSL/TLS on ecomacceptance.automate-demo.com:443 with cipher == /rc4/i should not be enabled
0e711c41-418d-4fb4-4249-8eb6c3ba0f13	77528987-44b8-4322-6ae7-aa3ee87553c1	f9a766b4-9950-4f36-6c90-2eff1d972556	admin	ssl-benchmark	tls1.2	0.5	0	f	Success: SSL/TLS on ecomacceptance.automate-demo.com:443 with protocol == "tls1.2"\nSuccess: SSL/TLS on ecomacceptance.automate-demo.com:443 with protocol == "tls1.2" should be enabled\nSuccess: SSL/TLS on ecomacceptance.automate-demo.com:443 with protocol == "tls1.2"\nSuccess: SSL/TLS on ecomacceptance.automate-demo.com:443 with protocol == "tls1.2" should be enabled
0e711c41-418d-4fb4-4249-8eb6c3ba0f13	77528987-44b8-4322-6ae7-aa3ee87553c1	f9a766b4-9950-4f36-6c90-2eff1d972556	admin	ssl-benchmark	ssl2	1	0	f	Success: SSL/TLS on ecomacceptance.automate-demo.com:443 with protocol == "ssl2"\nSuccess: SSL/TLS on ecomacceptance.automate-demo.com:443 with protocol == "ssl2" should not be enabled\nSuccess: SSL/TLS on ecomacceptance.automate-demo.com:443 with protocol == "ssl2"\nSuccess: SSL/TLS on ecomacceptance.automate-demo.com:443 with protocol == "ssl2" should not be enabled
\.


--
-- Data for Name: scans; Type: TABLE DATA; Schema: public; Owner: chef-pgsql
--

COPY scans (id, owner, start, "end", cnt_nodes, cnt_compliance, cnt_patchlevel, compliance_status, patchlevel_status, unknown_status, rules_success, rules_minor, rules_major, rules_critical, rules_skipped, rules_total, patch_success, patch_minor, patch_major, patch_critical, patch_unknown, patch_total, cnt_failed_scans) FROM stdin;
7bdfc437-dc36-4efe-77c7-0aae5672cf29	ac36a30b-fe17-4684-54bf-2ed5501d6e7b	2016-08-17 16:10:36.917205+00	2016-08-17 16:10:56.611158+00	4	0	1	-1	0.0134228189	0	0	0	0	0	0	0	1764	12	12	0	0	1788	0
51427610-f4b0-4a28-775d-6df5814b48be	ac36a30b-fe17-4684-54bf-2ed5501d6e7b	2016-08-17 16:11:29.970419+00	2016-08-17 16:11:35.05699+00	1	1	0	-1	-1	0	0	0	0	0	0	0	0	0	0	0	0	0	1
1bb07dbd-d13a-454e-4ab2-e8e7bd5c87bc	ac36a30b-fe17-4684-54bf-2ed5501d6e7b	2016-08-17 16:14:16.000408+00	2016-08-17 16:14:46.005695+00	1	1	0	-1	-1	0	0	0	0	0	0	0	0	0	0	0	0	0	1
b3d705aa-d756-4acb-4b12-a302bc36554f	ac36a30b-fe17-4684-54bf-2ed5501d6e7b	2016-08-17 16:16:57.748684+00	2016-08-17 16:20:21.030986+00	1	1	0	1	-1	0	17	4	0	21	0	42	0	0	0	0	0	0	0
f9a766b4-9950-4f36-6c90-2eff1d972556	ac36a30b-fe17-4684-54bf-2ed5501d6e7b	2016-11-02 21:26:10.782769+00	2016-11-02 21:26:26.749595+00	4	1	0	1	-1	0	8	0	12	4	0	24	0	0	0	0	0	0	0
\.


--
-- Data for Name: sources; Type: TABLE DATA; Schema: public; Owner: chef-pgsql
--

COPY sources (id, info, type) FROM stdin;
\.


--
-- Data for Name: team_members; Type: TABLE DATA; Schema: public; Owner: chef-pgsql
--

COPY team_members (team, org, "user") FROM stdin;
\.


--
-- Data for Name: teams; Type: TABLE DATA; Schema: public; Owner: chef-pgsql
--

COPY teams (id, org, name) FROM stdin;
\.


--
-- Data for Name: user_permissions; Type: TABLE DATA; Schema: public; Owner: chef-pgsql
--

COPY user_permissions (id, key, value) FROM stdin;
e3254379-4459-482e-6e63-549f2b646195	site_admin	true
ac36a30b-fe17-4684-54bf-2ed5501d6e7b	site_admin	true
\.


--
-- Data for Name: user_preferences; Type: TABLE DATA; Schema: public; Owner: chef-pgsql
--

COPY user_preferences (id, key, value) FROM stdin;
\.


SET search_path = sqitch, pg_catalog;

--
-- Data for Name: changes; Type: TABLE DATA; Schema: sqitch; Owner: chef-pgsql
--

COPY changes (change_id, change, project, note, committed_at, committer_name, committer_email, planned_at, planner_name, planner_email) FROM stdin;
cc76e98a1a21eeedbd65fa851cfc4b7770c2e250	appschema	chef-compiance	Add schema for chef-compliance	2016-08-16 21:29:29.849325+00	Ubuntu	ubuntu@compliance	2015-10-27 23:34:56+00	Dominik Richter	drichter@chef.io
15c352699adde4a482ae12932ffd1186f873c298	001_packages_tables_extend_pk	chef-compiance	Extending PK to avoid key constraint errors. Fixes chef-compliance #154	2016-08-16 21:29:29.878616+00	Ubuntu	ubuntu@compliance	2015-12-10 15:30:30+00	Alex Pop	apop@chef.io
a17f03c5c2cdd17b0171670d7418a676572d65ee	002_add_failure_tracking_to_scan_tables	chef-compiance	Adding `success` and `message` columns to table scan_node_results. Adding `cnt_failed_scans` to scans	2016-08-16 21:29:29.892399+00	Ubuntu	ubuntu@compliance	2015-12-18 12:17:20+00	Alex Pop	apop@chef.io
e4cfef5791bf28373563db5615fd93f8ec4d3cee	003_set_default_values	chef-compiance	Make sure added columns have default values	2016-08-16 21:29:29.905595+00	Ubuntu	ubuntu@compliance	2016-01-14 19:26:43+00	Jason Reed	jreed@Ettores-MacBook-Pro-2.local
df5d1caf40c3332992b93646dc9a548e9265b132	004_fix_nan_in_scans	chef-compiance	Fix eventual NaNs from divide-by-zero (#370)	2016-08-16 21:29:29.918121+00	Ubuntu	ubuntu@compliance	2016-01-25 10:30:46+00	Stephan Renatus	stephan@Stephans-MacBook-Pro.local
912056b1497cdbe56a7e13c69b86cb24f36fbf84	005_node_keys	chef-compiance	Adjust primary key and foreign key constraints for nodes, environments.	2016-08-16 21:29:29.949326+00	Ubuntu	ubuntu@compliance	2015-12-14 17:50:53+00	Jason Reed	jreed@Ettores-MacBook-Pro.local
da3e44de3dcc9746822f7ff5fd77d87494fcab2c	006_node_rule_result_extend_pk	chef-compiance	add profile ID and profile owner to the PK constraints for a scan's result's rule entries	2016-08-16 21:29:29.971548+00	Ubuntu	ubuntu@compliance	2016-02-25 12:28:41+00	Stephan Renatus	srenatus@chef.io
9224d5e0434ca5e28d69484de879ea7b0a892b52	007_set_names	chef-compiance	Before this, we mis-used the user ID for a name and left `name` empty.\nThis change will set name to the ID.	2016-08-16 21:29:29.983452+00	Ubuntu	ubuntu@compliance	2016-03-03 11:05:03+00	Stephan Renatus	srenatus@chef.io
1b779fe3b92b11df03fea53ac9755b40a9674a88	008_add_login	chef-compiance	Add login column to owners, to be used for logging in	2016-08-16 21:29:30.003439+00	Ubuntu	ubuntu@compliance	2016-03-08 08:52:19+00	Stephan Renatus	srenatus@chef.io
55d40b7796f7b24a3d1aa20efbca8dbf975ad0d1	009_unique_access_keys	chef-compiance	Ensures access keys are unique for a user	2016-08-16 21:29:30.021896+00	Ubuntu	ubuntu@compliance	2016-03-08 21:52:39+00	Christoph Hartmann	chartmann@chef.io
9d866e0d54b640e11fb2a3786e54b752b51c667a	010_source_annotations	chef-compiance	Add a sources table that can be references whenever something is created that is not _owned_ by compliance (i.e. chef for now, more might come later)	2016-08-16 21:29:30.047537+00	Ubuntu	ubuntu@compliance	2016-03-17 08:19:52+00	Stephan Renatus	srenatus@chef.io
\.


--
-- Data for Name: dependencies; Type: TABLE DATA; Schema: sqitch; Owner: chef-pgsql
--

COPY dependencies (change_id, type, dependency, dependency_id) FROM stdin;
55d40b7796f7b24a3d1aa20efbca8dbf975ad0d1	require	appschema	cc76e98a1a21eeedbd65fa851cfc4b7770c2e250
\.


--
-- Data for Name: events; Type: TABLE DATA; Schema: sqitch; Owner: chef-pgsql
--

COPY events (event, change_id, change, project, note, requires, conflicts, tags, committed_at, committer_name, committer_email, planned_at, planner_name, planner_email) FROM stdin;
deploy	cc76e98a1a21eeedbd65fa851cfc4b7770c2e250	appschema	chef-compiance	Add schema for chef-compliance	{}	{}	{}	2016-08-16 21:29:29.850353+00	Ubuntu	ubuntu@compliance	2015-10-27 23:34:56+00	Dominik Richter	drichter@chef.io
deploy	15c352699adde4a482ae12932ffd1186f873c298	001_packages_tables_extend_pk	chef-compiance	Extending PK to avoid key constraint errors. Fixes chef-compliance #154	{}	{}	{}	2016-08-16 21:29:29.87926+00	Ubuntu	ubuntu@compliance	2015-12-10 15:30:30+00	Alex Pop	apop@chef.io
deploy	a17f03c5c2cdd17b0171670d7418a676572d65ee	002_add_failure_tracking_to_scan_tables	chef-compiance	Adding `success` and `message` columns to table scan_node_results. Adding `cnt_failed_scans` to scans	{}	{}	{}	2016-08-16 21:29:29.892983+00	Ubuntu	ubuntu@compliance	2015-12-18 12:17:20+00	Alex Pop	apop@chef.io
deploy	e4cfef5791bf28373563db5615fd93f8ec4d3cee	003_set_default_values	chef-compiance	Make sure added columns have default values	{}	{}	{}	2016-08-16 21:29:29.906183+00	Ubuntu	ubuntu@compliance	2016-01-14 19:26:43+00	Jason Reed	jreed@Ettores-MacBook-Pro-2.local
deploy	df5d1caf40c3332992b93646dc9a548e9265b132	004_fix_nan_in_scans	chef-compiance	Fix eventual NaNs from divide-by-zero (#370)	{}	{}	{}	2016-08-16 21:29:29.918721+00	Ubuntu	ubuntu@compliance	2016-01-25 10:30:46+00	Stephan Renatus	stephan@Stephans-MacBook-Pro.local
deploy	912056b1497cdbe56a7e13c69b86cb24f36fbf84	005_node_keys	chef-compiance	Adjust primary key and foreign key constraints for nodes, environments.	{}	{}	{}	2016-08-16 21:29:29.949962+00	Ubuntu	ubuntu@compliance	2015-12-14 17:50:53+00	Jason Reed	jreed@Ettores-MacBook-Pro.local
deploy	da3e44de3dcc9746822f7ff5fd77d87494fcab2c	006_node_rule_result_extend_pk	chef-compiance	add profile ID and profile owner to the PK constraints for a scan's result's rule entries	{}	{}	{}	2016-08-16 21:29:29.97214+00	Ubuntu	ubuntu@compliance	2016-02-25 12:28:41+00	Stephan Renatus	srenatus@chef.io
deploy	9224d5e0434ca5e28d69484de879ea7b0a892b52	007_set_names	chef-compiance	Before this, we mis-used the user ID for a name and left `name` empty.\nThis change will set name to the ID.	{}	{}	{}	2016-08-16 21:29:29.984029+00	Ubuntu	ubuntu@compliance	2016-03-03 11:05:03+00	Stephan Renatus	srenatus@chef.io
deploy	1b779fe3b92b11df03fea53ac9755b40a9674a88	008_add_login	chef-compiance	Add login column to owners, to be used for logging in	{}	{}	{}	2016-08-16 21:29:30.004027+00	Ubuntu	ubuntu@compliance	2016-03-08 08:52:19+00	Stephan Renatus	srenatus@chef.io
deploy	55d40b7796f7b24a3d1aa20efbca8dbf975ad0d1	009_unique_access_keys	chef-compiance	Ensures access keys are unique for a user	{appschema}	{}	{}	2016-08-16 21:29:30.023117+00	Ubuntu	ubuntu@compliance	2016-03-08 21:52:39+00	Christoph Hartmann	chartmann@chef.io
deploy	9d866e0d54b640e11fb2a3786e54b752b51c667a	010_source_annotations	chef-compiance	Add a sources table that can be references whenever something is created that is not _owned_ by compliance (i.e. chef for now, more might come later)	{}	{}	{}	2016-08-16 21:29:30.048095+00	Ubuntu	ubuntu@compliance	2016-03-17 08:19:52+00	Stephan Renatus	srenatus@chef.io
\.


--
-- Data for Name: projects; Type: TABLE DATA; Schema: sqitch; Owner: chef-pgsql
--

COPY projects (project, uri, created_at, creator_name, creator_email) FROM stdin;
chef-compiance	https://github.com/chef/chef-compiance/	2016-08-16 21:29:29.668678+00	Ubuntu	ubuntu@compliance
\.


--
-- Data for Name: tags; Type: TABLE DATA; Schema: sqitch; Owner: chef-pgsql
--

COPY tags (tag_id, tag, project, change_id, note, committed_at, committer_name, committer_email, planned_at, planner_name, planner_email) FROM stdin;
\.


SET search_path = public, pg_catalog;

--
-- Name: access_keys_pkey; Type: CONSTRAINT; Schema: public; Owner: chef-pgsql
--

ALTER TABLE ONLY access_keys
    ADD CONSTRAINT access_keys_pkey PRIMARY KEY (owner, id);


--
-- Name: access_keys_uniqueness; Type: CONSTRAINT; Schema: public; Owner: chef-pgsql
--

ALTER TABLE ONLY access_keys
    ADD CONSTRAINT access_keys_uniqueness UNIQUE (owner, name);


--
-- Name: environments_pkey; Type: CONSTRAINT; Schema: public; Owner: chef-pgsql
--

ALTER TABLE ONLY environments
    ADD CONSTRAINT environments_pkey PRIMARY KEY (id);


--
-- Name: hardening_config_pkey; Type: CONSTRAINT; Schema: public; Owner: chef-pgsql
--

ALTER TABLE ONLY hardening_config
    ADD CONSTRAINT hardening_config_pkey PRIMARY KEY (id);


--
-- Name: job_runs_pkey; Type: CONSTRAINT; Schema: public; Owner: chef-pgsql
--

ALTER TABLE ONLY job_runs
    ADD CONSTRAINT job_runs_pkey PRIMARY KEY (owner, job, run_id);


--
-- Name: job_tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: chef-pgsql
--

ALTER TABLE ONLY job_tasks
    ADD CONSTRAINT job_tasks_pkey PRIMARY KEY (owner, job, id);


--
-- Name: jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: chef-pgsql
--

ALTER TABLE ONLY jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (owner, id);


--
-- Name: login_uniqueness; Type: CONSTRAINT; Schema: public; Owner: chef-pgsql
--

ALTER TABLE ONLY owners
    ADD CONSTRAINT login_uniqueness UNIQUE (login);


--
-- Name: nodes_pkey; Type: CONSTRAINT; Schema: public; Owner: chef-pgsql
--

ALTER TABLE ONLY nodes
    ADD CONSTRAINT nodes_pkey PRIMARY KEY (id);


--
-- Name: owners_pkey; Type: CONSTRAINT; Schema: public; Owner: chef-pgsql
--

ALTER TABLE ONLY owners
    ADD CONSTRAINT owners_pkey PRIMARY KEY (id);


--
-- Name: package_conf_profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: chef-pgsql
--

ALTER TABLE ONLY package_conf_profiles
    ADD CONSTRAINT package_conf_profiles_pkey PRIMARY KEY (owner, id);


--
-- Name: package_confs_pkey; Type: CONSTRAINT; Schema: public; Owner: chef-pgsql
--

ALTER TABLE ONLY package_confs
    ADD CONSTRAINT package_confs_pkey PRIMARY KEY (profile, id);


--
-- Name: packages_available_pkey; Type: CONSTRAINT; Schema: public; Owner: chef-pgsql
--

ALTER TABLE ONLY packages_available
    ADD CONSTRAINT packages_available_pkey PRIMARY KEY (scan, node, environment, name, pkgversion, arch);


--
-- Name: packages_install_pkey; Type: CONSTRAINT; Schema: public; Owner: chef-pgsql
--

ALTER TABLE ONLY packages_install
    ADD CONSTRAINT packages_install_pkey PRIMARY KEY (id);


--
-- Name: packages_installed_pkey; Type: CONSTRAINT; Schema: public; Owner: chef-pgsql
--

ALTER TABLE ONLY packages_installed
    ADD CONSTRAINT packages_installed_pkey PRIMARY KEY (scan, node, environment, name, pkgversion, arch);


--
-- Name: patch_node_results_pkey; Type: CONSTRAINT; Schema: public; Owner: chef-pgsql
--

ALTER TABLE ONLY patch_node_results
    ADD CONSTRAINT patch_node_results_pkey PRIMARY KEY (owner, patch, environment, node);


--
-- Name: patch_runs_pkey; Type: CONSTRAINT; Schema: public; Owner: chef-pgsql
--

ALTER TABLE ONLY patch_runs
    ADD CONSTRAINT patch_runs_pkey PRIMARY KEY (id);


--
-- Name: role_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: chef-pgsql
--

ALTER TABLE ONLY role_permissions
    ADD CONSTRAINT role_permissions_pkey PRIMARY KEY (id);


--
-- Name: scan_node_results_pkey; Type: CONSTRAINT; Schema: public; Owner: chef-pgsql
--

ALTER TABLE ONLY scan_node_results
    ADD CONSTRAINT scan_node_results_pkey PRIMARY KEY (scan, node, environment);


--
-- Name: scan_rule_results_pkey; Type: CONSTRAINT; Schema: public; Owner: chef-pgsql
--

ALTER TABLE ONLY scan_rule_results
    ADD CONSTRAINT scan_rule_results_pkey PRIMARY KEY (scan, node, environment, profile_owner, profile_id, rule);


--
-- Name: scans_pkey; Type: CONSTRAINT; Schema: public; Owner: chef-pgsql
--

ALTER TABLE ONLY scans
    ADD CONSTRAINT scans_pkey PRIMARY KEY (id);


--
-- Name: sources_pkey; Type: CONSTRAINT; Schema: public; Owner: chef-pgsql
--

ALTER TABLE ONLY sources
    ADD CONSTRAINT sources_pkey PRIMARY KEY (id);


--
-- Name: team_members_pkey; Type: CONSTRAINT; Schema: public; Owner: chef-pgsql
--

ALTER TABLE ONLY team_members
    ADD CONSTRAINT team_members_pkey PRIMARY KEY (team, org, "user");


--
-- Name: teams_pkey; Type: CONSTRAINT; Schema: public; Owner: chef-pgsql
--

ALTER TABLE ONLY teams
    ADD CONSTRAINT teams_pkey PRIMARY KEY (id, org);


--
-- Name: user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: chef-pgsql
--

ALTER TABLE ONLY user_permissions
    ADD CONSTRAINT user_permissions_pkey PRIMARY KEY (id, key);


--
-- Name: user_preferences_pkey; Type: CONSTRAINT; Schema: public; Owner: chef-pgsql
--

ALTER TABLE ONLY user_preferences
    ADD CONSTRAINT user_preferences_pkey PRIMARY KEY (id, key);


SET search_path = sqitch, pg_catalog;

--
-- Name: changes_pkey; Type: CONSTRAINT; Schema: sqitch; Owner: chef-pgsql
--

ALTER TABLE ONLY changes
    ADD CONSTRAINT changes_pkey PRIMARY KEY (change_id);


--
-- Name: dependencies_pkey; Type: CONSTRAINT; Schema: sqitch; Owner: chef-pgsql
--

ALTER TABLE ONLY dependencies
    ADD CONSTRAINT dependencies_pkey PRIMARY KEY (change_id, dependency);


--
-- Name: events_pkey; Type: CONSTRAINT; Schema: sqitch; Owner: chef-pgsql
--

ALTER TABLE ONLY events
    ADD CONSTRAINT events_pkey PRIMARY KEY (change_id, committed_at);


--
-- Name: projects_pkey; Type: CONSTRAINT; Schema: sqitch; Owner: chef-pgsql
--

ALTER TABLE ONLY projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (project);


--
-- Name: projects_uri_key; Type: CONSTRAINT; Schema: sqitch; Owner: chef-pgsql
--

ALTER TABLE ONLY projects
    ADD CONSTRAINT projects_uri_key UNIQUE (uri);


--
-- Name: tags_pkey; Type: CONSTRAINT; Schema: sqitch; Owner: chef-pgsql
--

ALTER TABLE ONLY tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (tag_id);


--
-- Name: tags_project_tag_key; Type: CONSTRAINT; Schema: sqitch; Owner: chef-pgsql
--

ALTER TABLE ONLY tags
    ADD CONSTRAINT tags_project_tag_key UNIQUE (project, tag);


SET search_path = public, pg_catalog;

--
-- Name: nodes_fkey_environment; Type: FK CONSTRAINT; Schema: public; Owner: chef-pgsql
--

ALTER TABLE ONLY nodes
    ADD CONSTRAINT nodes_fkey_environment FOREIGN KEY (environment) REFERENCES environments(id);


--
-- Name: nodes_fkey_owner; Type: FK CONSTRAINT; Schema: public; Owner: chef-pgsql
--

ALTER TABLE ONLY nodes
    ADD CONSTRAINT nodes_fkey_owner FOREIGN KEY (owner) REFERENCES owners(id);


--
-- Name: owners_fk_source; Type: FK CONSTRAINT; Schema: public; Owner: chef-pgsql
--

ALTER TABLE ONLY owners
    ADD CONSTRAINT owners_fk_source FOREIGN KEY (source) REFERENCES sources(id);


SET search_path = sqitch, pg_catalog;

--
-- Name: changes_project_fkey; Type: FK CONSTRAINT; Schema: sqitch; Owner: chef-pgsql
--

ALTER TABLE ONLY changes
    ADD CONSTRAINT changes_project_fkey FOREIGN KEY (project) REFERENCES projects(project) ON UPDATE CASCADE;


--
-- Name: dependencies_change_id_fkey; Type: FK CONSTRAINT; Schema: sqitch; Owner: chef-pgsql
--

ALTER TABLE ONLY dependencies
    ADD CONSTRAINT dependencies_change_id_fkey FOREIGN KEY (change_id) REFERENCES changes(change_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: dependencies_dependency_id_fkey; Type: FK CONSTRAINT; Schema: sqitch; Owner: chef-pgsql
--

ALTER TABLE ONLY dependencies
    ADD CONSTRAINT dependencies_dependency_id_fkey FOREIGN KEY (dependency_id) REFERENCES changes(change_id) ON UPDATE CASCADE;


--
-- Name: events_project_fkey; Type: FK CONSTRAINT; Schema: sqitch; Owner: chef-pgsql
--

ALTER TABLE ONLY events
    ADD CONSTRAINT events_project_fkey FOREIGN KEY (project) REFERENCES projects(project) ON UPDATE CASCADE;


--
-- Name: tags_change_id_fkey; Type: FK CONSTRAINT; Schema: sqitch; Owner: chef-pgsql
--

ALTER TABLE ONLY tags
    ADD CONSTRAINT tags_change_id_fkey FOREIGN KEY (change_id) REFERENCES changes(change_id) ON UPDATE CASCADE;


--
-- Name: tags_project_fkey; Type: FK CONSTRAINT; Schema: sqitch; Owner: chef-pgsql
--

ALTER TABLE ONLY tags
    ADD CONSTRAINT tags_project_fkey FOREIGN KEY (project) REFERENCES projects(project) ON UPDATE CASCADE;


--
-- Name: public; Type: ACL; Schema: -; Owner: chef-pgsql
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM "chef-pgsql";
GRANT ALL ON SCHEMA public TO "chef-pgsql";
GRANT ALL ON SCHEMA public TO PUBLIC;


SET search_path = public, pg_catalog;

--
-- Name: access_keys; Type: ACL; Schema: public; Owner: chef-pgsql
--

REVOKE ALL ON TABLE access_keys FROM PUBLIC;
REVOKE ALL ON TABLE access_keys FROM "chef-pgsql";
GRANT ALL ON TABLE access_keys TO "chef-pgsql";
GRANT ALL ON TABLE access_keys TO chef_compliance;
GRANT SELECT ON TABLE access_keys TO chef_compliance_ro;


--
-- Name: environments; Type: ACL; Schema: public; Owner: chef-pgsql
--

REVOKE ALL ON TABLE environments FROM PUBLIC;
REVOKE ALL ON TABLE environments FROM "chef-pgsql";
GRANT ALL ON TABLE environments TO "chef-pgsql";
GRANT ALL ON TABLE environments TO chef_compliance;
GRANT SELECT ON TABLE environments TO chef_compliance_ro;


--
-- Name: hardening_config; Type: ACL; Schema: public; Owner: chef-pgsql
--

REVOKE ALL ON TABLE hardening_config FROM PUBLIC;
REVOKE ALL ON TABLE hardening_config FROM "chef-pgsql";
GRANT ALL ON TABLE hardening_config TO "chef-pgsql";
GRANT ALL ON TABLE hardening_config TO chef_compliance;
GRANT SELECT ON TABLE hardening_config TO chef_compliance_ro;


--
-- Name: job_runs; Type: ACL; Schema: public; Owner: chef-pgsql
--

REVOKE ALL ON TABLE job_runs FROM PUBLIC;
REVOKE ALL ON TABLE job_runs FROM "chef-pgsql";
GRANT ALL ON TABLE job_runs TO "chef-pgsql";
GRANT ALL ON TABLE job_runs TO chef_compliance;
GRANT SELECT ON TABLE job_runs TO chef_compliance_ro;


--
-- Name: job_tasks; Type: ACL; Schema: public; Owner: chef-pgsql
--

REVOKE ALL ON TABLE job_tasks FROM PUBLIC;
REVOKE ALL ON TABLE job_tasks FROM "chef-pgsql";
GRANT ALL ON TABLE job_tasks TO "chef-pgsql";
GRANT ALL ON TABLE job_tasks TO chef_compliance;
GRANT SELECT ON TABLE job_tasks TO chef_compliance_ro;


--
-- Name: jobs; Type: ACL; Schema: public; Owner: chef-pgsql
--

REVOKE ALL ON TABLE jobs FROM PUBLIC;
REVOKE ALL ON TABLE jobs FROM "chef-pgsql";
GRANT ALL ON TABLE jobs TO "chef-pgsql";
GRANT ALL ON TABLE jobs TO chef_compliance;
GRANT SELECT ON TABLE jobs TO chef_compliance_ro;


--
-- Name: nodes; Type: ACL; Schema: public; Owner: chef-pgsql
--

REVOKE ALL ON TABLE nodes FROM PUBLIC;
REVOKE ALL ON TABLE nodes FROM "chef-pgsql";
GRANT ALL ON TABLE nodes TO "chef-pgsql";
GRANT ALL ON TABLE nodes TO chef_compliance;
GRANT SELECT ON TABLE nodes TO chef_compliance_ro;


--
-- Name: owners; Type: ACL; Schema: public; Owner: chef-pgsql
--

REVOKE ALL ON TABLE owners FROM PUBLIC;
REVOKE ALL ON TABLE owners FROM "chef-pgsql";
GRANT ALL ON TABLE owners TO "chef-pgsql";
GRANT ALL ON TABLE owners TO chef_compliance;
GRANT SELECT ON TABLE owners TO chef_compliance_ro;


--
-- Name: package_conf_profiles; Type: ACL; Schema: public; Owner: chef-pgsql
--

REVOKE ALL ON TABLE package_conf_profiles FROM PUBLIC;
REVOKE ALL ON TABLE package_conf_profiles FROM "chef-pgsql";
GRANT ALL ON TABLE package_conf_profiles TO "chef-pgsql";
GRANT ALL ON TABLE package_conf_profiles TO chef_compliance;
GRANT SELECT ON TABLE package_conf_profiles TO chef_compliance_ro;


--
-- Name: package_confs; Type: ACL; Schema: public; Owner: chef-pgsql
--

REVOKE ALL ON TABLE package_confs FROM PUBLIC;
REVOKE ALL ON TABLE package_confs FROM "chef-pgsql";
GRANT ALL ON TABLE package_confs TO "chef-pgsql";
GRANT ALL ON TABLE package_confs TO chef_compliance;
GRANT SELECT ON TABLE package_confs TO chef_compliance_ro;


--
-- Name: packages_available; Type: ACL; Schema: public; Owner: chef-pgsql
--

REVOKE ALL ON TABLE packages_available FROM PUBLIC;
REVOKE ALL ON TABLE packages_available FROM "chef-pgsql";
GRANT ALL ON TABLE packages_available TO "chef-pgsql";
GRANT ALL ON TABLE packages_available TO chef_compliance;
GRANT SELECT ON TABLE packages_available TO chef_compliance_ro;


--
-- Name: packages_install; Type: ACL; Schema: public; Owner: chef-pgsql
--

REVOKE ALL ON TABLE packages_install FROM PUBLIC;
REVOKE ALL ON TABLE packages_install FROM "chef-pgsql";
GRANT ALL ON TABLE packages_install TO "chef-pgsql";
GRANT ALL ON TABLE packages_install TO chef_compliance;
GRANT SELECT ON TABLE packages_install TO chef_compliance_ro;


--
-- Name: packages_installed; Type: ACL; Schema: public; Owner: chef-pgsql
--

REVOKE ALL ON TABLE packages_installed FROM PUBLIC;
REVOKE ALL ON TABLE packages_installed FROM "chef-pgsql";
GRANT ALL ON TABLE packages_installed TO "chef-pgsql";
GRANT ALL ON TABLE packages_installed TO chef_compliance;
GRANT SELECT ON TABLE packages_installed TO chef_compliance_ro;


--
-- Name: patch_node_results; Type: ACL; Schema: public; Owner: chef-pgsql
--

REVOKE ALL ON TABLE patch_node_results FROM PUBLIC;
REVOKE ALL ON TABLE patch_node_results FROM "chef-pgsql";
GRANT ALL ON TABLE patch_node_results TO "chef-pgsql";
GRANT ALL ON TABLE patch_node_results TO chef_compliance;
GRANT SELECT ON TABLE patch_node_results TO chef_compliance_ro;


--
-- Name: patch_runs; Type: ACL; Schema: public; Owner: chef-pgsql
--

REVOKE ALL ON TABLE patch_runs FROM PUBLIC;
REVOKE ALL ON TABLE patch_runs FROM "chef-pgsql";
GRANT ALL ON TABLE patch_runs TO "chef-pgsql";
GRANT ALL ON TABLE patch_runs TO chef_compliance;
GRANT SELECT ON TABLE patch_runs TO chef_compliance_ro;


--
-- Name: role_permissions; Type: ACL; Schema: public; Owner: chef-pgsql
--

REVOKE ALL ON TABLE role_permissions FROM PUBLIC;
REVOKE ALL ON TABLE role_permissions FROM "chef-pgsql";
GRANT ALL ON TABLE role_permissions TO "chef-pgsql";
GRANT ALL ON TABLE role_permissions TO chef_compliance;
GRANT SELECT ON TABLE role_permissions TO chef_compliance_ro;


--
-- Name: scan_node_results; Type: ACL; Schema: public; Owner: chef-pgsql
--

REVOKE ALL ON TABLE scan_node_results FROM PUBLIC;
REVOKE ALL ON TABLE scan_node_results FROM "chef-pgsql";
GRANT ALL ON TABLE scan_node_results TO "chef-pgsql";
GRANT ALL ON TABLE scan_node_results TO chef_compliance;
GRANT SELECT ON TABLE scan_node_results TO chef_compliance_ro;


--
-- Name: scan_rule_results; Type: ACL; Schema: public; Owner: chef-pgsql
--

REVOKE ALL ON TABLE scan_rule_results FROM PUBLIC;
REVOKE ALL ON TABLE scan_rule_results FROM "chef-pgsql";
GRANT ALL ON TABLE scan_rule_results TO "chef-pgsql";
GRANT ALL ON TABLE scan_rule_results TO chef_compliance;
GRANT SELECT ON TABLE scan_rule_results TO chef_compliance_ro;


--
-- Name: scans; Type: ACL; Schema: public; Owner: chef-pgsql
--

REVOKE ALL ON TABLE scans FROM PUBLIC;
REVOKE ALL ON TABLE scans FROM "chef-pgsql";
GRANT ALL ON TABLE scans TO "chef-pgsql";
GRANT ALL ON TABLE scans TO chef_compliance;
GRANT SELECT ON TABLE scans TO chef_compliance_ro;


--
-- Name: sources; Type: ACL; Schema: public; Owner: chef-pgsql
--

REVOKE ALL ON TABLE sources FROM PUBLIC;
REVOKE ALL ON TABLE sources FROM "chef-pgsql";
GRANT ALL ON TABLE sources TO "chef-pgsql";
GRANT ALL ON TABLE sources TO chef_compliance;
GRANT SELECT ON TABLE sources TO chef_compliance_ro;


--
-- Name: team_members; Type: ACL; Schema: public; Owner: chef-pgsql
--

REVOKE ALL ON TABLE team_members FROM PUBLIC;
REVOKE ALL ON TABLE team_members FROM "chef-pgsql";
GRANT ALL ON TABLE team_members TO "chef-pgsql";
GRANT ALL ON TABLE team_members TO chef_compliance;
GRANT SELECT ON TABLE team_members TO chef_compliance_ro;


--
-- Name: teams; Type: ACL; Schema: public; Owner: chef-pgsql
--

REVOKE ALL ON TABLE teams FROM PUBLIC;
REVOKE ALL ON TABLE teams FROM "chef-pgsql";
GRANT ALL ON TABLE teams TO "chef-pgsql";
GRANT ALL ON TABLE teams TO chef_compliance;
GRANT SELECT ON TABLE teams TO chef_compliance_ro;


--
-- Name: user_permissions; Type: ACL; Schema: public; Owner: chef-pgsql
--

REVOKE ALL ON TABLE user_permissions FROM PUBLIC;
REVOKE ALL ON TABLE user_permissions FROM "chef-pgsql";
GRANT ALL ON TABLE user_permissions TO "chef-pgsql";
GRANT ALL ON TABLE user_permissions TO chef_compliance;
GRANT SELECT ON TABLE user_permissions TO chef_compliance_ro;


--
-- Name: user_preferences; Type: ACL; Schema: public; Owner: chef-pgsql
--

REVOKE ALL ON TABLE user_preferences FROM PUBLIC;
REVOKE ALL ON TABLE user_preferences FROM "chef-pgsql";
GRANT ALL ON TABLE user_preferences TO "chef-pgsql";
GRANT ALL ON TABLE user_preferences TO chef_compliance;
GRANT SELECT ON TABLE user_preferences TO chef_compliance_ro;


--
-- PostgreSQL database dump complete
--

