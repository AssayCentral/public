<?xml version="1.0" encoding="UTF-8"?>
<Workflow>
    <Meta>
        <Description>Creation for: influenza/A</Description>
    </Meta>
    <Nodes>
        <Node id="1" name="ReadSource1" op="com.mmi.work.op.io.ReadDataSheet">
            <Parameters>
                <Parameter name="filename">../chembl23/InfluenzaAvirus-InfluenzaAvirus-O-F-CHEMBL613740-Functional-K.ds</Parameter>
            </Parameters>
            <Outputs count="1"/>
        </Node>
        <Node id="2" name="Indexer1" op="com.mmi.work.op.fmt.Value">
            <Parameters>
                <Parameter name="column">
                    <s>_original_src</s>
                    <s>_original_row</s>
                    <s>_priority</s>
                </Parameter>
                <Parameter name="type">
                    <s>integer</s>
                    <s>integer</s>
                    <s>integer</s>
                </Parameter>
                <Parameter name="descr">
                    <s>Original file index (1-based)</s>
                    <s>Original row index (1-based)</s>
                    <s>Assimilation priority</s>
                </Parameter>
                <Parameter name="expression">
                    <s>1</s>
                    <s>${.row}</s>
                    <s>0</s>
                </Parameter>
            </Parameters>
            <Input id="1" port="1"/>
            <Outputs count="1"/>
        </Node>
        <Node id="3" name="stdclean1_Clean" op="com.mmi.work.op.mol.NormaliseStructure">
            <Parameters>
                <Parameter name="columns">
                    <s>Molecule</s>
                </Parameter>
                <Parameter name="pluralComponents">true</Parameter>
                <Parameter name="uniqueComponents">true</Parameter>
                <Parameter name="stripHydrogens">true</Parameter>
                <Parameter name="saltWash">true</Parameter>
                <Parameter name="neutraliseProtons">true</Parameter>
                <Parameter name="normaliseBonds">true</Parameter>
                <Parameter name="unmapNumbers">true</Parameter>
            </Parameters>
            <Input id="2" name="ReadData" port="1"/>
            <Outputs count="1"/>
        </Node>
        <Node id="4" name="ReadSource2" op="com.mmi.work.op.io.ReadDataSheet">
            <Parameters>
                <Parameter name="filename">doi-10.1038-s41598-017-10021-w.ds</Parameter>
            </Parameters>
            <Outputs count="1"/>
        </Node>
        <Node id="5" name="Indexer2" op="com.mmi.work.op.fmt.Value">
            <Parameters>
                <Parameter name="column">
                    <s>_original_src</s>
                    <s>_original_row</s>
                    <s>_priority</s>
                </Parameter>
                <Parameter name="type">
                    <s>integer</s>
                    <s>integer</s>
                    <s>integer</s>
                </Parameter>
                <Parameter name="descr">
                    <s>Original file index (1-based)</s>
                    <s>Original row index (1-based)</s>
                    <s>Assimilation priority</s>
                </Parameter>
                <Parameter name="expression">
                    <s>2</s>
                    <s>${.row}</s>
                    <s>0</s>
                </Parameter>
            </Parameters>
            <Input id="4" port="1"/>
            <Outputs count="1"/>
        </Node>
        <Node id="6" name="stdclean2_Clean" op="com.mmi.work.op.mol.NormaliseStructure">
            <Parameters>
                <Parameter name="columns">
                    <s>Molecule</s>
                </Parameter>
                <Parameter name="pluralComponents">true</Parameter>
                <Parameter name="uniqueComponents">true</Parameter>
                <Parameter name="stripHydrogens">true</Parameter>
                <Parameter name="saltWash">true</Parameter>
                <Parameter name="neutraliseProtons">true</Parameter>
                <Parameter name="normaliseBonds">true</Parameter>
                <Parameter name="unmapNumbers">true</Parameter>
            </Parameters>
            <Input id="5" name="ReadData" port="1"/>
            <Outputs count="1"/>
        </Node>
        <Node id="7" name="CheckValidity2" op="com.mmi.assaycentral.build.op.CheckValidMolecule">
            <Input id="6" port="1"/>
            <Outputs count="2"/>
        </Node>
        <Node id="8" name="SourceFilenamesRejects" op="com.mmi.work.op.fmt.MapValues">
            <Parameters>
                <Parameter name="from">_original_src</Parameter>
                <Parameter name="to">SourceFile</Parameter>
                <Parameter name="type">string</Parameter>
                <Parameter name="keys">
                    <s>1</s>
                    <s>2</s>
                </Parameter>
                <Parameter name="values">
                    <s>../chembl23/InfluenzaAvirus-InfluenzaAvirus-O-F-CHEMBL613740-Functional-K.ds</s>
                    <s>doi-10.1038-s41598-017-10021-w.ds</s>
                </Parameter>
            </Parameters>
            <Input id="7" port="2"/>
            <Outputs count="1"/>
        </Node>
        <Node id="9" name="WriteRejects" op="com.mmi.work.op.io.WriteDataSheet">
            <Parameters>
                <Parameter name="filename">rejects.ds</Parameter>
                <Parameter name="autoDelete">true</Parameter>
            </Parameters>
            <Input id="8" port="1"/>
            <Outputs count="0"/>
        </Node>
        <Node id="10" name="MergeStreams" op="com.mmi.work.op.blk.Splice">
            <Parameters>
                <Parameter name="headerUnion">true</Parameter>
            </Parameters>
            <Input id="3" port="1"/>
            <Input id="7" port="1"/>
            <Outputs count="1"/>
        </Node>
        <Node id="11" name="Consolidate" op="com.mmi.assaycentral.build.op.ConsolidateAssayProvenance">
            <Parameters>
                <Parameter name="keepColumns">
                    <s>_original_src</s>
                    <s>_original_row</s>
                    <s>_priority</s>
                </Parameter>
                <Parameter name="title">Influenza A</Parameter>
                <Parameter name="description">Influenza A virus</Parameter>
                <Parameter name="headerTargetName">Influenza A virus</Parameter>
                <Parameter name="headerTargetURI">https://www.ebi.ac.uk/chembl/target/inspect/CHEMBL613740</Parameter>
                <Parameter name="headerOrganismName">Influenza A virus</Parameter>
                <Parameter name="headerOrganismURI">https://www.uniprot.org/taxonomy/197911</Parameter>
                <Parameter name="headerTargetTypeName">Virus</Parameter>
                <Parameter name="headerAssayTypeName">Functional</Parameter>
            </Parameters>
            <Input id="10" port="1"/>
            <Outputs count="1"/>
        </Node>
        <Node id="12" name="HeavyHash" op="com.mmi.work.op.calc.MoleculeProperties">
            <Parameters>
                <Parameter name="heavyHash">HeavyHash</Parameter>
            </Parameters>
            <Input id="11" port="1"/>
            <Outputs count="1"/>
        </Node>
        <Node id="13" name="SortHash" op="com.mmi.work.op.blk.Sort">
            <Parameters>
                <Parameter name="columns">
                    <s>HeavyHash</s>
                </Parameter>
            </Parameters>
            <Input id="12" port="1"/>
            <Outputs count="1"/>
        </Node>
        <Node id="14" name="Assimilate" op="com.mmi.assaycentral.build.op.AssimilateActivities">
            <Parameters>
                <Parameter name="hashBlock">HeavyHash</Parameter>
            </Parameters>
            <Input id="13" port="1"/>
            <Outputs count="2"/>
        </Node>
        <Node id="15" name="SourceFilenamesBadmerge" op="com.mmi.work.op.fmt.MapValues">
            <Parameters>
                <Parameter name="from">_original_src</Parameter>
                <Parameter name="to">SourceFile</Parameter>
                <Parameter name="type">string</Parameter>
                <Parameter name="keys">
                    <s>1</s>
                    <s>2</s>
                </Parameter>
                <Parameter name="values">
                    <s>../chembl23/InfluenzaAvirus-InfluenzaAvirus-O-F-CHEMBL613740-Functional-K.ds</s>
                    <s>doi-10.1038-s41598-017-10021-w.ds</s>
                </Parameter>
            </Parameters>
            <Input id="14" port="2"/>
            <Outputs count="1"/>
        </Node>
        <Node id="16" name="WriteBadmerge" op="com.mmi.work.op.io.WriteDataSheet">
            <Parameters>
                <Parameter name="filename">badmerge.ds</Parameter>
                <Parameter name="autoDelete">true</Parameter>
            </Parameters>
            <Input id="15" port="1"/>
            <Outputs count="0"/>
        </Node>
        <Node id="17" name="MultiplexOutput" op="com.mmi.work.op.blk.Multiplex">
            <Input id="14" port="1"/>
            <Outputs count="5"/>
        </Node>
        <Node id="18" name="WriteOutput" op="com.mmi.work.op.io.WriteDataSheet">
            <Parameters>
                <Parameter name="filename">assay.ds</Parameter>
                <Parameter name="autoDelete">false</Parameter>
            </Parameters>
            <Input id="17" port="1"/>
            <Outputs count="0"/>
        </Node>
        <Node id="19" name="CalculateThreshold" op="com.mmi.work.op.model.EstimateThreshold">
            <Input id="17" port="2"/>
            <Outputs count="0"/>
        </Node>
        <Node id="20" name="BuildModel" op="com.mmi.work.op.model.BuildBayesian">
            <Parameters>
                <Parameter name="molecule">Molecule</Parameter>
                <Parameter name="response">Value</Parameter>
                <Parameter name="fingerprint">ECFP6</Parameter>
                <Parameter name="folding">0</Parameter>
                <Parameter name="validation">five-fold</Parameter>
                <Parameter name="noteTitle">Influenza A</Parameter>
                <Parameter name="noteOrigin">Assay Central</Parameter>
                <Parameter name="noteField">influenza/A</Parameter>
                <Parameter name="noteComments"/>
                <Parameter name="thresholdValue" nodeID="19" resultName="threshold"/>
                <Parameter name="thresholdRelation">&gt;</Parameter>
            </Parameters>
            <Input id="17" port="3"/>
            <Outputs count="0"/>
        </Node>
        <Node id="21" name="SaveModel" op="com.mmi.work.op.model.SaveBayesian">
            <Parameters>
                <Parameter name="filename">assay.bayesian</Parameter>
                <Parameter name="model" nodeID="20" resultName="model"/>
            </Parameters>
            <Outputs count="0"/>
        </Node>
        <Node id="22" name="DomainApplicability" op="com.mmi.assaycentral.build.op.CalculateDomainApplicability">
            <Parameters>
                <Parameter name="filename">../../domain.ecfp</Parameter>
            </Parameters>
            <Input id="17" port="4"/>
            <Outputs count="0"/>
        </Node>
        <Node id="23" name="DiscardRows" op="com.mmi.work.op.io.Sink">
            <Input id="17" port="5"/>
            <Outputs count="1"/>
        </Node>
        <Node id="24" name="WriteSummary" op="com.mmi.assaycentral.build.op.CaptureBrochureSummary">
            <Parameters>
                <Parameter name="filename">summary.json</Parameter>
                <Parameter name="model" nodeID="20" resultName="model"/>
                <Parameter name="directory">influenza/A</Parameter>
                <Parameter name="dataFN">assay.ds</Parameter>
                <Parameter name="modelFN">assay.bayesian</Parameter>
                <Parameter name="tags">
                    <s>Influenza</s>
                </Parameter>
                <Parameter name="responseType">target</Parameter>
                <Parameter name="scenarioModelFN"/>
                <Parameter name="domainCompat" nodeID="22" resultName="domain"/>
                <Parameter name="countReject" nodeID="9" resultName="rowCount"/>
                <Parameter name="countBadmerge" nodeID="16" resultName="rowCount"/>
            </Parameters>
            <Input id="23" port="1"/>
            <Outputs count="0"/>
        </Node>
    </Nodes>
</Workflow>
