
(** {1 Framework} *)

module Maingoblint = Maingoblint
module Control = Control
module Server = Server

(** {2 CFG}

    Control-flow graphs (CFGs) are used to represent each function. *)

module Node = Node
module Edge = Edge
module MyCFG = MyCFG
module CfgTools = CfgTools

(** {2 Specification}

    Analyses are specified by domains and transfer functions.
    A dynamic composition of analyses is combined with CFGs to produce a constraint system. *)

module Analyses = Analyses
module Constraints = Constraints
module AnalysisState = AnalysisState
module ControlSpecC = ControlSpecC

(** Master control program (MCP) is the analysis specification for the dynamic product of activated analyses. *)

module MCP = MCP
module MCPRegistry = MCPRegistry
module MCPAccess = MCPAccess

(** MCP allows activated analyses to query each other during the analysis.
    Query results from different analyses for the same query are {{!Lattice.S.meet} met} for precision. *)

module Queries = Queries

(** MCP allows activated analyses to emit events to each other during the analysis. *)

module Events = Events

(** {2 Results}

    The following modules help query the constraint system solution using semantic information. *)

module ResultQuery = ResultQuery
module VarQuery = VarQuery

(** {2 Configuration}

    Runtime configuration is represented as JSON.
    Options are specified and documented by the JSON schema [src/util/options.schema.json]. *)

module GobConfig = GobConfig
module AfterConfig = AfterConfig

module AutoTune = AutoTune

module JsonSchema = JsonSchema
module Options = Options


(** {1 Analyses}

    Analyses activatable under MCP. *)

(** {2 Value}

    Analyses related to values of program variables. *)

module Base = Base
module RelationAnalysis = RelationAnalysis
module ApronAnalysis = ApronAnalysis
module AffineEqualityAnalysis = AffineEqualityAnalysis
module VarEq = VarEq
module CondVars = CondVars

(** {2 Heap}

    Analyses related to the heap. *)

module Region = Region
module MallocFresh = MallocFresh
module Malloc_null = Malloc_null

(** {2 Concurrency}

    Analyses related to concurrency. *)

(** {3 Locks}

    Analyses related to locking. *)

module MutexEventsAnalysis = MutexEventsAnalysis
module LocksetAnalysis = LocksetAnalysis
module MutexTypeAnalysis = MutexTypeAnalysis
module MutexAnalysis = MutexAnalysis
module MayLocks = MayLocks
module SymbLocks = SymbLocks
module Deadlock = Deadlock

(** {3 Threads}

    Analyses related to threads. *)

module ThreadFlag = ThreadFlag
module ThreadId = ThreadId
module ThreadAnalysis = ThreadAnalysis
module ThreadJoins = ThreadJoins
module MHPAnalysis = MHPAnalysis
module ThreadReturn = ThreadReturn

(** {3 Other} *)

module RaceAnalysis = RaceAnalysis
module BasePriv = BasePriv
module RelationPriv = RelationPriv
module ThreadEscape = ThreadEscape
module PthreadSignals = PthreadSignals
module ExtractPthread = ExtractPthread

(** {2 Longjmp}

    Analyses related to [longjmp] and [setjmp]. *)

module ActiveSetjmp = ActiveSetjmp
module ModifiedSinceLongjmp = ModifiedSinceLongjmp
module ActiveLongjmp = ActiveLongjmp
module PoisonVariables = PoisonVariables
module Vla = Vla

(** {2 Tutorial}

    Analyses for didactic purposes. *)

module Constants = Constants
module Signs = Signs
module Taint = Taint
module UnitAnalysis = UnitAnalysis

(** {2 Other} *)

module Assert = Assert
module FileUse = FileUse
module Uninit = Uninit
module Termination = Termination
module Expsplit = Expsplit
module StackTrace = StackTrace
module Spec = Spec

(** {2 Helper}

    Analyses which only support other analyses. *)

module AccessAnalysis = AccessAnalysis
module WrapperFunctionAnalysis = WrapperFunctionAnalysis
module TaintPartialContexts = TaintPartialContexts
module UnassumeAnalysis = UnassumeAnalysis
module ExpRelation = ExpRelation
module AbortUnless = AbortUnless


