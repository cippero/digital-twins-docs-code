-------------- Used in reference-query-clause-from.md
-- <FromDigitalTwinsSyntax>
--SELECT ...
FROM DIGITALTWINS
-- </FromDigitalTwinsSyntax>

-- <FromDigitalTwinsNamedSyntax>
--SELECT ...
FROM DIGITALTWINS <collection-name>
-- </FromDigitalTwinsNamedSyntax>

-- <FromDigitalTwinsExample>
SELECT *
FROM DIGITALTWINS
-- </FromDigitalTwinsExample>

-- <FromDigitalTwinsNamedExample>
SELECT *
FROM DIGITALTWINS T
-- </FromDigitalTwinsNamedExample>

-- <FromRelationshipsSyntax>
--SELECT ...
FROM RELATIONSHIPS
-- </FromRelationshipsSyntax>

-- <FromRelationshipsNamedSyntax>
--SELECT ...
FROM RELATIONSHIPS <collection-name>
-- </FromRelationshipsNamedSyntax>

-- <FromRelationshipsExample>
SELECT *
FROM RELATIONSHIPS
-- </FromRelationshipsExample>

-- <FromRelationshipsFilteredExample>
SELECT *
FROM RELATIONSHIPS
WHERE $sourceId IN  ['A', 'B', 'C', 'D']
-- </FromRelationshipsFilteredExample>

-- <FromNegativeExample>
SELECT * 
FROM (SELECT * FROM DIGITALTWINS T WHERE ...)
-- </FromNegativeExample>

-------------- Used in reference-query-clause-join.md
-- <JoinSyntax>
--SELECT ...
FROM DIGITALTWINS <twin-collection-name>
JOIN <target-twin-collection-name> RELATED <twin-collection-name>.<relationship-name> <OPTIONAL: relationship-collection-name>
WHERE <twin-collection-name-OR-target-twin-collection-name>.$dtId = '<twin-id>'
-- </JoinSyntax>

-- <JoinExample>
SELECT T, CT
FROM DIGITALTWINS T
JOIN CT RELATED T.contains
WHERE T.$dtId = 'ABC'
-- </JoinExample>

-- <MultiJoinSyntax>
--SELECT ...
FROM DIGITALTWINS <twin-collection-name>
JOIN <relationship-collection-name-1> RELATED <twin-collection-name>.<relationship-type-1>
JOIN <relationship-collection-name-2> RELATED <twin-or-relationship-collection-name>.<relationship-type-2>
-- </MultiJoinSyntax>

-- <MultiJoinExample>
SELECT LightBulb
FROM DIGITALTWINS Room
JOIN LightPanel RELATED Room.contains
JOIN LightBulb RELATED LightPanel.contains
WHERE Room.$dtId IN ['room1', 'room2']
-- </MultiJoinExample>

-- <MaxJoinExample>
SELECT LightBulb
FROM DIGITALTWINS Building
JOIN Floor RELATED Building.contains
JOIN Room RELATED Floor.contains
JOIN LightPanel RELATED Room.contains
JOIN LightBulbRow RELATED LightPanel.contains
JOIN LightBulb RELATED LightBulbRow.contains
WHERE Building.$dtId = 'Building1'
-- </MaxJoinExample>

-- <NoOuterJoinExample>
SELECT Building, Floor
FROM DIGITALTWINS Building
JOIN Floor RELATED Building.contains
WHERE Building.$dtId = 'Building1'
-- </NoOuterJoinExample>

-------------- Used in reference-query-clause-match.md
-- <MatchSyntax>
--SELECT ... FROM ...  
MATCH (twin_1)-[relationship_condition]-(twin_2)
WHERE twin_or_twin_collection.$dtId = 'twin_ID' 
-- AND ... 
-- </MatchSyntax>

