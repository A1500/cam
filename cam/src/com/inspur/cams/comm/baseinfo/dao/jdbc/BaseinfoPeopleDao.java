package com.inspur.cams.comm.baseinfo.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.comm.baseinfo.dao.IBaseinfoPeopleDao;
import com.inspur.cams.comm.baseinfo.data.BaseinfoPeople;
import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.ExportExcelPageUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.comm.util.RecordToBeanUtil;
import com.inspur.cams.comm.util.StrUtil;



/**
 * @title:BaseinfoPeopleDao
 * @description:
 * @author:
 * @since:2011-05-12
 * @version:1.0
*/
 public class BaseinfoPeopleDao extends EntityDao<BaseinfoPeople> implements IBaseinfoPeopleDao{
 
 	public BaseinfoPeopleDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}
		 
	@SuppressWarnings("unchecked")
	public Class getEntityClass() {
		return BaseinfoPeople.class;
	}
	
	public void deleteByBaseinfoFamily(String fkId) {
		executeUpdate("delete from  BASEINFO_PEOPLE where FAMILY_ID='" + fkId + "'");
	}

	public void batchDeleteByBaseinfoFamily(String[] fkId) {
		String[] sql = new String[fkId.length];
		for (int i = 0; i < fkId.length; i++) {
			sql[i] = "delete from BASEINFO_PEOPLE where FAMILY_ID='" + fkId[i] + "'";
		}
		batchUpdate(sql);
	}

	public DataSet queryForMBalance(ParameterSet paramSet){
		List<Integer> typeList = new ArrayList<Integer>();
		List<String> objsList = new ArrayList<String>();
		
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT b.*,f.domicile_code,f.assistance_type,f.family_id, f.card_no, (select address from baseinfo_family_archive t where b.family_archive_id = t.family_archive_id) address  \n ");
		sql.append(" FROM BASEINFO_PEOPLE_ARCHIVE   b, \n ");
		sql.append("        SAM_PEOPLE_EXTEND_ARCHIVE X, \n ");
		sql.append("       SAM_FAMILY_TREATMENT      F \n ");
		sql.append("  WHERE b.PEOPLE_ARCHIVE_ID = X.PEOPLE_ARCHIVE_ID(+) \n ");
		sql.append("   AND F.APPLY_ID = b.APPLY_ID \n ");
		sql.append("   AND F.BEGIN_DATE <= to_char(sysdate, 'yyyy-mm') \n ");
		sql.append("   AND F.END_DATE >= to_char(sysdate, 'yyyy-mm') \n ");
		sql.append("   AND b.PERSONAL_STATS_TAG = '01'  \n ");
		sql.append("    AND X.IS_ASSISTANCE = '1'  \n ");		
		
        //医院只能对其所负责属地的人员进行备案
		String hospitalId=(String)paramSet.getParameter("hospitalId");
		if(StringUtils.isNotEmpty(hospitalId)){
			sql.append(" and  substr(f.DOMICILE_CODE,0,6) in (select substr(AREA_CODE,0,6) from SAM_MEDICAL_SERVICE_AREA where organ_Id= '"+hospitalId+"'  ) \n");
		}
		//救助类型
		String assistanceType =(String) paramSet.getParameter("assistanceType");
		String cardNo =(String) paramSet.getParameter("cardNo");
		if((StringUtils.isNotEmpty(assistanceType)&&!"4".equals(assistanceType))||StringUtils.isNotEmpty(cardNo)){
				
			if(StringUtils.isNotEmpty(assistanceType)){
				sql.append("         and f.assistance_type = '0" + assistanceType + "'      \n");
			}
			if(StringUtils.isNotEmpty(cardNo)){
				sql.append("           and f.card_no = '"+cardNo+"'   \n");
			}
		}
		if("4".equals(assistanceType)){
			sql.append(" and (case when b.disability_flag = '1' \n");
			sql.append("     or b.war_flag = '1'   \n");
			sql.append("    or b.reda_flag = '1' \n");
			sql.append("     or b.dependant_flag = '1' or b.demobilized_flag = '1' then '1' else '0' end)= '1' \n");
		}	
		
		String name = (String) paramSet.getParameter("name");
		if(StringUtils.isNotEmpty(name)){
			sql.append("  and b.name= ?    ");
			objsList.add(name);
			typeList.add(Types.VARCHAR);	
		}
		String idCard = (String) paramSet.getParameter("idCard");
		if(StringUtils.isNotEmpty(idCard)){
			sql.append("   and b.id_card= ?      ");
			
			objsList.add(idCard);
			typeList.add(Types.VARCHAR);		
		}
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = typeList.get(i);
		}

		Object[] args = objsList.toArray(new Object[objsList.size()]);
		
		
		return executeDataset(sql.toString(),  types, args, true);
		
	}
	/**
	 * 低保救助人员信息查询
	 * @param paramSet
	 * @return
	 */
	public DataSet queryForSam(ParameterSet paramSet){
		String familyId=(String)paramSet.getParameter("FAMILY_ID");
		String peopleId=(String)paramSet.getParameter("PEOPLE_ID");
		StringBuffer sql=new StringBuffer();
		sql.append(" SELECT D.DISABILITY_TYPE,P.PEOPLE_ID,P.FAMILY_ID,P.NAME,P.ID_CARD,P.SEX,P.RELATIONSHIP_TYPE,P.HEALTH_CODE,P.EMPLOYMENT_CODE,P.EDU_CODE, ");
		sql.append("	P.INCOME_MONTH,P.INCOME_YEAR,P.PERSONAL_STATS_TAG, ");
		sql.append("	E.LABOR_CAPACITY ,E.SELF_CARE_ABILITY,E.IS_ASSISTANCE, ");
		sql.append("	PE.EDU_STATUS ");
		sql.append(" FROM SAM_PEOPLE_DISABILITY D,BASEINFO_PEOPLE P,SAM_PEOPLE_EXTEND E,SAM_PEOPLE_EDU PE ");
		sql.append(" WHERE D.PEOPLE_ID(+)=P.PEOPLE_ID AND P.PEOPLE_ID=E.PEOPLE_ID(+) AND P.PEOPLE_ID=PE.PEOPLE_ID(+) ");
		if(familyId!=null){
			sql.append(" AND P.FAMILY_ID=? ");	
			sql.append(" ORDER BY P.RELATIONSHIP_TYPE ");		
			return executeDataset(sql.toString(),new int[]{Types.VARCHAR},new Object[]{familyId},true);
		}else{
			sql.append(" AND P.PEOPLE_ID=?");			
			return executeDataset(sql.toString(),new int[]{Types.VARCHAR},new Object[]{peopleId},true);				
		}
	}
	public DataSet queryForInterface(String idCard) {
		List<Integer> typeList = new ArrayList<Integer>();
		List<String> objsList = new ArrayList<String>();
		
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT a.name,a.sex,a.birthday,a.id_card,f.family_id,f.domicile_code,f.assistance_type, f.card_no \n ");
		sql.append(" FROM BASEINFO_PEOPLE_ARCHIVE   a, \n ");
		sql.append("        SAM_PEOPLE_EXTEND_ARCHIVE X, \n ");
		sql.append("       SAM_FAMILY_TREATMENT      f \n ");
		sql.append("  WHERE a.PEOPLE_ARCHIVE_ID = X.PEOPLE_ARCHIVE_ID(+) \n ");
		sql.append("   AND F.APPLY_ID = a.APPLY_ID \n ");
		sql.append("   AND F.DOMICILE_CODE LIKE ? \n ");
		sql.append("   AND F.BEGIN_DATE <= to_char(sysdate, 'yyyy-mm') \n ");
		sql.append("   AND F.END_DATE >= to_char(sysdate, 'yyyy-mm') \n ");
		sql.append("   AND a.PERSONAL_STATS_TAG = '01'  \n ");
		sql.append("    AND X.IS_ASSISTANCE = '1'  \n ");
		sql.append("    and a.id_card= ? \n ");
		String organCode =BspUtil.getOrganCode();
		if (organCode.indexOf("000") != -1) {
			objsList.add(getAreaCodeLikePrefix(organCode) + "%");
		} else {
			objsList.add(organCode + "%");
		}
		objsList.add(idCard);
		typeList.add(Types.VARCHAR);
		typeList.add(Types.VARCHAR);
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = typeList.get(i);
		}

		Object[] args = objsList.toArray(new Object[objsList.size()]);
		DataSet ds = executeDataset(sql.toString(), types, args, true);
		return ds;
	}
	/**
	 * 批量删除家庭成员信息
	 * @param peopleId
	 */
	public void batchDeleteByBaseinfoPeople(String[] peopleId) {
		String[] sql = new String[peopleId.length];
		for (int i = 0; i < peopleId.length; i++) {
			sql[i] = "delete from BASEINFO_PEOPLE where PEOPLE_ID='" + peopleId[i] + "'";
		}
		batchUpdate(sql);
	}
	
	/**
	 * 根据FAMILY_ID查询PEOPLE_ID
	 * @param familyIds
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public String[] getPeopleIdsByFamilyIds(String[] familyIds) {
		List<Map> peopleIdList = new ArrayList<Map>();
		String[] sql = new String[familyIds.length];
		for(int i=0; i<familyIds.length; i++) {
			sql[i] = "SELECT PEOPLE_ID FROM BASEINFO_PEOPLE WHERE FAMILY_ID='"+familyIds[i]+"'";
			List<Map> ls = executeQuery(sql[i]);
			peopleIdList.addAll(ls);
		}
		List<String> ls = buildPeopleIds(peopleIdList);
		String[] peopleIds = new String[ls.size()];
		return ls.toArray(peopleIds);
	}
	
	@SuppressWarnings({ "unchecked", "unused" })
	private List<String> buildPeopleIds(List<Map> list) {
		List<String> ls = new ArrayList<String>();
		for(int i=0; i<list.size(); i++) {
			String peopleId = (String)((Map)list.get(i)).get("PEOPLE_ID");
			ls.add(peopleId);
		}
		return ls;
	}
//----------------------------------------------------------------------------------------------------------------------------------
	public void deleteByYgjzJtxx(String fkId) {
		executeUpdate("delete from  BASEINFO_PEOPLE where PEOPLE_ID='" + fkId + "'");
	}

	public void bathchDeleteByFamilyId(String[] fkId) {
		String[] sql = new String[fkId.length];
		for (int i = 0; i < fkId.length; i++) {
			sql[i] = "delete from BASEINFO_PEOPLE where FAMILY_ID='" + fkId[i] + "'";
		}
		batchUpdate(sql);
	}
	 public DataSet itemQuery(ParameterSet pset) {
		    String hzxm=(String)pset.getParameter("HZXM");//户主姓名
		    String  organCode=BspUtil.getCorpOrgan().getOrganCode();
			StringBuffer sql = new StringBuffer();
			sql.append("   select t.name as name ,t.peopleId as peopleId,t.idCard as idCard from BASEINFO_FAMILY s,BASEINFO_PEOPLE t");
			//修改说明，初期数据都未审核无法救助，特去除审核过滤条件，以后在设置。20110616  licb
			//sql.append("   where s.peopleId=t.peopleId and s.shbz='3'");

			 sql.append("   where s.peopleId=t.peopleId  ");
			String createOrgan="";
			 if(organCode.substring(2,12).equals("0000000000")){
					createOrgan=organCode.substring(0,2);
				}else if(organCode.substring(4,12).equals("00000000")){
					createOrgan=organCode.substring(0,4);
				}else if(organCode.substring(6,12).equals("000000")||organCode.substring(6,12)=="000000"){
					createOrgan=organCode.substring(0,6);
				}else if(organCode.substring(9,12).equals("000")){
					createOrgan=organCode.substring(0,9);
				}else  {
					createOrgan=organCode;
				}
			 sql.append("   and t.regOrgName LIKE '").append(createOrgan).append("%'");

			 if(hzxm!=null && !"".equals(hzxm)) {
			   sql.append("   and t.name ='").append(hzxm).append("'");
			 }
			 return this.executeDataset(sql.toString(), pset.getPageStart(), pset.getPageLimit(), true);
		}

	//根据peopleID获得人员
		public DataSet queryDemobilizedFlowHeader(String peopleId) {

			return null;
		}

	/**
	 * @Title: querySamPeopleList 
	 * @Description: TODO(低保对象查询列表) 
	 * @author wangziming
	 */
	public DataSet querySamPeopleList(ParameterSet pset) {
		List<Integer> typeList=new ArrayList<Integer>();
		List<String> objsList=new ArrayList<String>();
		
		String domicileCode = (String) pset.getParameter("domicileCode");
		if(domicileCode.indexOf("000")!=-1){
			objsList.add(getAreaCodeLikePrefix(domicileCode)+"%");
		}else {
			objsList.add(domicileCode+"%");
		}
		objsList.add((String) pset.getParameter("queryDate"));
		objsList.add((String) pset.getParameter("queryDate"));
		
		typeList.add(Types.VARCHAR);
		typeList.add(Types.VARCHAR);
		typeList.add(Types.VARCHAR);
		
		String name = (String) pset.getParameter("name");
		String idCard = (String) pset.getParameter("idCard");
		String sex = (String) pset.getParameter("sex");
		String nation = (String) pset.getParameter("nation");
		String insuranceNumber = (String) pset.getParameter("insuranceNumber");
		String healthCode = (String) pset.getParameter("healthCode");
		String marriageCode = (String) pset.getParameter("marriageCode");
		String eduStatus = (String) pset.getParameter("eduStatus");
		String disabilityType = (String) pset.getParameter("disabilityType");
		String disabilityLevel = (String) pset.getParameter("disabilityLevel");
		String laborCapacity = (String) pset.getParameter("laborCapacity");
		String domicileType = (String) pset.getParameter("domicileType");
		String assistanceClass = (String) pset.getParameter("assistanceClass");
		String isThreeNo = (String) pset.getParameter("isThreeNo");
		String eduCode = (String) pset.getParameter("eduCode");
		String isAssistance = (String) pset.getParameter("isAssistance");
		String assistanceType = (String) pset.getParameter("assistanceType");
		String personalStatsTag = (String) pset.getParameter("personalStatsTag");//人员状态
		String qIsAssistance = (String) pset.getParameter("qIsAssistance");
		String qRelationshipType = (String) pset.getParameter("qRelationshipType");
		String belonging = (String) pset.getParameter("belonging");
		String sAge = (String) pset.getParameter("sAge");
		String eAge = (String) pset.getParameter("eAge");
		String qPoliticalCode = (String) pset.getParameter("qPoliticalCode");
		String qDisabilityLevel = (String) pset.getParameter("qDisabilityLevel");
		String qEduStatus = (String) pset.getParameter("qEduStatus");
		String supportWay=(String) pset.getParameter("supportWay");
		String peopleTypeQuery = (String) pset.getParameter("peopleTypeQuery");
		String inHospital=(String)pset.getParameter("inHospital");
		
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT P.PEOPLE_ID,");
		sql.append("       P.APPLY_ID,");
		sql.append("       X.EXTNED_ID,");
		sql.append("       P.NAME,");
		sql.append("       P.SEX,");
		sql.append("	   GETAGE_CARD_NO(P.ID_CARD) AS AGE,");
		sql.append("       N.NAME NATION, ");
		sql.append("       P.NATION AS NATION_CODE,");
		sql.append("      P.FAMILY_ARCHIVE_ID,");
		
		sql.append("       P.ID_CARD, ");
		sql.append("       P.ADDRESS, ");
		sql.append("       P.POLITICAL_CODE, ");
		sql.append("       P.INCOME_MONTH, ");
		sql.append("       P.INCOME_YEAR, ");
		sql.append("       P.HEALTH_CODE, ");
		sql.append("       P.DOMICILE_NAME, ");
		sql.append("       P.DOMICILE_FULL_NAME, ");
		sql.append("       P.RELATIONSHIP_TYPE, ");
		sql.append("       X.BELONGING, ");
		sql.append("       E.NAME EDU_CODE,");
		sql.append("       M.NAME MARRIAGE_CODE,");
		sql.append("        Z.NAME DOMICILE_TYPE,");
		sql.append("       X.ASSISTANCE_CLASS,");
		sql.append("       F.DOMICILE_CODE,");
		sql.append("        Y.NAME DISABILITY_TYPE,");
		sql.append("         W.NAME DISABILITY_LEVEL,");
		sql.append("       X.LABOR_CAPACITY,");
		sql.append("       X.IS_THREE_NO,");
		sql.append("       F.ASSISTANCE_TYPE,");
		sql.append("       F.TREATMENT_ID,");//
		sql.append("       F.SUPPORT_WAY,");//
		sql.append("       F.SUPPORT_ORG,");//
		sql.append("       G.GEROCOMIUM_NAME,");//
		sql.append("       G.GEROCOMIUM_ID,");//
		sql.append("       F.FAMILY_ID,");//
		sql.append("       P.IN_HOSPITAL,");//是否入院（敬老院字段）
		sql.append("       X.SELF_CARE_ABILITY ");
		sql.append("  FROM BASEINFO_PEOPLE_ARCHIVE P, ");
		sql.append("  	   SAM_PEOPLE_DISABILITY_ARCHIVE D, ");
		sql.append("  	   SAM_PEOPLE_EXTEND_ARCHIVE X, ");
		sql.append("  	   SAM_FAMILY_TREATMENT F, ");
		sql.append("  	   sam_gerocomium_info G , ");//敬老院信息表
		
		sql.append("  	   dic_nation                    N,");
		sql.append("  	   dic_education                 E, ");
		sql.append("  	    dic_marriage                  M, ");
		sql.append("  	   dic_domicile_type             Z, ");
		sql.append("  	   dic_disability_type           Y, ");
		sql.append("  	    dic_disability_level          W ");
		
		sql.append(" WHERE P.PEOPLE_ARCHIVE_ID = D.PEOPLE_ARCHIVE_ID(+) ");
		sql.append("   AND P.PEOPLE_ARCHIVE_ID = X.PEOPLE_ARCHIVE_ID(+) ");
		sql.append("   AND F.APPLY_ID = P.APPLY_ID ");
		sql.append("   AND G.GEROCOMIUM_ID(+) = F.SUPPORT_ORG ");
		
		sql.append("   and P.NATION=N.CODE(+)  ");
		sql.append("   and P.EDU_CODE=E.CODE(+)  ");
		sql.append("   and P.MARRIAGE_CODE=M.CODE(+)  ");
		sql.append("   and P.DOMICILE_TYPE=z.CODE(+) ");
		sql.append("   and D.DISABILITY_TYPE=Y.CODE(+) ");
		sql.append("   and D.DISABILITY_LEVEL=W.CODE(+)  ");
		
		
		sql.append("   AND F.DOMICILE_CODE LIKE ? ");
		sql.append("   AND F.BEGIN_DATE <= ? ");
		sql.append("   AND F.END_DATE >= ? ");
		

		if(StringUtils.isNotEmpty(supportWay)){
			sql.append("    AND F.SUPPORT_WAY = ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(supportWay);
		}
		

		if(StringUtils.isNotEmpty(supportWay)){
			sql.append("    AND F.SUPPORT_WAY = ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(supportWay);
		}
		
		String gerocomiumName=StrUtil.n2b((String)pset.getParameter("gerocomiumName"));
		if(StringUtils.isNotEmpty(gerocomiumName)){
			sql.append("   AND F.SUPPORT_ORG  =?                         \n");
			typeList.add(Types.VARCHAR);
			objsList.add(gerocomiumName);
		}
		
		
		if(StringUtils.isNotEmpty(belonging)){
			sql.append("    AND X.BELONGING = ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(belonging);
		}
		if(StringUtils.isNotEmpty(qIsAssistance)){
			sql.append("    AND X.IS_ASSISTANCE = ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(qIsAssistance);
		}
		if(StringUtils.isNotEmpty(qRelationshipType)){
			sql.append("    AND P.RELATIONSHIP_TYPE = ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(qRelationshipType);
		}
		
		if(StringUtils.isNotEmpty(sAge)){
			sql.append("    AND P.BIRTHDAY <= ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(sAge);
		}
		
		if(StringUtils.isNotEmpty(eAge)){
			sql.append("    AND P.BIRTHDAY >= ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(eAge);
		}

		if(StringUtils.isNotEmpty(qPoliticalCode)){
			sql.append("    AND P.POLITICAL_CODE = ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(qPoliticalCode);
		}
		
		
		if(StringUtils.isNotEmpty(assistanceType)){
			sql.append("    AND F.ASSISTANCE_TYPE = ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(assistanceType);
		}
		if(StringUtils.isNotEmpty(personalStatsTag)){
			sql.append("    AND P.PERSONAL_STATS_TAG = ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(personalStatsTag);
		}
		if(StringUtils.isNotEmpty(name)){
			sql.append("    AND P.NAME like ? ");
			typeList.add(Types.VARCHAR);
			objsList.add("%"+name+"%");
		}
		if(StringUtils.isNotEmpty(idCard)){
			sql.append("    AND P.ID_CARD = ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(idCard);
		}
		if(StringUtils.isNotEmpty(sex)){
			sql.append("    AND P.SEX = ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(sex);
		}
		if(StringUtils.isNotEmpty(nation)){
			sql.append("    AND P.NATION = ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(nation);
		}
		if(StringUtils.isNotEmpty(insuranceNumber)){
			sql.append("    AND I.INSURANCE_NUMBER = ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(insuranceNumber);
		}
		if(StringUtils.isNotEmpty(healthCode)){
			sql.append("    AND P.HEALTH_CODE = ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(healthCode);
		}
		if(StringUtils.isNotEmpty(marriageCode)){
			sql.append("    AND P.MARRIAGE_CODE = ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(marriageCode);
		}
		if(StringUtils.isNotEmpty(eduStatus)){
			sql.append("    AND E.EDU_STATUS = ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(eduStatus);
		}
		if(StringUtils.isNotEmpty(disabilityType)){
			sql.append("    AND D.DISABILITY_TYPE = ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(disabilityType);
		}
		if(StringUtils.isNotEmpty(qDisabilityLevel)){
			sql.append("    AND D.DISABILITY_LEVEL = ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(qDisabilityLevel);
		}
		if(StringUtils.isNotEmpty(laborCapacity)){
			sql.append("    AND X.LABOR_CAPACITY = ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(laborCapacity);
		}
		if(StringUtils.isNotEmpty(domicileType)){
			sql.append("    AND P.DOMICILE_TYPE = ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(domicileType);
		}
		if(StringUtils.isNotEmpty(assistanceClass)){
			sql.append("    AND X.ASSISTANCE_CLASS = ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(assistanceClass);
		}
		if(StringUtils.isNotEmpty(isThreeNo)){
			sql.append("    AND X.IS_THREE_NO = ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(isThreeNo);
		}
		if(StringUtils.isNotEmpty(eduCode)){
			sql.append("    AND P.EDU_CODE = ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(eduCode);
		}
		if(StringUtils.isNotEmpty(isAssistance)){
			sql.append("    AND X.IS_ASSISTANCE = ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(isAssistance);
		}
		if(StringUtils.isNotEmpty(inHospital)){
			sql.append("    AND P.IN_HOSPITAL is null ");
			//typeList.add(Types.VARCHAR);
			//objsList.add(inHospital);
		}
		String selfCareAbility=StrUtil.n2b((String)pset.getParameter("selfCareAbility"));
		if(!"".equals(selfCareAbility)){
			sql.append("    AND X.SELF_CARE_ABILITY = ? ");
		    typeList.add(Types.VARCHAR);
		    objsList.add(selfCareAbility);
		}
		if(StringUtils.isNotEmpty(qEduStatus)){
			sql.append("    AND exists (select apply_id from SAM_PEOPLE_EDU_ARCHIVE E WHERE E.APPLY_ID = P.APPLY_ID   AND E.EDU_STATUS = ? )");
			typeList.add(Types.VARCHAR);
			objsList.add(qEduStatus);
		}

		if(StringUtils.isNotEmpty(peopleTypeQuery)){
			sql.append("    AND exists (select apply_id from sam_people_type_archive pt WHERE pt.APPLY_ID = P.APPLY_ID   AND pt.PEOPLE_TYPE  in( "); 
			 String[] ary = peopleTypeQuery.split(",");
			   for (int i = 0; i < ary.length; i++) {
					sql.append(" ? ");
					if(i!=ary.length-1){
						sql.append(" , ");
				}
					typeList.add(Types.VARCHAR);
					objsList.add(ary[i]);
				}
			sql.append("))");
		}
		sql.append(" order by F.DOMICILE_CODE ,P.PEOPLE_ARCHIVE_ID ,P.FAMILY_ARCHIVE_ID ");
		
		DataSet ds=new DataSet();
	    if (typeList.size() != 0 && objsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			
			Object[] args = objsList.toArray(new Object[objsList.size()]);
			ds = this.executeDataset(sql.toString(), types, args, getDsStart(pset), getDsLimit(pset), true);
		} else {
			ds = this.executeDataset(sql.toString(), getDsStart(pset), getDsLimit(pset), true);
		}
	    return ds;
	}

	/**
	* @Title: insertPeoFromEnsurey
	* @Description: TODO(从经济核对回填人员信息)
	* @param set void  
	* @throws
	* @author luguosui
	 */
	public void insertFamilyFromEnsurey(ParameterSet set) {
		StringBuffer sql=new StringBuffer();
		sql.append(" select RELATIONSHIP_TYPE,DOMICILE_CODE,APANAGE_CODE,NAME,ID_CARD_TYPE,ID_CARD,SEX,BIRTHDAY,NATION,EDU_CODE,HEALTH_CODE,MARRIAGE_CODE, ");
		sql.append(" CAREER_CODE,POLITICAL_CODE,DOMICILE_TYPE,TEL_MOBILE,TEL_OTHER,ADDRESS,POST_CODE,INCOME_YEAR,INCOME_MONTH,EMPLOYMENT_CODE,WORK_UNIT_NAME,WORK_UNIT_TEL,WORK_UNIT_ADD ");
		sql.append(" from sam_esurey_people ");
	    String familyId=(String)set.getParameter("familyId");
		String baseinfoFamilyId=(String)set.getParameter("baseinfoFamilyId");
		sql.append(" where family_ID=? ");
		DataSet ds=executeDataset(sql.toString(), new int[]{Types.VARCHAR}, new Object[]{familyId},  true);
		if (ds.getCount()>0) {
			for (int i = 0; i < ds.getCount(); i++) {
				Record record=ds.getRecord(i);
				BaseinfoPeople dataBean=(BaseinfoPeople)RecordToBeanUtil.recordToBeanUtil(record, BaseinfoPeople.class);
				dataBean.setFamilyId(baseinfoFamilyId);
				dataBean.setPeopleId(IdHelp.getUUID32());
				this.insert(dataBean);
				
			}
		}
	}
	/**
	 * 可能成为五保对象的人员查询
	 * @return
	 */
	public DataSet queryMaybeFiveList(ParameterSet pset){
		List<Integer> typeList=new ArrayList<Integer>();
		List<String> objsList=new ArrayList<String>();
		
		String domicileCode = (String) pset.getParameter("domicileCode");
		String marriageCode = (String) pset.getParameter("marriageCode");
		String ifDisability = (String) pset.getParameter("ifDisability");
		String ifSupported = (String) pset.getParameter("ifSupported");
		String sAge = (String) pset.getParameter("sAge");
		
		if(domicileCode.indexOf("000")!=-1){
			objsList.add(getAreaCodeLikePrefix(domicileCode)+"%");
		}else {
			objsList.add(domicileCode+"%");
		}
		typeList.add(Types.VARCHAR);
		
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT P.PEOPLE_ID,");
		sql.append("       P.APPLY_ID,");
		sql.append("       X.EXTNED_ID,");
		sql.append("       P.NAME,");
		sql.append("       P.SEX,");
		sql.append("	   GETAGE_CARD_NO(P.ID_CARD) AS AGE,");
		sql.append("       GET_NATION(P.NATION) AS NATION,");
		sql.append("       P.ID_CARD,");
		sql.append("       P.INCOME_YEAR,");
		sql.append("       P.INCOME_MONTH,");
		sql.append("       P.HEALTH_CODE,");
		sql.append("       GET_EDUCATION(P.EDU_CODE) AS EDU_CODE,");
		sql.append("       GET_MARRIAGE(P.MARRIAGE_CODE) AS MARRIAGE_CODE,");
		sql.append("       GET_DOMICILE_TYPE(P.DOMICILE_TYPE) AS DOMICILE_TYPE,");
		sql.append("       X.ASSISTANCE_CLASS,");
		sql.append("       F.DOMICILE_CODE,");
		sql.append("       GET_DISABILITY_TYPE(D.DISABILITY_TYPE) AS DISABILITY_TYPE,");
		sql.append("       GET_DISABILITY_LEVEL(D.DISABILITY_LEVEL) AS DISABILITY_LEVEL,");
		sql.append("       X.LABOR_CAPACITY,");
		sql.append("       X.IS_THREE_NO,");
		sql.append("       F.ASSISTANCE_TYPE,");
		sql.append("       GET_CITY_NAME(F.DOMICILE_CODE) AS TOWN ");
		sql.append("  FROM BASEINFO_PEOPLE_ARCHIVE P, ");
		sql.append("  	   SAM_PEOPLE_DISABILITY_ARCHIVE D, ");
		sql.append("  	   SAM_PEOPLE_EXTEND_ARCHIVE X, ");
		sql.append("  	   SAM_FAMILY_TREATMENT F ");
		sql.append(" WHERE f.apply_id = p.apply_id ");
		sql.append("   AND  p.people_archive_id=d.people_archive_id(+) ");
		sql.append("   AND p.people_archive_id=x.people_archive_id ");
		sql.append("   AND P.PERSONAL_STATS_TAG = '01' ");
		sql.append("   AND F.assistance_type =  '02' ");
		sql.append("   AND F.DOMICILE_CODE LIKE ? ");
		sql.append("   AND F.begin_date <= ?  ");
		sql.append("   AND F.end_date >= ? ");
		sql.append("    and ((p.birthday < ? and (");
		sql.append("   select count(1) from sam_family_support_archive r   where r.apply_id = f.apply_id) = 0) ");
		sql.append("    or (d.disability_level <= '04' and p.marriage_code in ('40', '10', '30'))) ");
		typeList.add(Types.VARCHAR);
		objsList.add(DateUtil.getMonth());
		typeList.add(Types.VARCHAR);
		objsList.add(DateUtil.getMonth());
		typeList.add(Types.VARCHAR);
		objsList.add(sAge);
		DataSet ds=new DataSet();
		
		
		sql.append(" order by F.DOMICILE_CODE ,P.PEOPLE_ARCHIVE_ID ");
	    if (typeList.size() != 0 && objsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			Object[] args = objsList.toArray(new Object[objsList.size()]);
			ds = this.executeDataset(sql.toString(), types, args, getDsStart(pset), getDsLimit(pset), true);
		} else {
			ds = this.executeDataset(sql.toString(), getDsStart(pset), getDsLimit(pset), true);
		}
	    return ds;
	}
	/**
	 * @Title: getDsStart 
	 * @Description: TODO(excel分页信息A) 
	 * @author wangziming
	 */
	private int getDsStart(ParameterSet pset) {
		String excelType = (String)pset.getParameter("excelType");
		if(null==excelType||"0,1".indexOf(excelType)==-1) {
			return pset.getPageStart();
		}
		int start = 0;
		if("0".equals(excelType)) {  //导出当前页
			Integer startExcel = (java.lang.Integer) pset.getParameter("startExcel");
			if(startExcel!=null) {
				start = startExcel.intValue();
			}
		}
		return start;
	}
	/**
	 * @Title: getDsLimit 
	 * @Description: TODO(excel分页信息B) 
	 * @author wangziming
	 */
	private int getDsLimit(ParameterSet pset) {
		String excelType = (String)pset.getParameter("excelType");
		if(null==excelType||"0,1".indexOf(excelType)==-1) {
			return pset.getPageLimit();
		}
		int limit = ((java.lang.Integer) pset.getParameter("limitExcel")).intValue();
		return limit;
	}
	private String getAreaCodeLikePrefix(String areaCode) {
        if(areaCode.endsWith("0000000000")){//省370000000000
			return areaCode.substring(0,2);
		} else if (areaCode.endsWith("00000000")){//市370100000000
			return areaCode.substring(0,4);
		} else if (areaCode.endsWith("000000")){//县370104000000
			return areaCode.substring(0,6);
		} else if (areaCode.endsWith("000")){//乡370104003000
			return areaCode.substring(0,9);
		}
        return areaCode;
	}
	/**
	 * 低保基本变动查询
	 * @return
	 */
	public DataSet queryBaseChangePeople(ParameterSet pset){
		String domicileCode=(String)pset.getParameter("domicileCode");
		String startMonth=(String)pset.getParameter("startMonth");
		String endMonth=(String)pset.getParameter("endMonth");
		String assistanceType=(String)pset.getParameter("assistanceType");
		String changeItem=(String)pset.getParameter("changeItem");
		
		StringBuffer sql=new StringBuffer();
		List<Object> typeList = new ArrayList<Object>();
		List<Object> argsList = new ArrayList<Object>();
		sql.append("SELECT P.PEOPLE_ID,");
		sql.append("       P.APPLY_ID,");
		sql.append("       X.EXTNED_ID,");
		sql.append("       P.NAME,");
		sql.append("       P.SEX,");
		sql.append("	   GETAGE_CARD_NO(P.ID_CARD) AS AGE,");
		sql.append("       N.NAME NATION, ");
		sql.append("       P.NATION AS NATION_CODE,");
		sql.append("      P.FAMILY_ARCHIVE_ID,");
		
		sql.append("       P.ID_CARD, ");
		sql.append("       P.ADDRESS, ");
		sql.append("       P.POLITICAL_CODE, ");
		sql.append("       P.INCOME_MONTH, ");
		sql.append("       P.INCOME_YEAR, ");
		sql.append("       P.HEALTH_CODE, ");
		sql.append("       P.DOMICILE_NAME, ");
		sql.append("       P.DOMICILE_FULL_NAME, ");
		sql.append("       P.RELATIONSHIP_TYPE, ");
		sql.append("       X.BELONGING, ");
		sql.append("       X.IS_ASSISTANCE, ");
		sql.append("       E.NAME EDU_CODE,");
		sql.append("       M.NAME MARRIAGE_CODE,");
		sql.append("       Z.NAME DOMICILE_TYPE,");
		sql.append("       X.ASSISTANCE_CLASS,");
		sql.append("       Y.NAME DISABILITY_TYPE,");
		sql.append("       W.NAME DISABILITY_LEVEL,");
		sql.append("       X.LABOR_CAPACITY,");
		sql.append("       X.IS_THREE_NO,");
		sql.append("       A.DOMICILE_CODE,");
		sql.append("       A.CARD_NO,");
		sql.append("       A.ASSISTANCE_TYPE,");
		sql.append("       A.TREATMENT_ID,");//
		sql.append("       A.SUPPORT_WAY,");//
		sql.append("       A.SUPPORT_ORG,");//
		sql.append("       G.GEROCOMIUM_NAME,");//
		sql.append("       G.GEROCOMIUM_ID,");//
		sql.append("       A.FAMILY_ID,");//
		sql.append("       P.IN_HOSPITAL,");//是否入院（敬老院字段）
		sql.append("       X.SELF_CARE_ABILITY ");
		sql.append("  FROM BASEINFO_PEOPLE_ARCHIVE P, ");
		sql.append("  	   SAM_PEOPLE_DISABILITY_ARCHIVE D, ");
		sql.append("  	   SAM_PEOPLE_EXTEND_ARCHIVE X, ");
		sql.append("  	   SAM_FAMILY_TREATMENT A, ");
		sql.append("  	   sam_gerocomium_info G , ");//敬老院信息表
		
		sql.append("  	   dic_nation                    N,");
		sql.append("  	   dic_education                 E, ");
		sql.append("  	    dic_marriage                  M, ");
		sql.append("  	   dic_domicile_type             Z, ");
		sql.append("  	   dic_disability_type           Y, ");
		sql.append("  	    dic_disability_level          W ");
		
		sql.append(" WHERE P.PEOPLE_ARCHIVE_ID = D.PEOPLE_ARCHIVE_ID(+) ");
		sql.append("   AND P.PEOPLE_ARCHIVE_ID = X.PEOPLE_ARCHIVE_ID(+) ");
		sql.append("   AND A.APPLY_ID = P.APPLY_ID ");
		sql.append("   AND G.GEROCOMIUM_ID(+) = A.SUPPORT_ORG ");
		
		sql.append("   and P.NATION=N.CODE(+)  ");
		sql.append("   and P.EDU_CODE=E.CODE(+)  ");
		sql.append("   and P.MARRIAGE_CODE=M.CODE(+)  ");
		sql.append("   and P.DOMICILE_TYPE=z.CODE(+) ");
		sql.append("   and D.DISABILITY_TYPE=Y.CODE(+) ");
		sql.append("   and D.DISABILITY_LEVEL=W.CODE(+)  ");
		
		sql.append("   and X.IS_ASSISTANCE= '1'                      \n");
		sql.append("   and A.assistance_type= ?                      \n");
		sql.append("   AND A.DOMICILE_CODE LIKE ?                    \n");
		typeList.add(Types.VARCHAR);
		argsList.add(assistanceType);
		typeList.add(Types.VARCHAR);
		if(domicileCode.indexOf("000")>-1){
	   		argsList.add(getAreaCodeLikePrefix(domicileCode)+"%");
	    }else {
	   		argsList.add(domicileCode+"%");
		}
		
		if("new".endsWith(changeItem)){//新增申请
			sql.append("   AND A.change_item is null                     \n");
			typeList.add(Types.VARCHAR);
			sql.append(" and  A.begin_date between ?  \n");
			argsList.add(startMonth);
			sql.append(" and  ?  \n");
			argsList.add(endMonth);
			typeList.add(Types.VARCHAR);
	    }else if("03".endsWith(changeItem)){//停保
	    	sql.append("   AND A.change_item = ?                    \n");
	    	typeList.add(Types.VARCHAR);
	   		argsList.add(changeItem);
	    	typeList.add(Types.VARCHAR);
	    	sql.append(" and  A.end_date between ?  \n");
			argsList.add( startMonth );
			sql.append(" and  ?  \n");
			argsList.add( endMonth );
			typeList.add(Types.VARCHAR);
	    }else {
	    	sql.append("   AND A.change_item = ?                    \n");
	    	typeList.add(Types.VARCHAR);
	   		argsList.add(changeItem);
	   		typeList.add(Types.VARCHAR);
	   		sql.append(" and  A.begin_date between ?  \n");
			argsList.add(startMonth);
			sql.append(" and  ?  \n");
			argsList.add(endMonth);
			typeList.add(Types.VARCHAR);
		}
		
		sql.append(" order by A.DOMICILE_CODE ,P.FAMILY_ARCHIVE_ID ");
		
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		}
		Object[] args = argsList.toArray(new Object[argsList.size()]);
		return executeDataset(sql.toString(), types, args,getDsStart(pset), getDsLimit(pset),  true);
	}
	
	public DataSet queryCremationInfo(ParameterSet pset){
		 String familyId=(String)pset.getParameter("familyId");
		 List typeList = new ArrayList();
		 List argsList = new ArrayList();
		 StringBuffer sql = new StringBuffer();
		 sql.append("select * from FIS_CREMATION_INFO_SUM t ");
		 sql.append(" where t.id_card in( select id_card from BASEINFO_PEOPLE p where p.family_id =?)");
		 typeList.add(Types.VARCHAR);
		argsList.add(familyId);
		
		 int[] types = new int[typeList.size()];
		 for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		 }
		 Object[] args = argsList.toArray(new Object[argsList.size()]);
		 DataSet ds =  this.executeDataset(sql.toString(), types, args, true);
		 return ds;
	}
}