(** {1 Domains}

    Domains used by analysis specifications and constraint systems are {{!Lattice.S} lattices}.

    Besides lattice operations, their elements can also be compared and output (in various formats).
    Those operations are specified by {!Printable.S}. *)

module Printable = Printable
module Lattice = Lattice

(** {2 General}

    Standard general-purpose domains and domain functors. *)

module BoolDomain = BoolDomain
module SetDomain = SetDomain
module MapDomain = MapDomain
module DisjointDomain = DisjointDomain
module HoareDomain = HoareDomain
module PartitionDomain = PartitionDomain
module FlagHelper = FlagHelper

(** {2 Analysis-specific}

    Domains for specific analyses. *)

(** {3 Value} *)

(** {4 Non-relational}

    Domains for {!Base} analysis. *)

module BaseDomain = BaseDomain
module ValueDomain = ValueDomain
module IntDomain = IntDomain
module FloatDomain = FloatDomain
module AddressDomain = AddressDomain
module StructDomain = StructDomain
module UnionDomain = UnionDomain
module ArrayDomain = ArrayDomain
module JmpBufDomain = JmpBufDomain
module ValueDomainQueries = ValueDomainQueries

(** {4 Relational}

    Domains for {!RelationAnalysis}. *)

module RelationDomain = RelationDomain
module ApronDomain = ApronDomain
module AffineEqualityDomain = AffineEqualityDomain

(** {3 Concurrency} *)

module MutexAttrDomain = MutexAttrDomain
module LockDomain = LockDomain
module SymbLocksDomain = SymbLocksDomain
module DeadlockDomain = DeadlockDomain

module ThreadFlagDomain = ThreadFlagDomain
module ThreadIdDomain = ThreadIdDomain
module ConcDomain = ConcDomain
module MHP = MHP

module EscapeDomain = EscapeDomain
module PthreadDomain = PthreadDomain

(** {3 Other} *)

module Basetype = Basetype
module Lval = Lval
module CilLval = CilLval
module Access = Access
module AccessDomain = AccessDomain

module MusteqDomain = MusteqDomain
module RegionDomain = RegionDomain
module FileDomain = FileDomain
module StackDomain = StackDomain

module LvalMapDomain = LvalMapDomain
module SpecDomain = SpecDomain

(** {2 Testing}

    Modules related to (property-based) testing of domains. *)

module DomainProperties = DomainProperties
module AbstractionDomainProperties = AbstractionDomainProperties
module IntDomainProperties = IntDomainProperties


(** {1 Incremental}

    Incremental analysis is for analyzing multiple versions of the same program and reusing as many results as possible. *)

module CompareCIL = CompareCIL
module CompareAST = CompareAST
module CompareCFG = CompareCFG
module UpdateCil = UpdateCil
module MaxIdUtil = MaxIdUtil
module Serialize = Serialize
module CilMaps = CilMaps


(** {1 Solvers}

    Generic solvers are used to solve {{!Analyses.MonSystem} (side-effecting) constraint systems}. *)

(** {2 Top-down}

    The top-down solver family. *)

module Td3 = Td3
module TopDown = TopDown
module TopDown_term = TopDown_term
module TopDown_space_cache_term = TopDown_space_cache_term
module TopDown_deprecated = TopDown_deprecated

(** {2 SLR}

    The SLR solver family. *)

module SLRphased = SLRphased
module SLRterm = SLRterm
module SLR = SLR

(** {2 Other} *)

module EffectWConEq = EffectWConEq
module Worklist = Worklist
module Generic = Generic
module Selector = Selector

module PostSolver = PostSolver
module LocalFixpoint = LocalFixpoint
module SolverStats = SolverStats
module SolverBox = SolverBox


(** {1 I/O}

    Various input/output interfaces and formats. *)

module Messages = Messages
module Tracing = Tracing

(** {2 Front-end}

    The following modules handle program input. *)

module Preprocessor = Preprocessor
module CompilationDatabase = CompilationDatabase
module MakefileUtil = MakefileUtil