-- <MatchChainSyntax>
--Chained relationship conditions
-- SELECT ... FROM ... 
MATCH (twin_1)-[relationship_condition]-(twin_2)-[relationship_condition]-(twin_3)...
WHERE twin_or_twin_collection.$dtId = 'twin_ID'
-- </MatchChainSyntax>

-- <MatchNodeSyntax>
-- No relationship condition
-- SELECT ... FROM ... 
MATCH (twin_1)
WHERE twin_or_twin_collection.$dtId = 'twin_ID' 
-- </MatchNodeSyntax>

-- <MatchExample>
SELECT Building, Sensor FROM DIGITALTWINS 
MATCH (Building)-[]->(Sensor) 
WHERE Building.$dtId = 'Building21' AND Sensor.temperature > 50   
-- </MatchExample>

-- <MatchDirectionLRSyntax>
-- SELECT ... FROM ...
MATCH (source_twin)-[]->(target_twin)
-- WHERE ...
-- </MatchDirectionLRSyntax>

-- <MatchDirectionRLSyntax>
-- SELECT ... FROM ...
MATCH (target_twin)<-[]-(source_twin)
-- WHERE ...
-- </MatchDirectionRLSyntax>

-- <MatchDirectionNDSyntax>
-- SELECT ... FROM ...
MATCH (source_twin)-[]-(target_twin)
-- WHERE ...
-- </MatchDirectionNDSyntax>

-- <MatchDirectionLRExample>
SELECT Room, Factory FROM DIGITALTWINS MATCH (Room)-[]->(Factory) 
WHERE Room.temperature > 50 AND Factory.$dtId = 'ABC'  
-- </MatchDirectionLRExample>

-- <MatchDirectionRLExample>
SELECT Room, Factory FROM DIGITALTWINS MATCH (Room)<-[]-(Factory) 
WHERE Factory.$dtId = 'ABC' AND Room.temperature > 50 
-- </MatchDirectionRLExample>

-- <MatchDirectionNDExample>
SELECT Factory, Room FROM DIGITALTWINS MATCH (Factory)-[]-(Room) 
WHERE Factory.$dtId ='ABC'  AND Room.humidity > 70 
-- </MatchDirectionNDExample>

-- <MatchNameSingleSyntax>
-- SELECT ... FROM ...
MATCH (twin_1)-[:relationship_name]-(twin_2)
-- WHERE ...
-- </MatchNameSingleSyntax>

-- <MatchNameMultiSyntax>
-- SELECT ... FROM ...
MATCH (twin_1)-[:relationship_name_option_1|relationship_name_option_2|continue pattern as needed...]-(twin_2)
-- WHERE ...
-- </MatchNameMultiSyntax>

-- <MatchNameAllSyntax>
-- SELECT ... FROM ...
MATCH (twin_1)-[]-(twin_2)
-- WHERE ...
-- </MatchNameAllSyntax>

-- <MatchNameSingleExample>
SELECT Building, Sensor FROM DIGITALTWINS   
MATCH (Building)-[:contains]-(Sensor)  
WHERE Building.$dtId = 'Seattle21'
-- </MatchNameSingleExample>

-- <MatchNameMultiExample>
SELECT Building, Sensor FROM DIGITALTWINS   
MATCH (Building)-[:contains|isAssociatedWith]-(Sensor)  
WHERE building.$dtId = 'Seattle21'
-- </MatchNameMultiExample>

