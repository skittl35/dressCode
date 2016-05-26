<cfinvoke component="dressFunctions" method="getFrontPageDresses" returnvariable="dressQuery" />

<cfoutput query="dressQuery">
	<tr>
		<td>#dress_id#</td>
		<td>#dressName#</td>
		<td>#dressType#</td>
	</tr>
</cfoutput>