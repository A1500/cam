package com.inspur.cams.comm.baseinfo.dao.jdbc;

import java.sql.Types;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import bsh.This;

import com.inspur.cams.comm.baseinfo.dao.IBaseinfoFamilyDao;
import com.inspur.cams.comm.baseinfo.data.BaseinfoFamily;
import com.inspur.cams.comm.util.ProceduresUtil;
import com.inspur.cams.comm.util.RecordToBeanUtil;
import com.inspur.cams.comm.util.StrUtil;


/**
 * @title:BaseinfoFamilyDao
 * @description:
 * @author:
 * @since:2011-05-12
 * @version:1.0
*/
 public class BaseinfoFamilyDao extends EntityDao<BaseinfoFamily> implements IBaseinfoFamilyDao{

 	public BaseinfoFamilyDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

	@SuppressWarnings("unchecked")
	public Class getEntityClass() {
		return BaseinfoFamily.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from BaseinfoFamily");
	}
	// 更新成员数量
	public void updatePeopleNum(String familyId) {
		StringBuffer sql = new StringBuffer();
		sql.append("update BASEINFO_FAMILY A \n");
		sql.append("set PEOPLE_NUM   = (select count(1) from BASEINFO_PEOPLE where A.FAMILY_ID = FAMILY_ID and PERSONAL_STATS_TAG='01'), \n");
		sql.append("	ASSISTANCE_PEOPLE_NUM   = (select count(1) from BASEINFO_PEOPLE P,SAM_PEOPLE_EXTEND E WHERE P.PEOPLE_ID=E.PEOPLE_ID AND E.IS_ASSISTANCE='1' AND A.FAMILY_ID = FAMILY_ID and P.PERSONAL_STATS_TAG='01'), \n");
		sql.append("    YEAR_AVERAGE_INCOME = round(YEAR_INCOME / (select count(1) from BASEINFO_PEOPLE where A.FAMILY_ID = FAMILY_ID and PERSONAL_STATS_TAG='01'),2) ,\n");
		sql.append("    MONTH_INCOME = round(YEAR_INCOME / 12,2) ,\n");
		sql.append("    MONTH_AVERAGE_INCOME = round(YEAR_INCOME / (select count(1)*12 from BASEINFO_PEOPLE where A.FAMILY_ID = FAMILY_ID and  PERSONAL_STATS_TAG='01'),2) ,\n");
		sql.append("    BUILD_AVERAGE_AREA   = round(BUILD_AREA / (select count(1) from BASEINFO_PEOPLE where A.FAMILY_ID = FAMILY_ID and PERSONAL_STATS_TAG='01'),2) \n");
		sql.append("where FAMILY_ID = '").append(familyId).append("' ");
		executeUpdate(sql.toString());
	}
	// 根据人员月收入更新家庭年收入，城市低保（年收入=人员年收入+赡养人年收入）
	public void updateIncomeByMonth(String familyId) {
		StringBuffer sql = new StringBuffer();
		sql.append("update BASEINFO_FAMILY A \n");
		sql.append("set YEAR_INCOME   = (select nvl(SUM(INCOME_MONTH * 12),0)+(" +
				"select nvl(sum(s.supported_pay * 12),0) from Sam_Family_Support s where s.family_id = p.family_id "+
		" ) from BASEINFO_PEOPLE p where A.FAMILY_ID = p.FAMILY_ID and p.PERSONAL_STATS_TAG='01' group by family_id ) \n");
		sql.append("where A.FAMILY_ID = '").append(familyId).append("' ");
		executeUpdate(sql.toString());
	}
	// 根据人员年收入更新家庭收入
	public void updateIncomeByYear(String familyId) {
		StringBuffer sql = new StringBuffer();
		sql.append("update BASEINFO_FAMILY A \n");
		sql.append("set YEAR_INCOME   = (select nvl(SUM(INCOME_YEAR),0)" +
				"+(" +
				"select nvl(sum(s.supported_pay),0) from Sam_Family_Support s where s.family_id = p.family_id ) from BASEINFO_PEOPLE p" +
				" where A.FAMILY_ID = p.FAMILY_ID and PERSONAL_STATS_TAG='01' group by family_id  ) \n");
		sql.append("where FAMILY_ID = '").append(familyId).append("' ");
		executeUpdate(sql.toString());
	}
	// 更该流程环节
	public void updateCurrentActivity(String activity, String familyIds,String createOrgan ) {
		StringBuffer sql = new StringBuffer();
		sql.append("update BASEINFO_FAMILY A \n");
		sql.append("set CUR_ACTIVITY   = '").append(activity).append("' \n");
		sql.append(" , CHECK_ORG_AREA   = '").append(createOrgan).append("' \n");
		sql.append("where FAMILY_ID in ('").append(familyIds.replaceAll(",", "','")).append("') ");
		
		executeUpdate(sql.toString());
	}
	// 更新计算状态
	public void updateJtdz(String familyId) {
		StringBuffer sql = new StringBuffer();
		sql.append("update BASEINFO_FAMILY A \n");
		sql.append("set JTDZ   = '1' \n");
		sql.append("where FAMILY_ID = '").append(familyId).append("' ");
		executeUpdate(sql.toString());
	}
	/**
	* @Title: querySamFamilyList
	* @Description: TODO(家庭信息列表查询，专项救助列表查询使用)
	* @param pset
	* @return DataSet  
	* @throws
	* @author luguosui
	 */
	public DataSet querySamFamilyList(ParameterSet pset){
		StringBuffer querySql = new StringBuffer();
		List<Object> typeList = new ArrayList<Object>();
		typeList.add(Types.VARCHAR);
		typeList.add(Types.VARCHAR);
		typeList.add(Types.VARCHAR);
		List<Object> argsList = new ArrayList<Object>();
		argsList.add(pset.getParameter("queryDate"));
		argsList.add(pset.getParameter("queryDate"));
		String domicileCode=StrUtil.n2b((String)pset.getParameter("domicileCode"));
		if(domicileCode.indexOf("000")!=-1){
			argsList.add(getAreaCodeLikePrefix(domicileCode)+"%");
		}else {
			argsList.add(domicileCode+"%");
		}
		querySql.append("SELECT A.TREATMENT_ID,                           \n");
		querySql.append("       A.SUPPORT_WAY,                            \n");
		querySql.append("       A.SUPPORT_ORG,                            \n");
		querySql.append("       B.FAMILY_ID,                              \n");
		querySql.append("       B.FAMILY_ARCHIVE_ID,                              \n");
		querySql.append("       A.APPLY_ID,                               \n");
		querySql.append("       A.CARD_NO,                                \n");
		querySql.append("       A.BEGIN_DATE,                             \n");
		querySql.append("       A.END_DATE,                               \n");
		querySql.append("       B.DOMICILE_NAME,                          \n");
		querySql.append("       B.FAMILY_CARD_NO,                         \n");
		querySql.append("       B.FAMILY_NAME,                            \n");
		querySql.append("       B.PEOPLE_NUM,                             \n");
		querySql.append("       B.ASSISTANCE_PEOPLE_NUM,                  \n");
		querySql.append("       B.BELONGING,                              \n");
		querySql.append("       B.YEAR_AVERAGE_INCOME,                    \n");
		querySql.append("       B.MONTH_AVERAGE_INCOME,                   \n");
		querySql.append("       A.ASSISTANCE_MONEY,                       \n");
		querySql.append("       A.ASSISTANCE_MODE,                       \n");
		querySql.append("       B.ASSISTANCE_CLASS,                       \n");
		querySql.append("       B.ADDRESS,                                \n");
		querySql.append("       A.ASSISTANCE_CLASS_MONEY,                 \n");
		querySql.append("       A.ASSISTANCE_TYPE,                        \n");
		querySql.append("       B.POVERTY_CAUSE,                          \n");
		querySql.append("       B.APANAGE_CODE  ,                          \n");
		querySql.append("       B.DOMICILE_FULL_NAME                       \n");
		querySql.append("  FROM SAM_FAMILY_TREATMENT A,BASEINFO_FAMILY_ARCHIVE B \n");
		querySql.append(" WHERE A.FAMILY_ID = B.FAMILY_ID                 \n");
		querySql.append("	AND A.APPLY_ID = B.APPLY_ID                   \n");
		querySql.append("   AND A.BEGIN_DATE <= ?                         \n");
		querySql.append("   AND A.END_DATE >= ?                           \n");
		querySql.append("   AND A.DOMICILE_CODE LIKE ?                    \n");
		String familyId=StrUtil.n2b((String)pset.getParameter("familyId"));
		if(StringUtils.isNotEmpty(familyId)){
			querySql.append("   AND A.FAMILY_ID = ?                       \n");
			typeList.add(Types.VARCHAR);
			argsList.add(familyId);
		}
	
		
		String applyId=StrUtil.n2b((String)pset.getParameter("applyId"));
		if(StringUtils.isNotEmpty(applyId)){
			querySql.append("   AND A.APPLY_ID = ?                       \n");
			typeList.add(Types.VARCHAR);
			argsList.add(applyId);
		}
		
		
		String assistanceType=StrUtil.n2b((String)pset.getParameter("assistanceType"));
		if(StringUtils.isNotEmpty(assistanceType)){
			querySql.append("   AND A.ASSISTANCE_TYPE = ?                 \n");
			typeList.add(Types.VARCHAR);
			argsList.add(assistanceType);
		}
		String familyName=StrUtil.n2b((String)pset.getParameter("familyName"));
		if(StringUtils.isNotEmpty(familyName)){
			querySql.append("   AND B.FAMILY_NAME = ?                     \n");
			typeList.add(Types.VARCHAR);
			argsList.add(familyName);
		}

		String sPeopleNum=StrUtil.n2b((String)pset.getParameter("sPeopleNum"));
		if(StringUtils.isNotEmpty(sPeopleNum)){
			querySql.append("   AND B.PEOPLE_NUM > =?                     \n");
			typeList.add(Types.DECIMAL);
			argsList.add(sPeopleNum);
		}
		
		String sAssitancePeopleNum=StrUtil.n2b((String)pset.getParameter("sAssitancePeopleNum"));
		if(StringUtils.isNotEmpty(sAssitancePeopleNum)){
			querySql.append("   AND B.ASSISTANCE_PEOPLE_NUM > =?                     \n");
			typeList.add(Types.DECIMAL);
			argsList.add(sAssitancePeopleNum);
		}
		String belonging=StrUtil.n2b((String)pset.getParameter("belonging"));
		if(StringUtils.isNotEmpty(belonging)){
			querySql.append("   AND B.BELONGING =?                     \n");
			typeList.add(Types.VARCHAR);
			argsList.add(belonging);
		}
		String povertyCause=StrUtil.n2b((String)pset.getParameter("povertyCause"));
		if(StringUtils.isNotEmpty(povertyCause)){
			querySql.append("   AND B.POVERTY_CAUSE =?                    \n");
			typeList.add(Types.VARCHAR);
			argsList.add(povertyCause);
		}
		
		String assistanceClass=StrUtil.n2b((String)pset.getParameter("assistanceClass"));
		if(StringUtils.isNotEmpty(assistanceClass)){
			querySql.append("   AND B.ASSISTANCE_CLASS =?                 \n");
			typeList.add(Types.VARCHAR);
			argsList.add(assistanceClass);
		}

		String cardNo=StrUtil.n2b((String)pset.getParameter("cardNo"));
		if(StringUtils.isNotEmpty(cardNo)){
			querySql.append("   AND A.CARD_NO  =?                         \n");
			typeList.add(Types.VARCHAR);
			argsList.add(cardNo);
		}
		
		String supportWay=StrUtil.n2b((String)pset.getParameter("supportWay"));
		if(StringUtils.isNotEmpty(supportWay)){
			querySql.append("   AND A.SUPPORT_WAY  =?                         \n");
			typeList.add(Types.VARCHAR);
			argsList.add(supportWay);
		}
		
		String gerocomiumName=StrUtil.n2b((String)pset.getParameter("gerocomiumName"));
		if(StringUtils.isNotEmpty(gerocomiumName)){
			querySql.append("   AND A.SUPPORT_ORG  =?                         \n");
			typeList.add(Types.VARCHAR);
			argsList.add(gerocomiumName);
		}
		
		
		String ePeopleNum=StrUtil.n2b((String)pset.getParameter("ePeopleNum"));
		if(StringUtils.isNotEmpty(ePeopleNum)){
			querySql.append("   AND B.PEOPLE_NUM <= ?                     \n");
			typeList.add(Types.DECIMAL);
			argsList.add(ePeopleNum);
		}
		
		String eAssitancePeopleNum=StrUtil.n2b((String)pset.getParameter("eAssitancePeopleNum"));
		if(StringUtils.isNotEmpty(eAssitancePeopleNum)){
			querySql.append("   AND B.ASSISTANCE_PEOPLE_NUM <= ?                     \n");
			typeList.add(Types.DECIMAL);
			argsList.add(eAssitancePeopleNum);
		}
		
		String familyCardNo=StrUtil.n2b((String)pset.getParameter("familyCardNo"));
		if(StringUtils.isNotEmpty(familyCardNo)){
			querySql.append("   AND B.FAMILY_CARD_NO = ?                  \n");
			typeList.add(Types.VARCHAR);
			argsList.add(familyCardNo);
		}
		String assistanceMoneyStart=StrUtil.n2b((String)pset.getParameter("assistanceMoneyStart"));
		if(StringUtils.isNotEmpty(assistanceMoneyStart)){
			querySql.append("   AND A.ASSISTANCE_MONEY >= ?               \n");
			typeList.add(Types.DECIMAL);
			argsList.add(assistanceMoneyStart);
		}
		String assistanceMoneyEnd=StrUtil.n2b((String)pset.getParameter("assistanceMoneyEnd"));
		if(StringUtils.isNotEmpty(assistanceMoneyEnd)){
			querySql.append("   AND A.ASSISTANCE_MONEY <= ?               \n");
			typeList.add(Types.DECIMAL);
			argsList.add(assistanceMoneyEnd);
		}
		String assistancePeopleNum=StrUtil.n2b((String)pset.getParameter("assistancePeopleNum"));
		if(StringUtils.isNotEmpty(assistancePeopleNum)){
			querySql.append("   AND B.ASSISTANCE_NUM = ?                  \n");
			typeList.add(Types.DECIMAL);
			argsList.add(assistancePeopleNum);
		}
		//数据源
		String dataSource=StrUtil.n2b((String)pset.getParameter("dataSource"));
		if(StringUtils.isNotEmpty(dataSource)){
			querySql.append("   AND A.DATA_SOURCE in (                 \n");
			String[] ary = dataSource.split(",");
			for (int i = 0; i < ary.length; i++) {
				querySql.append(" ? ");
				if(i!=ary.length-1){
					querySql.append(" , ");
				}
				typeList.add(Types.VARCHAR);
				argsList.add(ary[i]);
			}
			querySql.append(" ) ");
		}
		
		String familyType=StrUtil.n2b((String)pset.getParameter("familyType"));
		if (StringUtils.isNotEmpty(familyType)) {
			querySql.append("   AND EXISTS (SELECT FAMILY_ID \n");
			querySql.append("				  FROM SAM_FAMILY_ASSISTANCE D \n");
			querySql.append("				 WHERE A.FAMILY_ID = D.FAMILY_ID \n");
			querySql.append("				   AND D.ASSISTANCE_TYPE IN( ");
			String[] ary = familyType.split(",");
			for (int i = 0; i < ary.length; i++) {
				querySql.append(" ? ");
				if(i!=ary.length-1){
					querySql.append(" , ");
				}
				typeList.add(Types.VARCHAR);
				argsList.add(ary[i]);
			}
			querySql.append(" )) ");
		}
		String releaseId=StrUtil.n2b((String)pset.getParameter("releaseId"));
		if(!"".equals(releaseId)){
			querySql.append("   and not exists              \n");
			querySql.append("       (                       \n");
			querySql.append("          select family_id from sam_release_detail d where a.family_id=d.family_id and release_id=?  \n");
		    querySql.append("       )   \n");
		    typeList.add(Types.VARCHAR);
			argsList.add(releaseId);
		}
		
		querySql.append(" order by A.DOMICILE_CODE,B.FAMILY_ID ");
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		}
		Object[] args = argsList.toArray(new Object[argsList.size()]);
		return executeDataset(querySql.toString(), types, args, getDsStart(pset), getDsLimit(pset), true);
	}

	public DataSet querySamFamily(ParameterSet pset) {
		// TODO Auto-generated method stub
		return null;
	}

	/**
	 * @Title: querySamBankList 
	 * @Description: TODO(银行账户维护列表查询) 
	 * @author wangziming
	 */
	public DataSet querySamBankList(ParameterSet pset) {
		StringBuffer querySql = new StringBuffer();
		List<Object> typeList = new ArrayList<Object>();
		List<Object> argsList = new ArrayList<Object>();

		String assistanceType=StrUtil.n2b((String)pset.getParameter("assistanceType"));
		String domicileCode=StrUtil.n2b((String)pset.getParameter("domicileCode"));
		String familyName=StrUtil.n2b((String)pset.getParameter("familyName"));
		String familyCardNo=StrUtil.n2b((String)pset.getParameter("familyCardNo"));
		String bankStatus=StrUtil.n2b((String)pset.getParameter("bankStatus"));	
		//argsList.add(pset.getParameter("queryDate"));
		//argsList.add(pset.getParameter("queryDate"));
		//typeList.add(Types.VARCHAR);
		//typeList.add(Types.VARCHAR);

		querySql.append("SELECT B.FAMILY_ID, ");
		querySql.append("       A.CARD_NO, ");
		querySql.append("       A.BEGIN_DATE, ");
		querySql.append("       A.END_DATE, ");
		querySql.append("       B.FAMILY_CARD_NO, ");
		querySql.append("       B.FAMILY_NAME, ");
		querySql.append("       GET_CITY_NAME(B.TOWN) AS TOWN, ");
		querySql.append("       GET_CITY_NAME(B.VILLAGE) AS VILLAGE, ");
		querySql.append("       GET_BANK_NAME(S.BANK) AS BANK, ");
		querySql.append("       S.ACCOUNT_STATUS, ");
		querySql.append("       S.ACCOUNT_NAME, ");
		querySql.append("       S.ACCOUNT_NUMBER, ");
		querySql.append("		B.DOMICILE_NAME, ");
		querySql.append("		A.ASSISTANCE_TYPE ");
		querySql.append("  FROM SAM_FAMILY_TREATMENT A ");
		querySql.append("  LEFT JOIN BASEINFO_FAMILY B ON A.FAMILY_ID = B.FAMILY_ID");
		querySql.append("  LEFT JOIN SAM_BANK_ACCOUNT S ON S.FAMILY_ID = A.FAMILY_ID");
		querySql.append(" WHERE   A.END_DATE = '3000-12' ");

		if(StringUtils.isNotEmpty(familyName)){
			querySql.append("   AND B.FAMILY_NAME = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(familyName);
		}

		if(StringUtils.isNotEmpty(familyCardNo)){
			querySql.append("   AND B.FAMILY_CARD_NO = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(familyCardNo);
		}

		if(StringUtils.isNotEmpty(domicileCode)){
			querySql.append("   AND B.DOMICILE_CODE like ? ");
			typeList.add(Types.VARCHAR);
			if(domicileCode.indexOf("000")!=-1){
				argsList.add(getAreaCodeLikePrefix(domicileCode)+"%");
			}else {
				argsList.add(domicileCode+"%");
			}
		}

		if(StringUtils.isNotEmpty(assistanceType)){
			querySql.append("	AND A.ASSISTANCE_TYPE = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(assistanceType);
		}
		if(StringUtils.isNotEmpty(bankStatus)){
			querySql.append("	AND S.ACCOUNT_STATUS = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(bankStatus);
		}
		querySql.append("	order by A.BEGIN_DATE,A.FAMILY_ID  DESC");
		
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		}
		Object[] args = argsList.toArray(new Object[argsList.size()]);
		return executeDataset(querySql.toString(), types, args, pset.getPageStart(), pset.getPageLimit(), true);
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
	/**
	 * 调用存储过程把记录保存到备用表中
	 */
	public void procSamFamily(BaseinfoFamily baseinfoFamily) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("procedureName", "SAM_ARCHIVE");
		map.put("parameterNum",	2);
		map.put("parameterName_1", "applyId");
		map.put("parameterName_2", "familyId");
		map.put("parameterValue_1", baseinfoFamily.getSamFamilyTreatment().getApplyId());
		map.put("parameterValue_2", baseinfoFamily.getFamilyId());
		map.put("NumberOfResultSet",0);
		new ProceduresUtil().init(getDataSource(),map).call(map);
	}


	/**
	* @Title: querySamFamilyList
	* @Description: TODO(家庭信息列表查询，专项救助列表查询使用)
	* @param pset
	* @return DataSet  
	* @throws
	* @author luguosui
	 */
	public Record insertFamilyFromEnsurey(ParameterSet set) {
		StringBuffer sql=new StringBuffer();
		sql.append(" select FAMILY_NAME,FAMILY_CARD_TYPE,FAMILY_CARD_NO,PEOPLE_NUM,FAMILY_ADDRESS AS VILLAGE,FAMILY_ADDRESS AS DOMICILE_CODE, ");
		sql.append(" ADDRESS,FAMILY_POSTCODE,FAMILY_PHONE,FAMILY_MOBILE,FAMILY_OTHER_PHONE,YEAR_INCOME,YEAR_AVERAGE_INCOME,MONTH_INCOME, ");
		sql.append(" MONTH_AVERAGE_INCOME,HOUSE_STATUS,BUILD_AREA,BUILD_AVERAGE_AREA,BUILDING_STRUCTURE,NOTE ");
		sql.append(" from sam_esurey_family ");
		String familyId=(String)set.getParameter("familyId");
		String baseinfoFamilyId=(String)set.getParameter("baseinfoFamilyId");
		sql.append(" where family_ID=? ");
		DataSet ds=executeDataset(sql.toString(), new int[]{Types.VARCHAR}, new Object[]{familyId}, true);
		if (ds.getCount()>0) {
			Record record=ds.getRecord(0);
			BaseinfoFamily dataBean=(BaseinfoFamily)RecordToBeanUtil.recordToBeanUtil(record, BaseinfoFamily.class);
			dataBean.setAddress((String)set.getParameter("address"));
			dataBean.setDomicileCode((String)set.getParameter("domicileCode"));
			dataBean.setDomicileName((String)set.getParameter("domicileName"));
			dataBean.setFamilyId(baseinfoFamilyId);
			this.insert(dataBean);
			return record;
		}
		return null;
		
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
	public DataSet queryBaseChange(ParameterSet pset){
		String domicileCode=(String)pset.getParameter("domicileCode");
		String startMonth=(String)pset.getParameter("startMonth");
		String endMonth=(String)pset.getParameter("endMonth");
		String assistanceType=(String)pset.getParameter("assistanceType");
		String changeItem=(String)pset.getParameter("changeItem");
		
		StringBuffer querySql=new StringBuffer();
		List<Object> typeList = new ArrayList<Object>();
		List<Object> argsList = new ArrayList<Object>();
		
		querySql.append("SELECT A.TREATMENT_ID,                           \n");
		querySql.append("       A.SUPPORT_WAY,                            \n");
		querySql.append("       A.SUPPORT_ORG,                            \n");
		querySql.append("       B.FAMILY_ID,                              \n");
		querySql.append("       A.APPLY_ID,                               \n");
		querySql.append("       A.CARD_NO,                                \n");
		querySql.append("       A.BEGIN_DATE,                             \n");
		querySql.append("       A.END_DATE,                               \n");
		querySql.append("       B.DOMICILE_NAME,                          \n");
		querySql.append("       B.FAMILY_CARD_NO,                         \n");
		querySql.append("       B.FAMILY_NAME,                            \n");
		querySql.append("       B.PEOPLE_NUM,                             \n");
		querySql.append("       B.ASSISTANCE_PEOPLE_NUM,                  \n");
		querySql.append("       B.BELONGING,                              \n");
		querySql.append("       B.YEAR_AVERAGE_INCOME,                    \n");
		querySql.append("       B.MONTH_AVERAGE_INCOME,                   \n");
		querySql.append("       A.ASSISTANCE_MONEY,                       \n");
		querySql.append("       A.ASSISTANCE_MODE,                       \n");
		querySql.append("       B.ASSISTANCE_CLASS,                       \n");
		querySql.append("       B.ADDRESS,                                \n");
		querySql.append("       A.ASSISTANCE_CLASS_MONEY,                 \n");
		querySql.append("       A.ASSISTANCE_TYPE,                        \n");
		querySql.append("       GET_CITY_NAME(B.TOWN) AS TOWN,            \n");
		querySql.append("       GET_CITY_NAME(B.VILLAGE) AS VILLAGE,      \n");
		querySql.append("       B.POVERTY_CAUSE,                          \n");
		querySql.append("       B.APANAGE_CODE                            \n");
		querySql.append("  FROM SAM_FAMILY_TREATMENT A,BASEINFO_FAMILY_ARCHIVE B \n");
		querySql.append(" WHERE A.FAMILY_ID = B.FAMILY_ID                 \n");
		querySql.append("	AND A.APPLY_ID = B.APPLY_ID                   \n");
		querySql.append("   and A.assistance_type= ?                      \n");
		querySql.append("   AND A.DOMICILE_CODE LIKE ?                    \n");
		typeList.add(Types.VARCHAR);
		argsList.add(assistanceType);
		typeList.add(Types.VARCHAR);
		if(domicileCode.indexOf("000")>-1){
	   		argsList.add(getAreaCodeLikePrefix(domicileCode)+"%");
	    }else {
	   		argsList.add(domicileCode+"%");
		}
		
		if("new".endsWith(changeItem)){//新增申请
			querySql.append("   AND A.change_item is null                     \n");
			typeList.add(Types.VARCHAR);
			querySql.append(" and  A.begin_date between ?  \n");
			argsList.add(startMonth);
			querySql.append(" and  ?  \n");
			argsList.add(endMonth);
			typeList.add(Types.VARCHAR);
	    }else if("03".endsWith(changeItem)){//停保
	    	querySql.append("   AND A.change_item = ?                    \n");
	    	typeList.add(Types.VARCHAR);
	   		argsList.add(changeItem);
	    	typeList.add(Types.VARCHAR);
	    	querySql.append(" and  A.end_date between ?  \n");
			argsList.add( startMonth );
			querySql.append(" and  ?  \n");
			argsList.add( endMonth );
			typeList.add(Types.VARCHAR);
	    }else {
	    	if("01".endsWith(changeItem)){//add
	    		querySql.append("   AND A.difference  > 0                    \n");
	    	}else if("02".endsWith(changeItem)){//low
	    		querySql.append("   AND A.difference  < 0                    \n");
	    	}
			querySql.append(" and  A.begin_date between ?  \n");
			argsList.add(startMonth);
			typeList.add(Types.VARCHAR);
			querySql.append(" and  ?  \n");
			argsList.add(endMonth);
			typeList.add(Types.VARCHAR);
		}
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		}
		Object[] args = argsList.toArray(new Object[argsList.size()]);
		return executeDataset(querySql.toString(), types, args,getDsStart(pset), getDsLimit(pset),  true);
	}
	//获取特定月份上个月份
	public String getLastMonth(String currentMonth){
		SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM");
		 Date date=null;
		try {
			date = formatDate.parse(currentMonth);
			Calendar cal=Calendar.getInstance();
			cal.setTime(date);
			cal.set(Calendar.MONTH,cal.get(Calendar.MONTH)-1); 
			return formatDate.format(cal.getTime());
		} catch (Exception e) {
			e.printStackTrace();
			return currentMonth;
		}
	}
	
	
	public DataSet querySamFamilyListForRecheck(ParameterSet pset){
		// TODO Auto-generated method stub
				StringBuffer querySql = new StringBuffer();
				List<Object> typeList = new ArrayList<Object>();
				typeList.add(Types.VARCHAR);
				typeList.add(Types.VARCHAR);
				typeList.add(Types.VARCHAR);
				typeList.add(Types.VARCHAR);
				List<Object> argsList = new ArrayList<Object>();
				argsList.add(pset.getParameter("queryDate"));
				argsList.add(pset.getParameter("queryDate"));
				String domicileCode=StrUtil.n2b((String)pset.getParameter("domicileCode"));
				if(domicileCode.indexOf("000")!=-1){
					argsList.add(getAreaCodeLikePrefix(domicileCode)+"%");
				}else {
					argsList.add(domicileCode+"%");
				}
//				querySql.append("SELECT *");
				querySql.append("SELECT A.TREATMENT_ID,                           \n");
				querySql.append("       A.SUPPORT_WAY,                            \n");
				querySql.append("       A.SUPPORT_ORG,                            \n");
				querySql.append("       B.FAMILY_ID,                              \n");
				querySql.append("       B.FAMILY_ARCHIVE_ID,                              \n");
				querySql.append("       A.APPLY_ID,                               \n");
				querySql.append("       A.CARD_NO,                                \n");
				querySql.append("       A.BEGIN_DATE,                             \n");
				querySql.append("       A.END_DATE,                               \n");
				querySql.append("       B.DOMICILE_NAME,                          \n");
				querySql.append("       B.FAMILY_CARD_NO,                         \n");
				querySql.append("       B.FAMILY_NAME,                            \n");
				querySql.append("       B.PEOPLE_NUM,                             \n");
				querySql.append("       B.ASSISTANCE_PEOPLE_NUM,                  \n");
				querySql.append("       B.BELONGING,                              \n");
				querySql.append("       B.YEAR_AVERAGE_INCOME,                    \n");
				querySql.append("       B.MONTH_AVERAGE_INCOME,                   \n");
				querySql.append("       A.ASSISTANCE_MONEY,                       \n");
				querySql.append("       A.ASSISTANCE_MODE,                       \n");
				querySql.append("       B.ASSISTANCE_CLASS,                       \n");
				querySql.append("       B.ADDRESS,                                \n");
				
				querySql.append("       B.FAMILY_MOBILE,                                \n");
				
				querySql.append("       A.ASSISTANCE_CLASS_MONEY,                 \n");
				querySql.append("       A.ASSISTANCE_TYPE,                        \n");
				querySql.append("       B.POVERTY_CAUSE,                          \n");
				querySql.append("       B.APANAGE_CODE,                          \n");
				querySql.append("       B.DOMICILE_FULL_NAME,                       \n");
				
				querySql.append("       B.RECHECK_TIME,floor(sysdate-to_date(B.RECHECK_TIME,'yyyy-MM-dd')) as RECHECK_DAYS ,                      \n");
				
				querySql.append("       B.RECHECK_PEOPLE_NAME,                       \n");
				querySql.append("       B.RECHECK_PEOPLE_ID,                       \n");
				querySql.append("       B.RECHECK_ORGAN_NAME,                       \n");
				querySql.append("       B.RECHECK_ORGAN_ID,                       \n");
				querySql.append("       B.RECHECK_RESULT,                        \n");
				querySql.append("       C.ENSURE_ID,                                      \n");
				querySql.append("       C.ENSURE_UNIT,                                      \n");
				querySql.append("       C.FEEDBACK_TIME,                                      \n");
				querySql.append("       C.FEEDBACK_RESULT,                                    \n");
				querySql.append("       C.CURRENT_STATUS                                   \n");

				querySql.append("  FROM SAM_FAMILY_TREATMENT A,BASEINFO_FAMILY_ARCHIVE B,ENSURE_TO_CLIENT C \n");
						
				querySql.append(" WHERE A.FAMILY_ID = B.FAMILY_ID \n");
				querySql.append("	AND A.APPLY_ID = B.APPLY_ID                   \n");
				querySql.append("	AND A.APPLY_ID = C.APPLY_ID     AND C.READ_STATUS='1'           \n");
				querySql.append("   AND A.BEGIN_DATE <= ?                         \n");
				querySql.append("   AND A.END_DATE >= ?                           \n");
				querySql.append("   AND A.DOMICILE_CODE LIKE ?                    \n");
				querySql.append("   AND A.FAMILY_ID NOT IN (SELECT FAMILY_ID FROM SAM_APPLY_INFO WHERE is_finish !='1' and apply_type=?)");
				
				String applyType=StrUtil.n2b((String)pset.getParameter("applyType"));
				argsList.add(applyType);
				
				
				
				//是否疑似
				String isSuspect=StrUtil.n2b((String)pset.getParameter("isSuspect"));
				if(StringUtils.isNotEmpty(isSuspect)){
					querySql.append("   AND C.CURRENT_STATUS = ?                       \n");
					typeList.add(Types.VARCHAR);
					argsList.add(isSuspect);
				}
				
				String familyId=StrUtil.n2b((String)pset.getParameter("familyId"));
				if(StringUtils.isNotEmpty(familyId)){
					querySql.append("   AND A.FAMILY_ID = ?                       \n");
					typeList.add(Types.VARCHAR);
					argsList.add(familyId);
				}
			
				
				String applyId=StrUtil.n2b((String)pset.getParameter("applyId"));
				if(StringUtils.isNotEmpty(applyId)){
					querySql.append("   AND A.APPLY_ID = ?                       \n");
					typeList.add(Types.VARCHAR);
					argsList.add(applyId);
				}
				
				
				String assistanceType=StrUtil.n2b((String)pset.getParameter("assistanceType"));
				if(StringUtils.isNotEmpty(assistanceType)){
					querySql.append("   AND A.ASSISTANCE_TYPE = ?                 \n");
					typeList.add(Types.VARCHAR);
					argsList.add(assistanceType);
				}
				String familyName=StrUtil.n2b((String)pset.getParameter("familyName"));
				if(StringUtils.isNotEmpty(familyName)){
					querySql.append("   AND B.FAMILY_NAME like ?                     \n");
					typeList.add(Types.VARCHAR);
					argsList.add("%"+familyName+"%");
				}

				String sPeopleNum=StrUtil.n2b((String)pset.getParameter("sPeopleNum"));
				if(StringUtils.isNotEmpty(sPeopleNum)){
					querySql.append("   AND B.PEOPLE_NUM > =?                     \n");
					typeList.add(Types.DECIMAL);
					argsList.add(sPeopleNum);
				}
				
				String sAssitancePeopleNum=StrUtil.n2b((String)pset.getParameter("sAssitancePeopleNum"));
				if(StringUtils.isNotEmpty(sAssitancePeopleNum)){
					querySql.append("   AND B.ASSISTANCE_PEOPLE_NUM > =?                     \n");
					typeList.add(Types.DECIMAL);
					argsList.add(sAssitancePeopleNum);
				}
				
				String povertyCause=StrUtil.n2b((String)pset.getParameter("povertyCause"));
				if(StringUtils.isNotEmpty(povertyCause)){
					querySql.append("   AND B.POVERTY_CAUSE =?                    \n");
					typeList.add(Types.VARCHAR);
					argsList.add(povertyCause);
				}
				
				String assistanceClass=StrUtil.n2b((String)pset.getParameter("assistanceClass"));
				if(StringUtils.isNotEmpty(assistanceClass)){
					querySql.append("   AND B.ASSISTANCE_CLASS =?                 \n");
					typeList.add(Types.VARCHAR);
					argsList.add(assistanceClass);
				}

				String cardNo=StrUtil.n2b((String)pset.getParameter("cardNo"));
				if(StringUtils.isNotEmpty(cardNo)){
					querySql.append("   AND A.CARD_NO  =?                         \n");
					typeList.add(Types.VARCHAR);
					argsList.add(cardNo);
				}
				
				String supportWay=StrUtil.n2b((String)pset.getParameter("supportWay"));
				if(StringUtils.isNotEmpty(supportWay)){
					querySql.append("   AND A.SUPPORT_WAY  =?                         \n");
					typeList.add(Types.VARCHAR);
					argsList.add(supportWay);
				}
		    		String gerocomiumName = StrUtil.n2b((String)pset.getParameter("gerocomiumName"));
		    		if (StringUtils.isNotEmpty(gerocomiumName)) {
		      			querySql.append("   AND A.SUPPORT_ORG  =?                         \n");
		      			typeList.add(Integer.valueOf(12));
		      			argsList.add(gerocomiumName);
		    		}
				String ePeopleNum=StrUtil.n2b((String)pset.getParameter("ePeopleNum"));
				if(StringUtils.isNotEmpty(ePeopleNum)){
					querySql.append("   AND B.PEOPLE_NUM <= ?                     \n");
					typeList.add(Types.DECIMAL);
					argsList.add(ePeopleNum);
				}
				
				String eAssitancePeopleNum=StrUtil.n2b((String)pset.getParameter("eAssitancePeopleNum"));
				if(StringUtils.isNotEmpty(eAssitancePeopleNum)){
					querySql.append("   AND B.ASSISTANCE_PEOPLE_NUM <= ?                     \n");
					typeList.add(Types.DECIMAL);
					argsList.add(eAssitancePeopleNum);
				}
				
				String familyCardNo=StrUtil.n2b((String)pset.getParameter("familyCardNo"));
				if(StringUtils.isNotEmpty(familyCardNo)){
					querySql.append("   AND B.FAMILY_CARD_NO = ?                  \n");
					typeList.add(Types.VARCHAR);
					argsList.add(familyCardNo);
				}
				String assistanceMoneyStart=StrUtil.n2b((String)pset.getParameter("assistanceMoneyStart"));
				if(StringUtils.isNotEmpty(assistanceMoneyStart)){
					querySql.append("   AND A.ASSISTANCE_MONEY >= ?               \n");
					typeList.add(Types.DECIMAL);
					argsList.add(assistanceMoneyStart);
				}
				String assistanceMoneyEnd=StrUtil.n2b((String)pset.getParameter("assistanceMoneyEnd"));
				if(StringUtils.isNotEmpty(assistanceMoneyEnd)){
					querySql.append("   AND A.ASSISTANCE_MONEY <= ?               \n");
					typeList.add(Types.DECIMAL);
					argsList.add(assistanceMoneyEnd);
				}
				String assistancePeopleNum=StrUtil.n2b((String)pset.getParameter("assistancePeopleNum"));
				if(StringUtils.isNotEmpty(assistancePeopleNum)){
					querySql.append("   AND B.ASSISTANCE_NUM = ?                  \n");
					typeList.add(Types.DECIMAL);
					argsList.add(assistancePeopleNum);
				}
				//数据源
				String dataSource=StrUtil.n2b((String)pset.getParameter("dataSource"));
				if(StringUtils.isNotEmpty(dataSource)){
					querySql.append("   AND A.DATA_SOURCE in (                 \n");
					String[] ary = dataSource.split(",");
					for (int i = 0; i < ary.length; i++) {
						querySql.append(" ? ");
						if(i!=ary.length-1){
							querySql.append(" , ");
						}
						typeList.add(Types.VARCHAR);
						argsList.add(ary[i]);
					}
					querySql.append(" ) ");
				}
				
				String familyType=StrUtil.n2b((String)pset.getParameter("familyType"));
				if (StringUtils.isNotEmpty(familyType)) {
					querySql.append("   AND EXISTS (SELECT FAMILY_ID \n");
					querySql.append("				  FROM SAM_FAMILY_ASSISTANCE D \n");
					querySql.append("				 WHERE A.FAMILY_ID = D.FAMILY_ID \n");
					querySql.append("				   AND D.ASSISTANCE_TYPE IN( ");
					String[] ary = familyType.split(",");
					for (int i = 0; i < ary.length; i++) {
						querySql.append(" ? ");
						if(i!=ary.length-1){
							querySql.append(" , ");
						}
						typeList.add(Types.VARCHAR);
						argsList.add(ary[i]);
					}
					querySql.append(" )) ");
				}
				String releaseId=StrUtil.n2b((String)pset.getParameter("releaseId"));
				if(!"".equals(releaseId)){
					querySql.append("   and not exists              \n");
					querySql.append("       (                       \n");
					querySql.append("          select family_id from sam_release_detail d where a.family_id=d.family_id and release_id=?  \n");
				    querySql.append("       )   \n");
				    typeList.add(Types.VARCHAR);
					argsList.add(releaseId);
				}
				String sage = StrUtil.n2b((String)pset.getParameter("sAge"));
				String eage = StrUtil.n2b((String)pset.getParameter("eAge"));
				if(!("".equals(sage)&&"".equals(eage))){
					if("".equals(sage)){
						sage="9999-99-99";
					}
					if("".equals(eage)){
						eage="0000-00-00";
					}
					querySql.append(" AND B.family_archive_id in (select p.family_archive_id from baseInfo_people_ARCHIVE p,sam_people_extend_ARCHIVE e " +
							"where p.people_Id= e.people_id and e.is_assistance='1' " +
							"and  p.birthday<'"+sage+"' and p.birthday>'"+eage+"')");
					
				}
				
				
				//querySql.append(" order by A.DOMICILE_CODE,B.FAMILY_ID ");
				querySql.append(" order by B.recheck_time,A.DOMICILE_CODE ");
				int[] types = new int[typeList.size()];
				for (int i = 0; i < typeList.size(); i++) {
					types[i] = (Integer) (typeList.get(i));
				}
				Object[] args = argsList.toArray(new Object[argsList.size()]);
				return executeDataset(querySql.toString(), types, args, getDsStart(pset), getDsLimit(pset), true);
	}
	
}
