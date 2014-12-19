package com.inspur.sdmz.jtxx.dao.jdbc;


import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.persistent.util.domain.BaseJdbcDao;

public class JtxxQueryDao extends BaseJdbcDao {

	@Override
	protected void initDao() {

	}
	/**
	 * 困难户家庭信息查询
	 * @param params
	 * @return
	 */
	public DataSet query(ParameterSet params,String organType,String organCode) {
		DataSet resultDs = new DataSet();
		StringBuffer jtxxSql = new StringBuffer();
		List typeList = new ArrayList();
		List<Object> argsList = new ArrayList();
		jtxxSql.append(" SELECT BASEINFO_FAMILY.FAMILY_ID as FAMILY_ID,BASEINFO_FAMILY.FAMILY_NAME AS FAMILY_NAME,BASEINFO_FAMILY.FAMILY_CARD_NO AS FAMILY_CARD_NO,BASEINFO_FAMILY.PEOPLE_NUM AS PEOPLE_NUM,BASEINFO_FAMILY.PHOTO_ID AS PHOTO_ID, ");
		jtxxSql.append(" BASEINFO_FAMILY.YEAR_INCOME AS YEAR_INCOME,BASEINFO_FAMILY.CUR_ACTIVITY AS CUR_ACTIVITY ,BASEINFO_FAMILY.CHECK_FLAG AS CHECK_FLAG,BASEINFO_FAMILY.REG_PEOPLE AS REG_PEOPLE, ");
		jtxxSql.append(" BASEINFO_FAMILY.REG_ORG_NAME AS REG_ORG_NAME,BASEINFO_FAMILY.REG_TIME AS REG_TIME ");
		//当前登陆人单位区划
		if(StringUtils.isNotEmpty(organType)){
			jtxxSql.append(" ,B.ORGAN_TYPE AS ORGAN_TYPE FROM BASEINFO_FAMILY,COM_FAMILY_ORGAN B WHERE 1=1");
			jtxxSql.append(" and BASEINFO_FAMILY.FAMILY_ID=b.FAMILY_ID ");
			jtxxSql.append(" and b.organ_type= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(organType);
		}else{
			jtxxSql.append("  FROM BASEINFO_FAMILY WHERE 1=1");
		}
		
		String REG_TIMEQ = (String) params.getParameter("REG_TIMEQ");//录入时间
		String REG_TIMEZ = (String) params.getParameter("REG_TIMEZ");//录入时间
		String FAMILY_NAME = (String) params.getParameter("FAMILY_NAME");//户主姓名
		String FAMILY_CARD_NO = (String) params.getParameter("FAMILY_CARD_NO");//身份证号码
		String CHECK_FLAG = (String) params.getParameter("CHECK_FLAG");//审核状态
		String REG_ORG = (String) params.getParameter("REG_ORG");//录入单位ID
		String ASSISTANCE_TYPE = (String) params.getParameter("ASSISTANCE_TYPE");//救助类型代码
		String curActivity = (String) params.getParameter("CUR_ACTIVITY");//当前环节
		String queryFlag = (String) params.getParameter("QUERYFLAG");//查询阶段标志
		//查询条件
		if (FAMILY_NAME != null && !FAMILY_NAME.equals("")) {
			jtxxSql.append(" and BASEINFO_FAMILY.FAMILY_NAME= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(FAMILY_NAME);
		}
		if (FAMILY_CARD_NO != null && !FAMILY_CARD_NO.equals("")) {
			jtxxSql.append(" and BASEINFO_FAMILY.FAMILY_CARD_NO= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(FAMILY_CARD_NO);
		}
		if (CHECK_FLAG != null && !CHECK_FLAG.equals("")) {
			jtxxSql.append(" and BASEINFO_FAMILY.CHECK_FLAG= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(CHECK_FLAG);
		}
		if (REG_TIMEQ != null && !REG_TIMEQ.equals("")) {
			jtxxSql.append(" and BASEINFO_FAMILY.REG_TIME>= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(REG_TIMEQ);
		}
		if (REG_TIMEZ != null && !REG_TIMEZ.equals("")) {
			jtxxSql.append(" and BASEINFO_FAMILY.REG_TIME<= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(REG_TIMEZ);
		}
		if (REG_ORG != null && !REG_ORG.equals("")) {//区划
			String[] qhArr = REG_ORG.split(",");
			boolean andFlag = false;
			boolean orFlag = false;
			for (int i = 0; i < qhArr.length; i++) {
				if(!"".equals(qhArr[i])) {
					if(!andFlag) {
						jtxxSql.append(" AND (");
					}
					andFlag = true;
					if(!orFlag) {
						jtxxSql.append(" INSTR(BASEINFO_FAMILY.REG_ORG_AREA,'"+qhArr[i]+"',1)!=0");
						orFlag = true;
					} else {
						jtxxSql.append(" or INSTR(BASEINFO_FAMILY.REG_ORG_AREA,'"+qhArr[i]+"',1)!=0");
					}
				}
			}
			if(andFlag) {
				jtxxSql.append(")");
			}
		}
		if (ASSISTANCE_TYPE != null && !ASSISTANCE_TYPE.equals("")) {//救助类型
			String[] szlxArr = ASSISTANCE_TYPE.split(",");
			boolean andFlag = false;
			boolean orFlag = false;
			for (int i = 0; i < szlxArr.length; i++) {
				if(!"".equals(szlxArr[i])) {
					if(!andFlag) {
						jtxxSql.append(" AND (");
					}
					andFlag = true;
					if(!orFlag) {
						jtxxSql.append(" INSTR(ASSISTANCE_TYPE,'"+szlxArr[i]+"',1)!=0");
						orFlag = true;
					} else {
						jtxxSql.append(" and INSTR(ASSISTANCE_TYPE,'"+szlxArr[i]+"',1)!=0");
					}
				}
			}
			if(andFlag) {
				jtxxSql.append(")");
			}
		}
		if (curActivity != null && !curActivity.equals("")) {
			jtxxSql.append(" and BASEINFO_FAMILY.CUR_ACTIVITY = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(curActivity);
		}
		//查询阶段过滤条件
		if (queryFlag != null && !queryFlag.equals("")) {
			 if(queryFlag.equals("ACCEPT")){//受理
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
				 jtxxSql.append(" and BASEINFO_FAMILY.REG_ORG_AREA LIKE ?||'%'");
				 typeList.add(Types.VARCHAR);
				 argsList.add(createOrgan);
			 }
			 else if(queryFlag.equals("EXAM")){//审核
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
				 jtxxSql.append(" and BASEINFO_FAMILY.REG_ORG_AREA like ?||'%'");
				 typeList.add(Types.VARCHAR);
				 argsList.add(createOrgan);
			 }else	if(queryFlag.equals("CORRECT")){//更正
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
				 jtxxSql.append(" and BASEINFO_FAMILY.REG_ORG_AREA like ?||'%'");
				 typeList.add(Types.VARCHAR);
				 argsList.add(createOrgan);
			 }else  if(queryFlag.equals("STATE")){//综合查询
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
				 jtxxSql.append(" and BASEINFO_FAMILY.REG_ORG_AREA LIKE ?||'%'");
				 typeList.add(Types.VARCHAR);
				 argsList.add(createOrgan);
			 }
		}
		jtxxSql.append(" ORDER BY BASEINFO_FAMILY.REG_ORG_AREA,BASEINFO_FAMILY.REG_TIME DESC");
		int start = params.getPageStart();
		int limit = params.getPageLimit();
		if(typeList.size()!=0&&argsList.size()!=0){
			int[] types = new int[typeList.size()];
			for(int i=0;i<typeList.size();i++){
				types[i] = (Integer)typeList.get(i);
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			resultDs = this.executeDataset(jtxxSql.toString(),types,args,start,limit,true);
		}else{
			resultDs = this.executeDataset(jtxxSql.toString(),start,limit,true);
		}
		return resultDs;
	}
	/**
	 * 获取家庭户数和人数
	 * @param parameterSet
	 * @return
	 */
	public DataSet getJtxxNum(ParameterSet params,String organCode) {
		 DataSet resultDs = new DataSet();
         StringBuffer jtxxSql = new StringBuffer();
         List typeList = new ArrayList();
 		 List<Object> argsList = new ArrayList();
		jtxxSql.append(" select  count(*) as HSNUM,decode(sum(BASEINFO_FAMILY.PEOPLE_NUM),'',0,sum(BASEINFO_FAMILY.PEOPLE_NUM)) RSNUM  from BASEINFO_FAMILY where 1 = 1 ");
		//当前登陆人单位区划

		//String  organCode=BspUtil.getCorpOrgan().getOrganCode();
		String REG_TIMEQ = (String) params.getParameter("REG_TIMEQ");//录入时间
		String REG_TIMEZ = (String) params.getParameter("REG_TIMEZ");//录入时间
		String FAMILY_NAME = (String) params.getParameter("FAMILY_NAME");//户主姓名
		String FAMILY_CARD_NO = (String) params.getParameter("FAMILY_CARD_NO");//身份证号码
		String CHECK_FLAG = (String) params.getParameter("CHECK_FLAG");//审核状态
		String REG_ORG = (String) params.getParameter("REG_ORG");//录入单位ID
		String ASSISTANCE_TYPE = (String) params.getParameter("ASSISTANCE_TYPE");//救助类型代码
		String curActivity = (String) params.getParameter("CUR_ACTIVITY");//当前环节
		String queryFlag = (String) params.getParameter("QUERYFLAG");//查询阶段标志
		//查询条件
		if (FAMILY_NAME != null && !FAMILY_NAME.equals("")) {
			jtxxSql.append(" and BASEINFO_FAMILY.FAMILY_NAME= ? ");
			 typeList.add(Types.VARCHAR);
			 argsList.add(FAMILY_NAME);
		}
		if (FAMILY_CARD_NO != null && !FAMILY_CARD_NO.equals("")) {
			jtxxSql.append(" and BASEINFO_FAMILY.FAMILY_CARD_NO= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(FAMILY_CARD_NO);
		}
		if (CHECK_FLAG != null && !CHECK_FLAG.equals("")) {
			jtxxSql.append(" and BASEINFO_FAMILY.CHECK_FLAG= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(CHECK_FLAG);
		}
		if (REG_TIMEQ != null && !REG_TIMEQ.equals("")) {
			jtxxSql.append(" and BASEINFO_FAMILY.REG_TIME>= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(REG_TIMEQ);
		}
		if (REG_TIMEZ != null && !REG_TIMEZ.equals("")) {
			jtxxSql.append(" and BASEINFO_FAMILY.REG_TIME<= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(REG_TIMEZ);
		}
		if (REG_ORG != null && !REG_ORG.equals("")) {//行政区划
			String[] qhArr = REG_ORG.split(",");
			boolean andFlag = false;
			boolean orFlag = false;
			for (int i = 0; i < qhArr.length; i++) {
				if(!"".equals(qhArr[i])) {
					if(!andFlag) {
						jtxxSql.append(" AND (");
					}
					andFlag = true;
					if(!orFlag) {
						jtxxSql.append(" INSTR(BASEINFO_FAMILY.REG_ORG_AREA,'"+qhArr[i]+"',1)!=0");
						orFlag = true;
					} else {
						jtxxSql.append(" or INSTR(BASEINFO_FAMILY.REG_ORG_AREA,'"+qhArr[i]+"',1)!=0");
					}
				}
			}
			if(andFlag) {
				jtxxSql.append(")");
			}
		}
		if (ASSISTANCE_TYPE != null && !ASSISTANCE_TYPE.equals("")) {//救助类型
			String[] szlxArr = ASSISTANCE_TYPE.split(",");
			boolean andFlag = false;
			boolean orFlag = false;
			for (int i = 0; i < szlxArr.length; i++) {
				if(!"".equals(szlxArr[i])) {
					if(!andFlag) {
						jtxxSql.append(" AND (");
					}
					andFlag = true;
					if(!orFlag) {
						jtxxSql.append(" INSTR(ASSISTANCE_TYPE,'"+szlxArr[i]+"',1)!=0");
						orFlag = true;
					} else {
						jtxxSql.append(" and INSTR(ASSISTANCE_TYPE,'"+szlxArr[i]+"',1)!=0");
					}
				}
			}
			if(andFlag) {
				jtxxSql.append(")");
			}
		}
		if (curActivity != null && !curActivity.equals("")) {
			jtxxSql.append(" and BASEINFO_FAMILY.CUR_ACTIVITY = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(curActivity);
		}
		//查询阶段过滤条件
		if (queryFlag != null && !queryFlag.equals("")) {
			 if(queryFlag.equals("ACCEPT")){
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
				 jtxxSql.append(" and BASEINFO_FAMILY.REG_ORG_AREA LIKE ?||'%'");
				 typeList.add(Types.VARCHAR);
				 argsList.add(createOrgan);
			 }else if(queryFlag.equals("EXAM")){
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
				 jtxxSql.append(" and BASEINFO_FAMILY.CHECK_ORG_AREA like ?||'%'");
				 typeList.add(Types.VARCHAR);
				 argsList.add(createOrgan);
			 }else	if(queryFlag.equals("CORRECT")){
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
				 jtxxSql.append(" and BASEINFO_FAMILY.REG_ORG_AREA like ?||'%'");
				 typeList.add(Types.VARCHAR);
				 argsList.add(createOrgan);
			 }else  if(queryFlag.equals("STATE")){
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
				 jtxxSql.append(" and BASEINFO_FAMILY.REG_ORG_AREA LIKE ?||'%'");
				 typeList.add(Types.VARCHAR);
				 argsList.add(createOrgan);
			 }
		}

		int start = params.getPageStart();
		int limit = params.getPageLimit();
		if(typeList.size()!=0&&argsList.size()!=0){
			int[] types = new int[typeList.size()];
			for(int i=0;i<typeList.size();i++){
				types[i] = (Integer)typeList.get(i);
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			resultDs = this.executeDataset(jtxxSql.toString(),types,args,start,limit,true);
		}else{
			resultDs = this.executeDataset(jtxxSql.toString(),start,limit,true);
		}
		return resultDs;
	}

	/**
	 *  电子监察查询困难户家庭成员信息
	 * 
	 **/
	public DataSet getJtcy(ParameterSet params,String organCode){
		StringBuffer jtxxSql = new StringBuffer();
		DataSet resultDs = new DataSet();
		List typeList = new ArrayList();
		List<Object> argsList = new ArrayList();
		String xm = (String) params.getParameter("xm");//户主姓名
		String sfzh = (String) params.getParameter("sfzh");//身份证号码
		String hzxm = (String) params.getParameter("hzxm");//户主姓名
		String relationshipType = (String) params.getParameter("relationshipType");//与户主关系
		String sex = (String) params.getParameter("sex");//性别
		String birthday = (String) params.getParameter("birthday");//出生日期
		String domicileType = (String) params.getParameter("domicileType");//户籍性质
		String nation = (String) params.getParameter("nation");//民族
		String marriageCode = (String) params.getParameter("marriageCode");//婚姻
		String politicalCode = (String) params.getParameter("politicalCode");//政治面貌
		String safeguardType = (String) params.getParameter("safeguardType");//医疗状况
		String employmentCode = (String) params.getParameter("employmentCode");//职业状况
		String assistanceType = (String) params.getParameter("assistanceType");//救助类型
		String qu=(String) params.getParameter("quQuery");
		String quQuery ="";//区县
		if(qu!=null&&!qu.equals("")){
		   quQuery =qu.substring(0, 6);//区县
		}else{
			quQuery="";
		}
		
		String dzZhenquery = (String) params.getParameter("dzZhenquery");//街道
		String dzCunquery = (String) params.getParameter("dzCunquery");//居委会 TOTALNAME(a.family_id)
		String regTimeS=(String) params.getParameter("regTimeS");//登记时间起
		String regTimeT=(String) params.getParameter("regTimeT");//登记时间止
		String importNumS=(String) params.getParameter("importNumS");//导出条目数起
		String importNumT=(String) params.getParameter("importNumT");//导出条目数止
		//查询sql
		jtxxSql.append(" SELECT TT.* FROM (SELECT T.*, ROWNUM RN FROM ( ");
		jtxxSql.append(" select b.name as name,b.id_card as id_card,a.family_name as family_name,a.family_name as jtcy, ");
		jtxxSql.append(" b.relationship_type as relationship_type,b.sex as sex ,b.birthday as birthday,b.domicile_type as domicile_type, ");
		jtxxSql.append(" b.nation as nation,b.marriage_code as marriage_code ,b.political_code as political_code,b.safeguard_type as safeguard_type, ");
		jtxxSql.append(" b.employment_code as employment_code,a.assistance_type as  assistance_type,a.reg_time as reg_time, ");
		jtxxSql.append(" a.reg_org_name as reg_org_name from baseinfo_family a,baseinfo_people b ");
		jtxxSql.append(" where a.family_id=b.family_id ");
		
		/*电子监察    */
//		jtxxSql.append(" SELECT a.FAMILY_ID as FAMILY_ID,a.PEOPLE_ID as PEOPLE_ID,a.NAME AS NAME,a.ID_CARD AS ID_CARD, ");
//		jtxxSql.append(" a.RELATIONSHIP_TYPE AS RELATIONSHIP_TYPE,a.SEX AS SEX,a.REG_PEOPLE AS REG_PEOPLE,a.REG_ORG_NAME AS REG_ORG_NAME, ");
//		jtxxSql.append(" a.NATION AS NATION,a.BIRTHDAY AS BIRTHDAY,a.DOMICILE_TYPE AS DOMICILE_TYPE,a.MARRIAGE_CODE AS MARRIAGE_CODE, ");
//		jtxxSql.append(" a.TEL_MOBILE AS TEL_MOBILE,a.CAREER_CODE AS CAREER_CODE,a.INCOME_YEAR AS INCOME_YEAR, ");
//		jtxxSql.append(" a.WORK_UNIT_NAME AS WORK_UNIT_NAME,a.SAFEGUARD_TYPE as SAFEGUARD_TYPE,a.BPT_TYPE as BPT_TYPE,a.BPT_NUM as BPT_NUM,");
//		jtxxSql.append(" b.LOSS_MON AS LOSS_MON,b.ACCIDENT_TYPE as ACCIDENT_TYPE,c.DISEASE_TYPE as DISEASE_TYPE,c.cost_mon as COST_MON, ");
//		jtxxSql.append(" d.DISABILITY_TYPE as DISABILITY_TYPE,e.ASSISTANCE_TYPE as ASSISTANCE_TYPE,f.EDUCATION as EDUCATION ");
//		jtxxSql.append(" from BASEINFO_PEOPLE a LEFT JOIN SAM_PEOPLE_ACCIDENT b ON A.PEOPLE_ID = B.PEOPLE_ID LEFT JOIN SAM_PEOPLE_DISEASE c ON A.PEOPLE_ID = C.PEOPLE_ID ");
//		jtxxSql.append(" LEFT JOIN SAM_PEOPLE_DISABILITY d ON A.PEOPLE_ID = D.PEOPLE_ID RIGHT JOIN BASEINFO_FAMILY e ON A.FAMILY_ID = E.FAMILY_ID LEFT JOIN SAM_PEOPLE_EDU f ON A.PEOPLE_ID = F.PEOPLE_ID");
//		jtxxSql.append(" where 1=1 ");
//		//查询条件
		if (xm != null && !xm.equals("")) {//姓名
			jtxxSql.append(" and b.NAME= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(xm);
		}
		if (sfzh != null && !sfzh.equals("")) {//身份证
			jtxxSql.append(" and b.ID_CARD= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(sfzh);
		}
		if (hzxm != null && !hzxm.equals("")) {//户主姓名
			jtxxSql.append(" and a.FAMILY_NAME= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(hzxm);
		}
		if (quQuery != null && !quQuery.equals("")) {//区县
			jtxxSql.append(" and a.TOWN LIKE ?||'%' ");
			typeList.add(Types.VARCHAR);
			argsList.add(quQuery);
		}
		if (dzZhenquery != null && !dzZhenquery.equals("")) {//街道
			jtxxSql.append(" and a.TOWN= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(dzZhenquery);
		}
		if (dzCunquery != null && !dzCunquery.equals("")) {//居委会
			jtxxSql.append(" and a.VILLAGE= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(dzCunquery);
		}
		
		if (relationshipType != null && !relationshipType.equals("")) {//与户主关系
			jtxxSql.append(" and b.RELATIONSHIP_TYPE= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(relationshipType);
		}
		if (sex != null && !sex.equals("")) {//性别
			jtxxSql.append(" and b.SEX= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(sex);
		}
		if (birthday != null && !birthday.equals("")) {//出生日期
			jtxxSql.append(" and b.BIRTHDAY= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(birthday);
		}
		if (domicileType != null && !domicileType.equals("")) {//户籍性质
			jtxxSql.append(" and b.DOMICILE_TYPE= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(domicileType);
		}
		if (nation != null && !nation.equals("")) {//民族
			jtxxSql.append(" and b.NATION= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(nation);
		}
		if (marriageCode != null && !marriageCode.equals("")) {//婚姻
			jtxxSql.append(" and b.MARRIAGE_CODE= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(marriageCode);
		}
		if (politicalCode != null && !politicalCode.equals("")) {//政治面貌
			jtxxSql.append(" and b.POLITICAL_CODE= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(politicalCode);
		}
		if (safeguardType != null && !safeguardType.equals("")) {//医疗状况
			jtxxSql.append(" and b.SAFEGUARD_TYPE= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(safeguardType);
		}
		if (employmentCode != null && !employmentCode.equals("")) {//职业状况
			jtxxSql.append(" and b.EMPLOYMENT_CODE= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(employmentCode);
		}
		if (assistanceType != null && !assistanceType.equals("")) {//救助类型
			String[] szlxArr = assistanceType.split(",");
			boolean andFlag = false;
			boolean orFlag = false;
			for (int i = 0; i < szlxArr.length; i++) {
				if(!"".equals(szlxArr[i])) {
					if(!andFlag) {
						jtxxSql.append(" AND (");
					}
					andFlag = true;
					if(!orFlag) {
						jtxxSql.append(" INSTR(a.ASSISTANCE_TYPE,'"+szlxArr[i]+"',1)!=0");
						orFlag = true;
					} else {
						jtxxSql.append(" AND INSTR(a.ASSISTANCE_TYPE,'"+szlxArr[i]+"',1)!=0");
					}
				}
			}if(andFlag) {
				jtxxSql.append(")");
			}
 
		}
		if (regTimeS != null && !regTimeS.equals("")) {//职业状况
			jtxxSql.append(" and a.REG_TIME >= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(regTimeS);
		}
		if (regTimeT != null && !regTimeT.equals("")) {//职业状况
			jtxxSql.append(" and a.REG_TIME <= ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(regTimeT);
		}
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
		 	jtxxSql.append(" and a.REG_ORG_AREA LIKE ?||'%'");
		 	typeList.add(Types.VARCHAR);
			argsList.add(createOrgan);
//			String importNumS=(String) params.getParameter("importNumS");//导出条目数起
//			String importNumT=(String) params.getParameter("importNumT");//导出条目数止
			
			if (importNumT != null && !"".equals(importNumT)) {
				jtxxSql.append(") T WHERE ROWNUM <=" + importNumT);						
			}else{
				jtxxSql.append(") T WHERE ROWNUM > 0");
			}
			if (importNumS != null && !"".equals(importNumS)) {
				jtxxSql.append(") TT WHERE RN >=" + importNumS);	
			}else{
				jtxxSql.append(") TT WHERE RN >0");			
			}	
	 
			int start = params.getPageStart();
			int limit = params.getPageLimit();
			if(typeList.size()!=0&&argsList.size()!=0){
				int[] types = new int[typeList.size()];
				for(int i=0;i<typeList.size();i++){
					types[i] = (Integer)typeList.get(i);
				}
				Object[] args = argsList.toArray(new Object[argsList.size()]);
				resultDs = this.executeDataset(jtxxSql.toString(),types,args,start,limit,true);
			}else{
				resultDs = this.executeDataset(jtxxSql.toString(),start,limit,true);
			}
			return resultDs;
	}
	
 

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
	private int getDsLimit(ParameterSet pset) {
		String excelType = (String)pset.getParameter("excelType");
		if(null==excelType||"0,1".indexOf(excelType)==-1) {
			return pset.getPageLimit();
		}
		int limit = ((java.lang.Integer) pset.getParameter("limitExcel")).intValue();
		return limit>1000?1000:limit;
	}
@SuppressWarnings("unchecked")
public DataSet getJtcy1(ParameterSet params,String organCode) {
	StringBuffer jtxxSql = new StringBuffer();
	DataSet resultDs = new DataSet();
	List typeList = new ArrayList();
	List<Object> argsList = new ArrayList();
	String xm = (String) params.getParameter("xm");//户主姓名
	String sfzh = (String) params.getParameter("sfzh");//身份证号码
	String hzxm = (String) params.getParameter("hzxm");//户主姓名
	String relationshipType = (String) params.getParameter("relationshipType");//与户主关系
	String sex = (String) params.getParameter("sex");//性别
	String birthday = (String) params.getParameter("birthday");//出生日期
	String domicileType = (String) params.getParameter("domicileType");//户籍性质
	String nation = (String) params.getParameter("nation");//民族
	String marriageCode = (String) params.getParameter("marriageCode");//婚姻
	String politicalCode = (String) params.getParameter("politicalCode");//政治面貌
	String safeguardType = (String) params.getParameter("safeguardType");//医疗状况
	String employmentCode = (String) params.getParameter("employmentCode");//职业状况
	String assistanceType = (String) params.getParameter("assistanceType");//救助类型
	String qu=(String) params.getParameter("quQuery");
	String quQuery ="";//区县
	if(qu!=null&&!qu.equals("")){
	   quQuery =qu.substring(0, 6);//区县
	}else{
		quQuery="";
	}
	
	String dzZhenquery = (String) params.getParameter("dzZhenquery");//街道
	String dzCunquery = (String) params.getParameter("dzCunquery");//居委会 
	String regTimeS=(String) params.getParameter("regTimeS");//登记时间起
	String regTimeT=(String) params.getParameter("regTimeT");//登记时间止
	String importNumS=(String) params.getParameter("importNumS");//导出条目数起
	String importNumT=(String) params.getParameter("importNumT");//导出条目数止
	String peopleNum = (String) params.getParameter("peopleNum");//家庭人口数量
	String ageStageS = (String) params.getParameter("ageStageS");//查询年龄段起
	String ageStageT = (String) params.getParameter("ageStageT");//查询年龄段止
	      
	//查询sql
	jtxxSql.append(" SELECT TT.* FROM (SELECT T.*, ROWNUM RN FROM ( ");
	jtxxSql.append(" select b.name as name,b.id_card as id_card,a.family_name as family_name,TOTALNAME(a.family_id) as jtcy,a.PEOPLE_NUM as people_num, ");
	jtxxSql.append(" b.relationship_type as relationship_type,b.sex as sex ,b.birthday as birthday,b.domicile_type as domicile_type, ");
	jtxxSql.append(" b.nation as nation,b.marriage_code as marriage_code ,b.political_code as political_code,b.safeguard_type as safeguard_type, ");
	jtxxSql.append(" b.employment_code as employment_code,a.assistance_type as  assistance_type,a.reg_time as reg_time, ");
	jtxxSql.append(" a.reg_org_name as reg_org_name from baseinfo_family a,baseinfo_people b ");
	jtxxSql.append(" where a.family_id=b.family_id ");
	
	/*电子监察    */
//	jtxxSql.append(" SELECT a.FAMILY_ID as FAMILY_ID,a.PEOPLE_ID as PEOPLE_ID,a.NAME AS NAME,a.ID_CARD AS ID_CARD, ");
//	jtxxSql.append(" a.RELATIONSHIP_TYPE AS RELATIONSHIP_TYPE,a.SEX AS SEX,a.REG_PEOPLE AS REG_PEOPLE,a.REG_ORG_NAME AS REG_ORG_NAME, ");
//	jtxxSql.append(" a.NATION AS NATION,a.BIRTHDAY AS BIRTHDAY,a.DOMICILE_TYPE AS DOMICILE_TYPE,a.MARRIAGE_CODE AS MARRIAGE_CODE, ");
//	jtxxSql.append(" a.TEL_MOBILE AS TEL_MOBILE,a.CAREER_CODE AS CAREER_CODE,a.INCOME_YEAR AS INCOME_YEAR, ");
//	jtxxSql.append(" a.WORK_UNIT_NAME AS WORK_UNIT_NAME,a.SAFEGUARD_TYPE as SAFEGUARD_TYPE,a.BPT_TYPE as BPT_TYPE,a.BPT_NUM as BPT_NUM,");
//	jtxxSql.append(" b.LOSS_MON AS LOSS_MON,b.ACCIDENT_TYPE as ACCIDENT_TYPE,c.DISEASE_TYPE as DISEASE_TYPE,c.cost_mon as COST_MON, ");
//	jtxxSql.append(" d.DISABILITY_TYPE as DISABILITY_TYPE,e.ASSISTANCE_TYPE as ASSISTANCE_TYPE,f.EDUCATION as EDUCATION ");
//	jtxxSql.append(" from BASEINFO_PEOPLE a LEFT JOIN SAM_PEOPLE_ACCIDENT b ON A.PEOPLE_ID = B.PEOPLE_ID LEFT JOIN SAM_PEOPLE_DISEASE c ON A.PEOPLE_ID = C.PEOPLE_ID ");
//	jtxxSql.append(" LEFT JOIN SAM_PEOPLE_DISABILITY d ON A.PEOPLE_ID = D.PEOPLE_ID RIGHT JOIN BASEINFO_FAMILY e ON A.FAMILY_ID = E.FAMILY_ID LEFT JOIN SAM_PEOPLE_EDU f ON A.PEOPLE_ID = F.PEOPLE_ID");
//	jtxxSql.append(" where 1=1 ");
//	//查询条件
	if (xm != null && !xm.equals("")) {//姓名
		jtxxSql.append(" and b.NAME= ? ");
		typeList.add(Types.VARCHAR);
		argsList.add(xm);
	}
	if (sfzh != null && !sfzh.equals("")) {//身份证
		jtxxSql.append(" and b.ID_CARD= ? ");
		typeList.add(Types.VARCHAR);
		argsList.add(sfzh);
	}
	if (hzxm != null && !hzxm.equals("")) {//户主姓名
		jtxxSql.append(" and a.FAMILY_NAME= ? ");
		typeList.add(Types.VARCHAR);
		argsList.add(hzxm);
	}
	if (quQuery != null && !quQuery.equals("")) {//区县
		jtxxSql.append(" and a.TOWN LIKE ?||'%' ");
		typeList.add(Types.VARCHAR);
		argsList.add(quQuery);
	}
	if (dzZhenquery != null && !dzZhenquery.equals("")) {//街道
		jtxxSql.append(" and a.TOWN= ? ");
		typeList.add(Types.VARCHAR);
		argsList.add(dzZhenquery);
	}
	if (dzCunquery != null && !dzCunquery.equals("")) {//居委会
		jtxxSql.append(" and a.VILLAGE= ? ");
		typeList.add(Types.VARCHAR);
		argsList.add(dzCunquery);
	}
	
	if (relationshipType != null && !relationshipType.equals("")) {//与户主关系
		jtxxSql.append(" and b.RELATIONSHIP_TYPE= ? ");
		typeList.add(Types.VARCHAR);
		argsList.add(relationshipType);
	}
	if (sex != null && !sex.equals("")) {//性别
		jtxxSql.append(" and b.SEX= ? ");
		typeList.add(Types.VARCHAR);
		argsList.add(sex);
	}
	if (birthday != null && !birthday.equals("")) {//出生日期
		jtxxSql.append(" and b.BIRTHDAY= ? ");
		typeList.add(Types.VARCHAR);
		argsList.add(birthday);
	}
	if (domicileType != null && !domicileType.equals("")) {//户籍性质
		jtxxSql.append(" and b.DOMICILE_TYPE= ? ");
		typeList.add(Types.VARCHAR);
		argsList.add(domicileType);
	}
	if (nation != null && !nation.equals("")) {//民族
		jtxxSql.append(" and b.NATION= ? ");
		typeList.add(Types.VARCHAR);
		argsList.add(nation);
	}
	if (marriageCode != null && !marriageCode.equals("")) {//婚姻
		jtxxSql.append(" and b.MARRIAGE_CODE= ? ");
		typeList.add(Types.VARCHAR);
		argsList.add(marriageCode);
	}
	if (politicalCode != null && !politicalCode.equals("")) {//政治面貌
		jtxxSql.append(" and b.POLITICAL_CODE= ? ");
		typeList.add(Types.VARCHAR);
		argsList.add(politicalCode);
	}
	if (safeguardType != null && !safeguardType.equals("")) {//医疗状况
		jtxxSql.append(" and b.SAFEGUARD_TYPE= ? ");
		typeList.add(Types.VARCHAR);
		argsList.add(safeguardType);
	}
	if (employmentCode != null && !employmentCode.equals("")) {//职业状况
		jtxxSql.append(" and b.EMPLOYMENT_CODE= ? ");
		typeList.add(Types.VARCHAR);
		argsList.add(employmentCode);
	}
	if (peopleNum != null && !peopleNum.equals("")) {//家庭人口数量
		jtxxSql.append(" and a.PEOPLE_NUM= ? ");
		typeList.add(Types.VARCHAR);
		argsList.add(peopleNum);
	}
	if (ageStageS != null && !ageStageS.equals("")) {//查询年龄段起
		jtxxSql.append(" and floor(to_number(sysdate - TO_DATE(b.BIRTHDAY, 'YYYYMMDD')) / 365) >= ? ");
		typeList.add(Types.VARCHAR);
		argsList.add(ageStageS);
	}
	if (ageStageT != null && !ageStageT.equals("")) {//查询年龄段止
		jtxxSql.append(" and floor(to_number(sysdate - TO_DATE(b.BIRTHDAY, 'YYYYMMDD')) / 365) <= ? ");
		typeList.add(Types.VARCHAR);
		argsList.add(ageStageT);
	}
	if (assistanceType != null && !assistanceType.equals("")) {//救助类型
		String[] szlxArr = assistanceType.split(",");
		boolean andFlag = false;
		boolean orFlag = false;
		for (int i = 0; i < szlxArr.length; i++) {
			if(!"".equals(szlxArr[i])) {
				if(!andFlag) {
					jtxxSql.append(" AND (");
				}
				andFlag = true;
				if(!orFlag) {
					jtxxSql.append(" INSTR(a.ASSISTANCE_TYPE,'"+szlxArr[i]+"',1)!=0");
					orFlag = true;
				} else {
					jtxxSql.append(" AND INSTR(a.ASSISTANCE_TYPE,'"+szlxArr[i]+"',1)!=0");
				}
			}
		}if(andFlag) {
			jtxxSql.append(")");
		}

	}
	if (regTimeS != null && !regTimeS.equals("")) {//登记日期起
		jtxxSql.append(" and a.REG_TIME >= ? ");
		typeList.add(Types.VARCHAR);
		argsList.add(regTimeS);
	}
	if (regTimeT != null && !regTimeT.equals("")) {//登记日期止
		jtxxSql.append(" and a.REG_TIME <= ? ");
		typeList.add(Types.VARCHAR);
		argsList.add(regTimeT);
	}
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
	 	jtxxSql.append(" and a.REG_ORG_AREA LIKE ?||'%'");
	 	typeList.add(Types.VARCHAR);
		argsList.add(createOrgan);
//		String importNumS=(String) params.getParameter("importNumS");//导出条目数起
//		String importNumT=(String) params.getParameter("importNumT");//导出条目数止
		
		if (importNumT != null && !"".equals(importNumT)) {
			jtxxSql.append(") T WHERE ROWNUM <=" + importNumT);						
		}else{
			jtxxSql.append(") T WHERE ROWNUM > 0");
		}
		if (importNumS != null && !"".equals(importNumS)) {
			jtxxSql.append(") TT WHERE RN >=" + importNumS);	
		}else{
			jtxxSql.append(") TT WHERE RN >0");			
		}	
 
		if(typeList.size()!=0&&argsList.size()!=0){
			int[] types = new int[typeList.size()];
			for(int i=0;i<typeList.size();i++){
				types[i] = (Integer)typeList.get(i);
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			resultDs = this.executeDataset(jtxxSql.toString(),types,args,getDsStart(params),getDsLimit(params),true);
		}else{
			resultDs = this.executeDataset(jtxxSql.toString(),getDsStart(params),getDsLimit(params),true);
		}
		return resultDs;
}
@SuppressWarnings("unchecked")
public DataSet getJtcyNum(ParameterSet params,String organCode) {
	StringBuffer jtxxSql = new StringBuffer();
	DataSet resultDs = new DataSet();
	List typeList = new ArrayList();
	List<Object> argsList = new ArrayList();
	String xm = (String) params.getParameter("xm");//户主姓名
	String sfzh = (String) params.getParameter("sfzh");//身份证号码
	String hzxm = (String) params.getParameter("hzxm");//户主姓名
	String relationshipType = (String) params.getParameter("relationshipType");//与户主关系
	String sex = (String) params.getParameter("sex");//性别
	String birthday = (String) params.getParameter("birthday");//出生日期
	String domicileType = (String) params.getParameter("domicileType");//户籍性质
	String nation = (String) params.getParameter("nation");//民族
	String marriageCode = (String) params.getParameter("marriageCode");//婚姻
	String politicalCode = (String) params.getParameter("politicalCode");//政治面貌
	String safeguardType = (String) params.getParameter("safeguardType");//医疗状况
	String employmentCode = (String) params.getParameter("employmentCode");//职业状况
	String assistanceType = (String) params.getParameter("assistanceType");//救助类型
	String qu=(String) params.getParameter("quQuery");
	String quQuery ="";//区县
	if(qu!=null&&!qu.equals("")){
	   quQuery =qu.substring(0, 6);//区县
	}else{
		quQuery="";
	}
	
	String dzZhenquery = (String) params.getParameter("dzZhenquery");//街道
	String dzCunquery = (String) params.getParameter("dzCunquery");//居委会 
	String regTimeS=(String) params.getParameter("regTimeS");//登记时间起
	String regTimeT=(String) params.getParameter("regTimeT");//登记时间止
	String importNumS=(String) params.getParameter("importNumS");//导出条目数起
	String importNumT=(String) params.getParameter("importNumT");//导出条目数止
	String peopleNum = (String) params.getParameter("peopleNum");//家庭人口数量
	String ageStageS = (String) params.getParameter("ageStageS");//查询年龄段起
	String ageStageT = (String) params.getParameter("ageStageT");//查询年龄段止
	      
	//查询sql
	jtxxSql.append(" SELECT TT.* FROM (SELECT T.*, ROWNUM RN FROM ( ");
	jtxxSql.append("  select  count(distinct b.family_id) as HSNUM, count(*) as RSNUM  ");
	jtxxSql.append("  from baseinfo_family a,baseinfo_people b ");
	jtxxSql.append("  where a.family_id=b.family_id ");
	
  	//查询条件
	if (xm != null && !xm.equals("")) {//姓名
		jtxxSql.append(" and b.NAME= ? ");
		typeList.add(Types.VARCHAR);
		argsList.add(xm);
	}
	if (sfzh != null && !sfzh.equals("")) {//身份证
		jtxxSql.append(" and b.ID_CARD= ? ");
		typeList.add(Types.VARCHAR);
		argsList.add(sfzh);
	}
	if (hzxm != null && !hzxm.equals("")) {//户主姓名
		jtxxSql.append(" and a.FAMILY_NAME= ? ");
		typeList.add(Types.VARCHAR);
		argsList.add(hzxm);
	}
	if (quQuery != null && !quQuery.equals("")) {//区县
		jtxxSql.append(" and a.TOWN LIKE ?||'%' ");
		typeList.add(Types.VARCHAR);
		argsList.add(quQuery);
	}
	if (dzZhenquery != null && !dzZhenquery.equals("")) {//街道
		jtxxSql.append(" and a.TOWN= ? ");
		typeList.add(Types.VARCHAR);
		argsList.add(dzZhenquery);
	}
	if (dzCunquery != null && !dzCunquery.equals("")) {//居委会
		jtxxSql.append(" and a.VILLAGE= ? ");
		typeList.add(Types.VARCHAR);
		argsList.add(dzCunquery);
	}
	
	if (relationshipType != null && !relationshipType.equals("")) {//与户主关系
		jtxxSql.append(" and b.RELATIONSHIP_TYPE= ? ");
		typeList.add(Types.VARCHAR);
		argsList.add(relationshipType);
	}
	if (sex != null && !sex.equals("")) {//性别
		jtxxSql.append(" and b.SEX= ? ");
		typeList.add(Types.VARCHAR);
		argsList.add(sex);
	}
	if (birthday != null && !birthday.equals("")) {//出生日期
		jtxxSql.append(" and b.BIRTHDAY= ? ");
		typeList.add(Types.VARCHAR);
		argsList.add(birthday);
	}
	if (domicileType != null && !domicileType.equals("")) {//户籍性质
		jtxxSql.append(" and b.DOMICILE_TYPE= ? ");
		typeList.add(Types.VARCHAR);
		argsList.add(domicileType);
	}
	if (nation != null && !nation.equals("")) {//民族
		jtxxSql.append(" and b.NATION= ? ");
		typeList.add(Types.VARCHAR);
		argsList.add(nation);
	}
	if (marriageCode != null && !marriageCode.equals("")) {//婚姻
		jtxxSql.append(" and b.MARRIAGE_CODE= ? ");
		typeList.add(Types.VARCHAR);
		argsList.add(marriageCode);
	}
	if (politicalCode != null && !politicalCode.equals("")) {//政治面貌
		jtxxSql.append(" and b.POLITICAL_CODE= ? ");
		typeList.add(Types.VARCHAR);
		argsList.add(politicalCode);
	}
	if (safeguardType != null && !safeguardType.equals("")) {//医疗状况
		jtxxSql.append(" and b.SAFEGUARD_TYPE= ? ");
		typeList.add(Types.VARCHAR);
		argsList.add(safeguardType);
	}
	if (employmentCode != null && !employmentCode.equals("")) {//职业状况
		jtxxSql.append(" and b.EMPLOYMENT_CODE= ? ");
		typeList.add(Types.VARCHAR);
		argsList.add(employmentCode);
	}
	if (peopleNum != null && !peopleNum.equals("")) {//家庭人口数量
		jtxxSql.append(" and a.PEOPLE_NUM= ? ");
		typeList.add(Types.VARCHAR);
		argsList.add(peopleNum);
	}
	if (ageStageS != null && !ageStageS.equals("")) {//查询年龄段起
		jtxxSql.append(" and floor(to_number(sysdate - TO_DATE(b.BIRTHDAY, 'YYYYMMDD')) / 365) >= ? ");
		typeList.add(Types.VARCHAR);
		argsList.add(ageStageS);
	}
	if (ageStageT != null && !ageStageT.equals("")) {//查询年龄段止
		jtxxSql.append(" and floor(to_number(sysdate - TO_DATE(b.BIRTHDAY, 'YYYYMMDD')) / 365) <= ? ");
		typeList.add(Types.VARCHAR);
		argsList.add(ageStageT);
	}
	if (assistanceType != null && !assistanceType.equals("")) {//救助类型
		String[] szlxArr = assistanceType.split(",");
		boolean andFlag = false;
		boolean orFlag = false;
		for (int i = 0; i < szlxArr.length; i++) {
			if(!"".equals(szlxArr[i])) {
				if(!andFlag) {
					jtxxSql.append(" AND (");
				}
				andFlag = true;
				if(!orFlag) {
					jtxxSql.append(" INSTR(a.ASSISTANCE_TYPE,'"+szlxArr[i]+"',1)!=0");
					orFlag = true;
				} else {
					jtxxSql.append(" AND INSTR(a.ASSISTANCE_TYPE,'"+szlxArr[i]+"',1)!=0");
				}
			}
		}if(andFlag) {
			jtxxSql.append(")");
		}

	}
	if (regTimeS != null && !regTimeS.equals("")) {//登记日期起
		jtxxSql.append(" and a.REG_TIME >= ? ");
		typeList.add(Types.VARCHAR);
		argsList.add(regTimeS);
	}
	if (regTimeT != null && !regTimeT.equals("")) {//登记日期止
		jtxxSql.append(" and a.REG_TIME <= ? ");
		typeList.add(Types.VARCHAR);
		argsList.add(regTimeT);
	}
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
	 	jtxxSql.append(" and a.REG_ORG_AREA LIKE ?||'%'");
	 	typeList.add(Types.VARCHAR);
		argsList.add(createOrgan);
		
		if (importNumT != null && !"".equals(importNumT)) {
			jtxxSql.append(") T WHERE ROWNUM <=" + importNumT);						
		}else{
			jtxxSql.append(") T WHERE ROWNUM > 0");
		}
		if (importNumS != null && !"".equals(importNumS)) {
			jtxxSql.append(") TT WHERE RN >=" + importNumS);	
		}else{
			jtxxSql.append(") TT WHERE RN >0");			
		}	
 
		if(typeList.size()!=0&&argsList.size()!=0){
			int[] types = new int[typeList.size()];
			for(int i=0;i<typeList.size();i++){
				types[i] = (Integer)typeList.get(i);
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			resultDs = this.executeDataset(jtxxSql.toString(),types,args,getDsStart(params),getDsLimit(params),true);
		}else{
			resultDs = this.executeDataset(jtxxSql.toString(),getDsStart(params),getDsLimit(params),true);
		}
		return resultDs;
}

}