-- <MatchNameAllExample>
SELECT Building, Sensor FROM DIGITALTWINS   
MATCH (Building-[]-(Sensor)  
WHERE Building.$dtId = 'Seattle21'
-- </MatchNameAllExample>

-- <MatchHopsExactSyntax>
-- SELECT ... FROM ... 
MATCH (twin_1)-[*number_of_hops]-(twin_2)
-- WHERE ...
-- </MatchHopsExactSyntax>

-- <MatchHopsRangeSyntax>
-- SELECT ... FROM ...
MATCH (twin_1)-[*starting_limit..ending_limit]-(twin_2)
-- WHERE ...
-- </MatchHopsRangeSyntax>

-- <MatchHopsRangeEndingSyntax>
-- SELECT ... FROM ...
MATCH (twin_1)-[*..ending_limit]-(twin_2)
-- WHERE ...
-- </MatchHopsRangeEndingSyntax>

-- <MatchHopsOneSyntax>
-- SELECT ... FROM ... 
MATCH (twin_1)-[]-(twin_2)
-- WHERE ...
-- </MatchHopsOneSyntax>

-- <MatchHopsExactExample>
SELECT * FROM DIGITALTWINS 
MATCH (Floor)-[*3]-(Room)
WHERE Floor.$dtId = 'thermostat-15'
-- </MatchHopsExactExample>

-- <MatchHopsRangeExample1>
SELECT * FROM DIGITALTWINS 
MATCH (Floor)-[*1..3]-(Room)
WHERE Floor.$dtId = 'thermostat-15'
-- </MatchHopsRangeExample1>

-- <MatchHopsRangeEndingExample>
SELECT * FROM DIGITALTWINS 
MATCH (Floor)-[*..2]-(Room)
WHERE Floor.$dtId = 'thermostat-15'
-- </MatchHopsRangeEndingExample>

-- <MatchHopsOneExample>
SELECT * FROM DIGITALTWINS  
MATCH (Floor)-[]-(Room)
WHERE Floor.$dtId = 'thermostat-15'
-- </MatchHopsOneExample>

-- <MatchVariableSyntax>
-- SELECT ... FROM ...   
MATCH (twin_1)-[relationship_variable]-(twin_2>) 
-- WHERE ... 
-- </MatchVariableSyntax>

-- <MatchVariableExample>
SELECT Floor,Cafe, Rel DIGITALTWINS   
MATCH (Floor)-[Rel]-(Cafe)  
WHERE Floor.$dtId = 'thermostat-15' AND Rel.name = 'child'
-- </MatchVariableExample>

-- <MatchCombinedHopsSyntax>
-- SELECT ... FROM ...
MATCH (twin_1)optional_left_angle_bracket-[:relationship_name(s)*number_of_hops]-optional_right_angle_bracket(twin_2)
-- WHERE
-- </MatchCombinedHopsSyntax>

-- <MatchCombinedVariableSyntax>
-- SELECT ... FROM ...
MATCH (twin_1)optional_left_angle_bracket-[relationship_variable:relationship_name(s)]-optional_right_angle_bracket(twin_2)
-- WHERE
-- </MatchCombinedVariableSyntax>

-- <MatchCombinedHopsExample>
SELECT Floor, Room FROM DIGITALTWINS    
MATCH (Floor)-[:contains|isAssociatedWith*3..5]->(Room) 
WHERE Floor.$dtId = 'thermostat-15'
-- </MatchCombinedHopsExample>

-- <MatchCombinedVariableExample>
SELECT Floor, Room FROM DIGITALTWINS    
MATCH (Floor)-[r:contains|isAssociatedWith]->(Room) 
WHERE Floor.$dtId = 'thermostat-15' AND r.length = 10
-- </MatchCombinedVariableExample>

-- <MatchCombinedChainExample>
SELECT Floor,Room, Cafe FROM DIGITALTWINS    
MATCH (Floor)-[r:contains|isAssociatedWith]->(Cafe)<-[has|includes*..3]-(Room)  
WHERE Floor.$dtId = 'thermostat-15'  AND r.length = 10 AND Cafe.temperature = 55 
-- </MatchCombinedChainExample>

-- <MatchCombinedChainBDExample>
SELECT Floor, Room, Building FROM DIGITALTWINS    
MATCH (Building)-[r1:isAssociatedWith]->(Floor)<-[r2:isAssociatedWith]-(Room)
WHERE Building.$dtId = 'building-3'  AND Room.temperature > 50
-- </MatchCombinedChainBDExample>

-------------- Used in reference-query-clause-select.md
-- <SelectSyntax>
SELECT *
--FROM ...
-- </SelectSyntax>

-- <SelectExample>
SELECT *
FROM DIGITALTWINS
-- </SelectExample>

-- <SelectProjectCollectionSyntax>
SELECT <twin-or-relationship-collection>
-- </SelectProjectCollectionSyntax>

-- <SelectProjectPropertySyntax>
SELECT <twin-or-relationship-collection>.<property-name>
-- </SelectProjectPropertySyntax>

-- <SelectProjectCollectionExample>
SELECT T
FROM DIGITALTWINS T
-- </SelectProjectCollectionExample>

-- <SelectProjectJoinExample>
SELECT Consumer, Factory, Relationship
FROM DIGITALTWINS Factory
JOIN Consumer RELATED Factory.consumerRelationship Relationship
WHERE Factory.$dtId = 'FactoryA'
-- </SelectProjectJoinExample>

-- <SelectProjectPropertyExample>
SELECT Consumer.name, Relationship.managedBy
FROM DIGITALTWINS Factory
JOIN Consumer RELATED Factory.consumerRelationship Relationship
WHERE Factory.$dtId = 'FactoryA'
-- </SelectProjectPropertyExample>

-- <SelectProjectPropertyNotPresentExample>
SELECT name, age 
FROM DIGITALTWINS
-- </SelectProjectPropertyNotPresentExample>

-- <SelectCountSyntax>
SELECT COUNT()
-- </SelectCountSyntax>

-- <SelectCountExample>
SELECT COUNT()
FROM DIGITALTWINS
-- </SelectCountExample>

-- <SelectCountRelationshipsExample>
SELECT COUNT()
FROM RELATIONSHIPS
-- </SelectCountRelationshipsExample>

-- <SelectTopSyntax>
SELECT TOP(<number-of-return-items>)
-- </SelectTopSyntax>

-- <SelectTopExample>
SELECT TOP(5)
FROM DIGITALTWINS
-- </SelectTopExample>

-------------- Used in reference-query-clause-where.md
-- <WhereSyntax>
--SELECT ...
--FROM ...
WHERE <twin-or-relationship-collection>.<property> <operator> <value-to-compare>
-- </WhereSyntax>

-- <WhereFunctionSyntax>
--SELECT ...
--FROM ...
WHERE <function-with-Boolean-result>
-- </WhereFunctionSyntax>

-- <WhereExample>
SELECT *
FROM DIGITALTWINS T
WHERE T.$dtId = 'Room1'
-- </WhereExample>

-- <WhereFunctionExample>
SELECT *
FROM DIGITALTWINS
WHERE IS_OF_MODEL('dtmi:sample:Room;1')
-- </WhereFunctionExample>

-------------- Used in reference-query-functions.md
-- <EndsWithSyntax>
ENDSWITH(<string-to-check>,<ending-string>)
-- </EndsWithSyntax>

-- <EndsWithExample>
SELECT *
FROM DIGITALTWINS T
WHERE ENDSWITH(T.$dtId, '-small')
-- </EndsWithExample>

-- <IsDefinedSyntax>
IS_DEFINED(<property>)
-- </IsDefinedSyntax>

-- <IsDefinedExample>
SELECT *
FROM DIGITALTWINS
WHERE IS_DEFINED(Location)
-- </IsDefinedExample>

-- <IsOfModelSyntax>
IS_OF_MODEL(<twin-collection>,'<model-ID>', exact)
-- </IsOfModelSyntax>

-- <IsOfModelExample>
SELECT ROOM FROM DIGITALTWINS DT WHERE IS_OF_MODEL(DT, 'dtmi:example:room;1', exact)
-- </IsOfModelExample>

-- <IsBoolSyntax>
IS_BOOL(<expression>)
-- </IsBoolSyntax>

-- <IsBoolExample>
SELECT *
FROM DIGITALTWINS T
WHERE IS_BOOL( HasTemperature )
-- </IsBoolExample>

-- <IsBoolNotFalseExample>
SELECT *
FROM DIGITALTWINS T
WHERE IS_BOOL( HasTemperature ) AND HasTemperature != false
-- </IsBoolNotFalseExample>

-- <IsNumberSyntax>
IS_NUMBER(<expression>)
-- </IsNumberSyntax>

-- <IsNumberExample>
SELECT * 
FROM DIGITALTWINS 
WHERE IS_NUMBER( Capacity ) AND Capacity != 0
-- </IsNumberExample>

-- <IsStringSyntax>
IS_STRING(<expression>)
-- </IsStringSyntax>

-- <IsStringExample>
SELECT * 
FROM DIGITIALTWINS 
WHERE IS_STRING( Status ) AND Status != 'Completed'
-- </IsStringExample>

-- <IsNullSyntax>
IS_NULL(<expression>)
-- </IsNullSyntax>

-- <IsNullExample>
SELECT *
FROM DIGITALTWINS T
WHERE NOT IS_NULL(T.Temperature)
-- </IsNullExample>

-- <IsPrimitiveSyntax>
IS_PRIMITIVE(<expression>)
-- </IsPrimitiveSyntax>

-- <IsPrimitiveExample>
SELECT Factory.area
FROM DIGITALTWINS Factory
WHERE Factory.$dtId = 'ABC'
AND IS_PRIMITIVE(Factory.area)
-- </IsPrimitiveExample>

-- <IsObjectSyntax>
IS_OBJECT<expression>)
-- </IsObjectSyntax>

