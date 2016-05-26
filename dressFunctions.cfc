<cfcomponent displayname="dressFunctions" hint="Functions pertaining to dresses">
	
	<!--- Will return a list of dresses that are active for use on the front page --->
	<cffunction name="getFrontPageDresses" access="public" output="false" returntype="query">
		<cfset var q_getFrontPageDresses = "">
		<cfquery name="q_getFrontPageDresses" datasource="#application.dsn#">
			select 	a.dress_id, 
					a.dressName,
					b.dressType
			from tbl_dress a
				inner join tlkp_dressType b
				on b.dressType_id = a.dressType_id
			where a.active_flag = 1
		</cfquery>

		<cfreturn q_getFrontPageDresses>
	</cffunction>

	<!--- Will return a list of the most popular dresses in each category for use on the front page --->
	<cffunction name="getFrontPagePopularDresses" access="public" output="false" returntype="query">
		<cfset var q_getFrontPagePopularDresses = "">
		<cfquery name="q_getFrontPagePopularDresses" datasource="#application.dsn#">
			select	max(a.popularityIndex) as popularityIndex
					a.dress_id,
					a.dressName,
					b.dressType
			from tbl_dress a
				inner join tlkp_dressType b
				on b.dress_id = a.dress_id
			where a.active_flag = 1
			group by b.dressType <!--- May need other columns here? --->
		</cfquery>
	</cffunction>

	<!--- Will update tbl_dress to increment either numLikes or numDislikes (would be in an API) --->
	<cffunction name="addLikeOrDislike" access="public" output="false">
		<!--- In this case we'll say if a dress was liked, the value passed will be 1, otherwise 0 --->
		<cfargument name="wasLiked" required="true" type="any">

		<cfset var q_addLikeOrDislike = "">
		<cfset var likeIncrement = 0>
		<cfset var dislikeIncrement = 0>

		<cfif wasLiked EQ 1>
			<cfset likeIncrement += 1>
		<cfelse>
			<cfset dislikeIncrement += 1>
		</cfif>

		<cfquery name="q_addLikeOrDislike" datasource="#application.dsn#">
			update tbl_dress
				set numLikes = (select numLikes from tbl_dress where dress_id = <cfqueryparam value="#dress_id#" cfsqltype="cf_sql_integer">)+likeIncrement,
					numDisliked = (select numDislikes from tbl_dress where dress_id = <cfqueryparam value="#dress_id#" cfsqltype="cf_sql_integer">)+dislikeIncrement
			where dress_id = <cfqueryparam value="#dress_id#" cfsqltype="cf_sql_integer">
		</cfquery>
	</cffunction>
</cfcomponent>