(** {2 Witnesses}

    Witnesses are an exchangeable format for analysis results. *)

module Svcomp = Svcomp
module SvcompSpec = SvcompSpec

module Invariant = Invariant
module InvariantCil = InvariantCil
module WitnessUtil = WitnessUtil

(** {3 GraphML}

    Automaton-based GraphML witnesses used in SV-COMP. *)

module MyARG = MyARG
module WitnessConstraints = WitnessConstraints
module ArgTools = ArgTools
module Witness = Witness
module Graphml = Graphml

(** {3 YAML}

    Entry-based YAML witnesses to be used in SV-COMP. *)

module YamlWitness = YamlWitness
module YamlWitnessType = YamlWitnessType
module WideningTokens = WideningTokens

(** {3 Violation}

    Experimental generation of violation witness automata or refinement with observer automata. *)

module Violation = Violation
module ViolationZ3 = ViolationZ3
module ObserverAutomaton = ObserverAutomaton
module ObserverAnalysis = ObserverAnalysis
module Refinement = Refinement

(** {2 SARIF} *)

module Sarif = Sarif
module SarifType = SarifType
module SarifRules = SarifRules


(** {1 Transformations}

    Transformations can be activated to transform the program using analysis results. *)

module Transform = Transform
module DeadCode = DeadCode
module EvalAssert = EvalAssert
module ExpressionEvaluation = ExpressionEvaluation


(** {1 Utilities} *)

module Timing = Timing
module GoblintDir = GoblintDir

(** {2 General} *)

module IntOps = IntOps
module FloatOps = FloatOps

module LazyEval = LazyEval
module ResettableLazy = ResettableLazy

module ProcessPool = ProcessPool
module Timeout = Timeout

module TimeUtil = TimeUtil
module MessageUtil = MessageUtil
module XmlUtil = XmlUtil

(** {2 CIL} *)

module CilType = CilType
module Cilfacade = Cilfacade
module RichVarinfo = RichVarinfo

module CilCfg = CilCfg
module LoopUnrolling = LoopUnrolling

(** {2 Library specification}

    For more precise analysis of C standard library, etc functions, whose definitions are not available, custom specifications can be added. *)

module AccessKind = AccessKind
module LibraryDesc = LibraryDesc
module LibraryDsl = LibraryDsl
module LibraryFunctions = LibraryFunctions

(** {2 Analysis-specific} *)

module BaseUtil = BaseUtil
module PrecisionUtil = PrecisionUtil
module ContextUtil = ContextUtil
module BaseInvariant = BaseInvariant
module CommonPriv = CommonPriv
module WideningThresholds = WideningThresholds

module VectorMatrix = VectorMatrix
module SharedFunctions = SharedFunctions

(** {2 Precision comparison} *)

module PrecCompare = PrecCompare
module PrecCompareUtil = PrecCompareUtil
module PrivPrecCompareUtil = PrivPrecCompareUtil
module RelationPrecCompareUtil = RelationPrecCompareUtil
module ApronPrecCompareUtil = ApronPrecCompareUtil

(** {2 Build info} *)

(** OCaml compiler info. *)
module ConfigOcaml = ConfigOcaml

(** Dune profile info. *)
module ConfigProfile = ConfigProfile

(** Goblint version info. *)
module Version = Version

(** Goblint git version info. *)
module ConfigVersion = ConfigVersion


(** {1 Library extensions}

    OCaml library extensions which are completely independent of Goblint. *)

(** {2 Standard library}

    OCaml standard library extensions which are not provided by {!Batteries}. *)

module GobFormat = GobFormat
module GobGc = GobGc
module GobHashtbl = GobHashtbl
module GobList = GobList
module GobRef = GobRef
module GobResult = GobResult
module GobOption = GobOption
module GobSys = GobSys
module GobUnix = GobUnix

(** {2 Other libraries}

    External library extensions. *)

module GobFpath = GobFpath
module GobPretty = GobPretty
module GobYaml = GobYaml
module GobYojson = GobYojson
module GobZ = GobZ
module MyCheck = MyCheck