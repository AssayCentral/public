<?xml version="1.0" encoding="UTF-8"?>
<Workflow>
    <Meta>
        <Description>Creation for: influenza/B</Description>
    </Meta>
    <Nodes>
        <Node id="1" name="ReadSource1" op="com.mmi.work.op.io.ReadDataSheet">
            <Parameters>
                <Parameter name="filename">../chembl23/InfluenzaBvirus-InfluenzaBvirus-O-F-CHEMBL613129-Functional-K.ds</Parameter>
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
        <Node id="4" name="Consolidate" op="com.mmi.assaycentral.build.op.ConsolidateAssayProvenance">
            <Parameters>
                <Parameter name="keepColumns">
                    <s>_original_src</s>
                    <s>_original_row</s>
                    <s>_priority</s>
                </Parameter>
                <Parameter name="title">Influenza B</Parameter>
                <Parameter name="description">Influenza B virus</Parameter>
                <Parameter name="headerTargetName">Influenza B virus</Parameter>
                <Parameter name="headerTargetURI">https://www.ebi.ac.uk/chembl/target/inspect/CHEMBL613129</Parameter>
                <Parameter name="headerOrganismName">Influenza B virus</Parameter>
                <Parameter name="headerOrganismURI">https://www.uniprot.org/taxonomy/11520</Parameter>
                <Parameter name="headerTargetTypeName">Virus</Parameter>
                <Parameter name="headerAssayTypeName">Functional</Parameter>
            </Parameters>
            <Input id="3" port="1"/>
            <Outputs count="1"/>
        </Node>
        <Node id="5" name="HeavyHash" op="com.mmi.work.op.calc.MoleculeProperties">
            <Parameters>
                <Parameter name="heavyHash">HeavyHash</Parameter>
            </Parameters>
            <Input id="4" port="1"/>
            <Outputs count="1"/>
        </Node>
        <Node id="6" name="SortHash" op="com.mmi.work.op.blk.Sort">
            <Parameters>
                <Parameter name="columns">
                    <s>HeavyHash</s>
                </Parameter>
            </Parameters>
            <Input id="5" port="1"/>
            <Outputs count="1"/>
        </Node>
        <Node id="7" name="Assimilate" op="com.mmi.assaycentral.build.op.AssimilateActivities">
            <Parameters>
                <Parameter name="hashBlock">HeavyHash</Parameter>
            </Parameters>
            <Input id="6" port="1"/>
            <Outputs count="2"/>
        </Node>
        <Node id="8" name="SourceFilenamesBadmerge" op="com.mmi.work.op.fmt.MapValues">
            <Parameters>
                <Parameter name="from">_original_src</Parameter>
                <Parameter name="to">SourceFile</Parameter>
                <Parameter name="type">string</Parameter>
                <Parameter name="keys">
                    <s>1</s>
                </Parameter>
                <Parameter name="values">
                    <s>../chembl23/InfluenzaBvirus-InfluenzaBvirus-O-F-CHEMBL613129-Functional-K.ds</s>
                </Parameter>
            </Parameters>
            <Input id="7" port="2"/>
            <Outputs count="1"/>
        </Node>
        <Node id="9" name="WriteBadmerge" op="com.mmi.work.op.io.WriteDataSheet">
            <Parameters>
                <Parameter name="filename">badmerge.ds</Parameter>
                <Parameter name="autoDelete">true</Parameter>
            </Parameters>
            <Input id="8" port="1"/>
            <Outputs count="0"/>
        </Node>
        <Node id="10" name="MultiplexOutput" op="com.mmi.work.op.blk.Multiplex">
            <Input id="7" port="1"/>
            <Outputs count="4"/>
        </Node>
        <Node id="11" name="WriteOutput" op="com.mmi.work.op.io.WriteDataSheet">
            <Parameters>
                <Parameter name="filename">assay.ds</Parameter>
                <Parameter name="autoDelete">false</Parameter>
            </Parameters>
            <Input id="10" port="1"/>
            <Outputs count="0"/>
        </Node>
        <Node id="12" name="CalculateThreshold" op="com.mmi.work.op.model.EstimateThreshold">
            <Input id="10" port="2"/>
            <Outputs count="0"/>
        </Node>
        <Node id="13" name="BuildModel" op="com.mmi.work.op.model.BuildBayesian">
            <Parameters>
                <Parameter name="molecule">Molecule</Parameter>
                <Parameter name="response">Value</Parameter>
                <Parameter name="fingerprint">ECFP6</Parameter>
                <Parameter name="folding">0</Parameter>
                <Parameter name="validation">five-fold</Parameter>
                <Parameter name="noteTitle">Influenza B</Parameter>
                <Parameter name="noteOrigin">Assay Central</Parameter>
                <Parameter name="noteField">influenza/B</Parameter>
                <Parameter name="noteComments"/>
                <Parameter name="thresholdValue" nodeID="12" resultName="threshold"/>
                <Parameter name="thresholdRelation">&gt;</Parameter>
            </Parameters>
            <Input id="10" port="3"/>
            <Outputs count="0"/>
        </Node>
        <Node id="14" name="SaveModel" op="com.mmi.work.op.model.SaveBayesian">
            <Parameters>
                <Parameter name="filename">assay.bayesian</Parameter>
                <Parameter name="model" nodeID="13" resultName="model"/>
            </Parameters>
            <Outputs count="0"/>
        </Node>
        <Node id="15" name="DiscardRows" op="com.mmi.work.op.io.Sink">
            <Input id="10" port="4"/>
            <Outputs count="1"/>
        </Node>
        <Node id="16" name="WriteSummary" op="com.mmi.assaycentral.build.op.CaptureBrochureSummary">
            <Parameters>
                <Parameter name="filename">summary.json</Parameter>
                <Parameter name="model" nodeID="13" resultName="model"/>
                <Parameter name="directory">influenza/B</Parameter>
                <Parameter name="dataFN">assay.ds</Parameter>
                <Parameter name="modelFN">assay.bayesian</Parameter>
                <Parameter name="tags">
                    <s>Influenza</s>
                </Parameter>
                <Parameter name="responseType">target</Parameter>
            </Parameters>
            <Input id="15" port="1"/>
            <Outputs count="0"/>
        </Node>
    </Nodes>
</Workflow>