-- <IsObjectExample>
SELECT * 
FROM DIGITALTWINS 
WHERE IS_OBJECT( MapObject ) AND NOT IS_DEFINED ( MapObject.TemperatureReading )
-- </IsObjectExample>

-- <StartsWithSyntax>
STARTSWITH(<string-to-check>,<beginning-string>)
-- </StartsWithSyntax>

-- <StartsWithExample>
SELECT *
FROM DIGITALTWINS T
WHERE STARTSWITH(T.$dtId, 'area1-')
-- </StartsWithExample>

-- <ContainsSyntax>
CONTAINS(<string-to-check>,<contained-string>)
-- </ContainsSyntax>

-- <ContainsExample>
SELECT *
FROM DIGITALTWINS T
WHERE CONTAINS(T.$dtId, '-route')
-- </ContainsExample>

-------------- Used in reference-query-operators.md
-- <EqualityExample>
SELECT * 
FROM DIGITALTWINS DT
WHERE DT.Temperature = 80
-- </EqualityExample>

-- <ComparisonExample>
SELECT * 
FROM DIGITALTWINS DT
WHERE DT.Temperature < 80
-- </ComparisonExample>

-- <OrderedComparisonExample>
SELECT * 
FROM DIGITALTWINS DT
WHERE NOT DT.Temperature <= 80
-- </OrderedComparisonExample>

-- <InExample>
SELECT * 
FROM DIGITALTWINS DT
WHERE DT.owner IN ['John', 'Anil', 'Bailey', 'Alex']
-- </InExample>

-- <AndExample>
SELECT * 
FROM DIGITALTWINS DT
WHERE DT.Temperature < 80 AND DT.Humidity < 50
-- </AndExample>

-- <OrExample>
SELECT * 
FROM DIGITALTWINS DT
WHERE DT.Temperature < 80 OR DT.Humidity < 50
-- </OrExample>

-- <NotExample>
SELECT * 
FROM DIGITALTWINS DT
WHERE NOT DT.Temperature < 80
-- </NotExample>

-------------- Used in reference-query-reserved.md
-- <ReservedKeywordExample>
SELECT * FROM DIGITALTWINS WHERE [[Group]] = 'BravoTeam'
-- </ReservedKeywordExample>
