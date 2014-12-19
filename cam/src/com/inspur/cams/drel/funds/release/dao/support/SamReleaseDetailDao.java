package com.inspur.cams.drel.funds.release.dao.support;

import java.math.BigDecimal;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.persistent.jdbc.core.SqlParameter;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.ExportExcelPageUtil;
import com.inspur.cams.comm.util.ProceduresUtil;
import com.inspur.cams.comm.util.RecordToBeanUtil;
import com.inspur.cams.comm.util.StrUtil;
import com.inspur.cams.comm.util.ProceduresUtil.Proc;
import com.inspur.cams.drel.funds.release.dao.ISamReleaseDetailDao;
import com.inspur.cams.drel.funds.release.data.SamReleaseDetail;
import com.inspur.cams.drel.funds.release.data.SamReleaseSummary;

/**
 * @title:SamReleaseDetailDao
 * @description:
 * @author:
 * @since:2012-05-07
 * @version:1.0
*/
 public class SamReleaseDetailDao extends EntityDao<SamReleaseDetail> implements ISamReleaseDetailDao{
 
 	public SamReleaseDetailDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}
		 
  	@Override
	public Class getEntityClass() {
		return SamReleaseDetail.class;
	}
	
	public void deleteBySamReleaseSummary(String fkId) {
		executeUpdate("delete from  SAM_RELEASE_DETAIL where ='" + fkId + "'");
	}

	public void batchDeleteBySamReleaseSummary(String[] fkId) {
		String[] sql = new String[fkId.length];
		for (int i = 0; i < fkId.length; i++) {
			sql[i] = "delete from SAM_RELEASE_DETAIL where detail_id='" + fkId[i] + "'";
		}
		batchUpdate(sql);
	}
	/**
	* @Title: queryDetailByIfSpecial
	* @Description: TODO(资金发放、专项补贴列表查询)
	* @param pSet
	* @return DataSet  
	* @throws
	* @author luguosui
	 */
	public DataSet queryDetailByIfSpecial(ParameterSet pSet) {
		StringBuffer sql=new StringBuffer();
		List<Object> typeList = new ArrayList<Object>();
		List<Object> argsList = new ArrayList<Object>();
		sql.append(" SELECT D.*,get_cams_city_full_name(d.domicile_code) dic_full_name,S.release_Item ,t.card_no FROM SAM_RELEASE_DETAIL D   LEFT JOIN sam_family_treatment t  on d.apply_id = t.apply_id , SAM_RELEASE_SUMMARY  S  WHERE S.RELEASE_ID=D.RELEASE_ID    AND S.RELEASE_STATUS='02' ");
		String ifSpecial=(String)pSet.get("ifSpecial");
		String domicileCode=(String)pSet.get("domicileCode");
		String name=(String)pSet.get("name");
		String assistanceType=(String)pSet.get("assistanceType");
		String releaseType=(String)pSet.get("releaseType");
		String releaseDate=(String)pSet.get("releaseDate");
		String idCard=(String)pSet.get("idCard");
		String itemCode=(String)pSet.get("itemCode");
		if (StringUtils.isNotEmpty(releaseType)) {
			sql.append(" AND S.RELEASE_TYPE=? ");
			argsList.add(releaseType);
			typeList.add(Types.VARCHAR);
		}
		if (StringUtils.isNotEmpty(ifSpecial)) {
			sql.append(" AND S.IS_SPECIAL=? ");
			argsList.add(ifSpecial);
			typeList.add(Types.VARCHAR);
		}
		if (StringUtils.isNotEmpty(releaseDate)) {
			sql.append(" AND D.RELEASE_DATE=? ");
			argsList.add(releaseDate);
			typeList.add(Types.VARCHAR);
		}
		if (StringUtils.isNotEmpty(domicileCode)) {
			sql.append(" AND D.DOMICILE_CODE LIKE ? ");
			if(domicileCode.indexOf("000")>-1){
		   		argsList.add(getAreaCodeLikePrefix(domicileCode)+"%");
		    }else {
		   		argsList.add(domicileCode+"%");
			}
			typeList.add(Types.VARCHAR);
		}
		if (StringUtils.isNotEmpty(name)) {
			sql.append(" AND D.NAME=? ");
			argsList.add(name);
			typeList.add(Types.VARCHAR);
		}
		if (StringUtils.isNotEmpty(assistanceType)) {
			sql.append(" AND D.ASSISTANCE_TYPE=? ");
			argsList.add(assistanceType);
			typeList.add(Types.VARCHAR);
		}
		if (StringUtils.isNotEmpty(idCard)) {
			sql.append(" AND D.ID_CARD=? ");
			argsList.add(idCard);
			typeList.add(Types.VARCHAR);
		}
		if (StringUtils.isNotEmpty(itemCode)) {
			sql.append(" AND S.release_Item=? ");
			argsList.add(itemCode);
			typeList.add(Types.VARCHAR);
		}
		
		sql.append(" ORDER BY D.DOMICILE_CODE ");
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		}
		Object[] args = argsList.toArray(new Object[argsList.size()]);
		
		return RecordToBeanUtil.uppercaseToLowercase(executeDataset(sql.toString(), types, args, getDsStart(pSet), getDsLimit(pSet), true));
	}
	public void confirm(String releaseId, String status) {
		executeUpdate("update sam_release_detail set release_status='"+status+"' where release_id='"+releaseId+"'");
	}

	/**
	 * @Title: deleteBySQL
	 * @Description: TODO(删除专项救助)
	 * @param set
	 *            void
	 * @throws
	 * @author luguosui
	 */
	public void deleteBySQL(ParameterSet set) {
		StringBuffer sql=new StringBuffer();
		List<Integer> typeList = new ArrayList<Integer>();
		List<String> objsList = new ArrayList<String>();
		String delIds=(String)set.getParameter("delIds");
		if(StringUtils.isNotEmpty(delIds)){
		sql.append(" delete SAM_RELEASE_DETAIL S where 1=1");
			   	sql.append(" AND S.RELEASE_ID IN (");
				String[] ary = delIds.split(",");
				for (int i = 0; i < ary.length; i++) {
					sql.append(" ? ");
					if(i!=ary.length-1){
						sql.append(" , ");
					}
					typeList.add(Types.VARCHAR);
					objsList.add(ary[i]);
				}
				sql.append(" ) ");
		   }
		if (typeList.size() != 0 && objsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			Object[] args = objsList.toArray(new Object[objsList.size()]);
			this.executeUpdate(sql.toString(), types, args);
		} else {
			this.executeUpdate(sql.toString());
		}
	}

    /**
    * @Title: updateSamReleaseMsg
    * @Description: TODO(更新专项救助相关信息)
    * @param pSet void  
    * @throws
    * @author luguosui
     */
	public void updateSamReleaseMsg(ParameterSet pSet) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("procedureName", "SAM_EXECUTE_RELEASE_SUMMARY");
		map.put("parameterNum", 8);
		map.put("parameterName_1", "releaseId");
		map.put("parameterName_2", "assistanceType");
		map.put("parameterName_3", "releaseType");
		map.put("parameterName_4", "releaseWay");
		map.put("parameterName_5", "releaseDate");
		map.put("parameterName_6", "releaseAreaCode");
		map.put("parameterName_7", "familyIds");
		map.put("parameterName_8", "releaseTarget");
		map.put("NumberOfResultSet",0);
		Proc procduce = new ProceduresUtil().init(getDataSource(),map);
		DataSet set = new DataSet();
		String releaseId = (String) pSet.getParameter("releaseId");
		String assistanceType = (String) pSet.getParameter("assistanceType");
		String releaseDate = (String) pSet.getParameter("releaseDate");
		String releaseType = (String) pSet.getParameter("releaseType");
		String releaseWay = (String) pSet.getParameter("releaseWay");
		String releaseAreaCode = (String) pSet.getParameter("releaseAreaCode");
		String familyIds = (String) pSet.getParameter("familyIds");
		String releaseTarget = (String) pSet.getParameter("releaseTarget");
		map.put("parameterValue_1", releaseId);
		map.put("parameterValue_2", assistanceType);
		map.put("parameterValue_3", releaseType);
		map.put("parameterValue_4", releaseWay);
		map.put("parameterValue_5", releaseDate);
		map.put("parameterValue_6", releaseAreaCode);
		map.put("parameterValue_7", familyIds);
		map.put("parameterValue_8", releaseTarget);
		procduce.call(map).get("results");
	}

	/**
	* @Title: updateStatusByReleaseId
	* @Description: TODO(更新计划状态)
	* @param set void  
	* @throws
	* @author luguosui
	 */
	public void updateStatusByReleaseId(ParameterSet set) {
		String releaseId=(String)set.get("releaseId");
		if(StringUtils.isNotEmpty(releaseId)){
			StringBuffer sql=new StringBuffer();
			String releaseStatus=(String)set.get("releaseStatus");
			sql.append(" update SAM_RELEASE_DETAIL set RELEASE_STATUS=?,MOD_ID=?,MOD_TIME=? where RELEASE_ID=? ");
			this.executeUpdate(sql.toString(), new int[]{Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR}, new Object[]{releaseStatus,BspUtil.getEmpOrganId(),DateUtil.getTime(),releaseId});
		}
	}
	
	/**
	* @Title: insertAllReleaseDetail
	* @Description: TODO(专项救助符合调价的所有救助对象确定插入明细方法) void  
	* @param pSet
	* @throws
	* @author luguosui
	 */
	public void insertSamReleaseMsg(ParameterSet pSet) {
		String releaseId = (String) pSet.getParameter("releaseId");
		String assistanceBegin = (String) pSet.getParameter("assistanceBegin");
		String queryDate = (String) pSet.getParameter("queryDate");
		SamReleaseSummary samReleaseSummary=(SamReleaseSummary) pSet.getParameter("samReleaseSummary");
		String domicileCode = samReleaseSummary.getReleaseAreaCode();
		String releaseTarget = samReleaseSummary.getReleaseTarget();
		String reissueMonth=(String)pSet.getParameter("reissueMonth");
		StringBuffer sql=new StringBuffer();
		sql.append(" insert into sam_release_detail ");
		sql.append(" (detail_id, family_id,release_id, release_status,name,id_card,domicile_code,domicile_name,assistance_type,assistance_people_num,BASE_MON ,RELEASE_DATE,BELONGING) ");
		sql.append(" SELECT  ");
		sql.append("  sys_guid(),B.FAMILY_ID,  '").append(releaseId);
		sql.append("','01',B.FAMILY_NAME,B.FAMILY_CARD_NO, B.DOMICILE_CODE,B.DOMICILE_NAME, A.ASSISTANCE_TYPE,B.ASSISTANCE_PEOPLE_NUM ,'");
		if (StringUtils.isNotEmpty(reissueMonth)) {
			sql.append(samReleaseSummary.getReleaseStandard().multiply(new BigDecimal(reissueMonth))).append("','");
		}else {
			sql.append(samReleaseSummary.getReleaseStandard()).append("','");
		}
		sql.append(samReleaseSummary.getReleaseDate()).append("'").append(",B.BELONGING ");
		sql.append(" FROM SAM_FAMILY_TREATMENT A,BASEINFO_FAMILY_ARCHIVE B  WHERE A.FAMILY_ID = B.FAMILY_ID and a.apply_id=b.apply_id          ");
		sql.append("   AND A.BEGIN_DATE <='").append(queryDate).append("'");
		sql.append("   AND A.END_DATE >= '").append(queryDate).append("'");
		String assistanceType=StrUtil.n2b((String)pSet.getParameter("assistanceType"));
		if(StringUtils.isNotEmpty(assistanceType)){
			sql.append("   AND A.ASSISTANCE_TYPE ='").append(assistanceType).append("'");
		}
		String familyName=StrUtil.n2b((String)pSet.getParameter("familyName"));
		if(StringUtils.isNotEmpty(familyName)){
			sql.append("   AND B.FAMILY_NAME = '").append(familyName).append("'");
		}

		String sPeopleNum=StrUtil.n2b((String)pSet.getParameter("sPeopleNum"));
		if(StringUtils.isNotEmpty(sPeopleNum)){
			sql.append("   AND B.PEOPLE_NUM > ='").append(sPeopleNum).append("'");
		}


		String cardNo=StrUtil.n2b((String)pSet.getParameter("cardNo"));
		if(StringUtils.isNotEmpty(cardNo)){
			sql.append("   AND A.CARD_NO  ='").append(cardNo).append("'");
		}

		String ePeopleNum=StrUtil.n2b((String)pSet.getParameter("ePeopleNum"));
		if(StringUtils.isNotEmpty(ePeopleNum)){
			sql.append("   AND B.PEOPLE_NUM <= '").append(ePeopleNum).append("'");
		}
		String familyCardNo=StrUtil.n2b((String)pSet.getParameter("familyCardNo"));
		if(StringUtils.isNotEmpty(familyCardNo)){
			sql.append("   AND B.FAMILY_CARD_NO = '").append(familyCardNo).append("'");
		}
		String assistanceMoneyStart=StrUtil.n2b((String)pSet.getParameter("assistanceMoneyStart"));
		if(StringUtils.isNotEmpty(assistanceMoneyStart)){
			sql.append("   AND A.ASSISTANCE_MONEY >='").append(assistanceMoneyStart).append("'");
		}
		String assistanceMoneyEnd=StrUtil.n2b((String)pSet.getParameter("assistanceMoneyEnd"));
		if(StringUtils.isNotEmpty(assistanceMoneyEnd)){
			sql.append("   AND A.ASSISTANCE_MONEY <= '").append(assistanceMoneyEnd).append("'");
		}
		String assistancePeopleNum=StrUtil.n2b((String)pSet.getParameter("assistancePeopleNum"));
		if(StringUtils.isNotEmpty(assistancePeopleNum)){
			sql.append("   AND B.ASSISTANCE_NUM = '").append(assistancePeopleNum).append("'");
		}
		String sAssitancePeopleNum=StrUtil.n2b((String)pSet.getParameter("sAssitancePeopleNum"));
		if(StringUtils.isNotEmpty(sAssitancePeopleNum)){
			sql.append("   AND B.ASSISTANCE_NUM > ='").append(sAssitancePeopleNum).append("'");
		}
		String eAssitancePeopleNum=StrUtil.n2b((String)pSet.getParameter("eAssitancePeopleNum"));
		if(StringUtils.isNotEmpty(eAssitancePeopleNum)){
			sql.append("   AND B.ASSISTANCE_NUM <= '").append(eAssitancePeopleNum).append("'");
		}
		if(StringUtils.isNotEmpty(domicileCode)){
			if(domicileCode.indexOf("000")!=-1){
				sql.append("   AND B.DOMICILE_CODE like '").append(getAreaCodeLikePrefix(domicileCode)).append("%'");
			}else {
				sql.append("   AND B.DOMICILE_CODE like '").append(domicileCode).append("%'");
			}
		}
		sql.append("    and not exists (  ");
		sql.append("            select family_id from sam_release_detail where release_id='"+releaseId+"' ");
		sql.append("        )  ");

		Map<String,Object> map = new HashMap<String, Object>();
		map.put("procedureName", "SAM_INSERT_RELEASE_DETAIL");
		map.put("parameterNum", 3);
		map.put("parameterName_1", "releaseId");
		map.put("parameterName_2", "V_SQL");
		map.put("parameterName_3", "releaseTarget");
		map.put("NumberOfResultSet",0);
		Proc procduce = new ProceduresUtil().init(getDataSource(),map);
		map.put("parameterValue_1", releaseId);
		map.put("parameterValue_2", sql.toString());
		map.put("parameterValue_3", releaseTarget);
		procduce.call(map).get("results");
	}

	/**
	 * 
	* @Title: updateDetailAndSummary
	* @Description: TODO(调用存储过程更新汇总及明细信息)
	* @param set void  
	* @throws
	* @author luguosui
	 */
	public void updateDetailAndSummary(ParameterSet pSet) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("procedureName", "SAM_RELEASE_MAKE_UPDATE");
		map.put("parameterNum", 6);
		map.put("parameterName_1", "releaseId");
		map.put("parameterName_2", "assistanceType");
		map.put("parameterName_3", "releaseType");
		map.put("parameterName_4", "releaseWay");
		map.put("parameterName_5", "releaseDate");
		map.put("parameterName_6", "releaseAreaCode");
		map.put("NumberOfResultSet",0);
		Proc procduce = new ProceduresUtil().init(getDataSource(),map);
		DataSet set = new DataSet();
		String releaseId = (String) pSet.getParameter("releaseId");
		String assistanceType = (String) pSet.getParameter("assistanceType");
		String releaseDate = (String) pSet.getParameter("releaseDate");
		String releaseType = (String) pSet.getParameter("releaseType");
		String releaseWay = (String) pSet.getParameter("releaseWay");
		String releaseAreaCode = (String) pSet.getParameter("releaseAreaCode");
		String familyIds = (String) pSet.getParameter("familyIds");
		String releaseTarget = (String) pSet.getParameter("releaseTarget");
		map.put("parameterValue_1", releaseId);
		map.put("parameterValue_2", assistanceType);
		map.put("parameterValue_3", releaseType);
		map.put("parameterValue_4", releaseWay);
		map.put("parameterValue_5", releaseDate);
		map.put("parameterValue_6", releaseAreaCode);
		procduce.call(map).get("results");
	}

	/**
	* @Title: insertSamReleaseStat
	* @Description: TODO(资金发放统计生成对应的记录用于统计)
	* @param pSet void  
	* @throws
	* @author luguosui
	 */
	public void insertSamReleaseStat(ParameterSet pSet) {
		String releaseId=(String)pSet.getParameter("releaseId");
		String isSpecial=(String)pSet.getParameter("isSpecial");
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("procedureName", "SAM_RELEASE_STAT_MAKE");
		map.put("parameterNum", 2);
		map.put("parameterName_1", "releaseId");
		map.put("parameterName_2", "isSpecial");
		map.put("NumberOfResultSet",0);
		Proc procduce = new ProceduresUtil().init(getDataSource(),map);
		DataSet set = new DataSet();
		map.put("parameterValue_1", releaseId);
		map.put("parameterValue_2", isSpecial);
		procduce.call(map).get("results");
	}

	/**
	* @Title: queryAssistancePeo
	* @Description: TODO(报表下钻时查询保障人员信息)
	* @param pset
	* @return DataSet  
	* @throws
	* @author luguosui
	 */
	public DataSet queryAssistancePeo(ParameterSet pset) {
		StringBuffer sql=new StringBuffer();
		List<Integer> typeList = new ArrayList<Integer>();
		List<String> objsList = new ArrayList<String>();
		String beginDate=(String)pset.getParameter("beginDate");
		String endDate=(String)pset.getParameter("endDate");
		String assistanceType=(String)pset.getParameter("assistanceType");
		String belonging=(String)pset.getParameter("belonging");
		String domicileCode=(String)pset.getParameter("domicileCode");
		sql.append(" SELECT P.* FROM BASEINFO_PEOPLE_ARCHIVE P ,SAM_PEOPLE_EXTEND_ARCHIVE A WHERE  P.APPLY_ID IN");
		sql.append("(");
		sql.append(" select d.APPLY_ID from sam_release_detail d  where 1=1 ");
		if (StringUtils.isNotEmpty(beginDate)) {
			sql.append(" and d.release_date >= ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(beginDate);
		}
		if (StringUtils.isNotEmpty(endDate)) {
			sql.append(" and d.release_date <= ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(endDate);
		}
		if (StringUtils.isNotEmpty(assistanceType)) {
			sql.append(" and d.assistance_type = ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(assistanceType);
		}
		if (StringUtils.isNotEmpty(belonging)) {
			sql.append(" and d.belonging= ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(belonging);
		}
		if (StringUtils.isNotEmpty(domicileCode)) {
			sql.append("  and d.domicile_code like ? ");
			typeList.add(Types.VARCHAR);
			if(domicileCode.indexOf("0000000")>-1){
				objsList.add(domicileCode.substring(0,domicileCode.indexOf("000000"))+"%");
			}else if (domicileCode.indexOf("000")>-1) {
				objsList.add(domicileCode.substring(0,domicileCode.indexOf("000"))+"%");
				
			}else{
				objsList.add(domicileCode+"%");
			}
		}
		sql.append(")");	
		sql.append("  and a.apply_id=p.apply_id ");
		sql.append("  AND p.people_id=a.people_id ");
		sql.append(" AND A.IS_ASSISTANCE =? ");
		typeList.add(Types.VARCHAR);
		objsList.add("1");
		DataSet ds = new DataSet();
		if (typeList.size() != 0 && objsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			Object[] args = objsList.toArray(new Object[objsList.size()]);
			ds = this.executeDataset(sql.toString(), types, args, ExportExcelPageUtil.getDsStart(pset), ExportExcelPageUtil.getDsLimit(pset), true);
		} else {
			ds = this.executeDataset(sql.toString(), ExportExcelPageUtil.getDsStart(pset), ExportExcelPageUtil.getDsLimit(pset), true);
		}
		return ds;
		
	}

	/**
	* @Title: queryAllDetail
	* @Description: TODO(导出包括专项补贴的明细Excel查询方法)
	* @return DataSet  
	* @param pset void  
	* @throws
	* @author luguosui
	 */
	public DataSet queryAllDetail(ParameterSet pSet) {
		Map<String,Object> map = new HashMap<String, Object>();
		String domicileCode=(String)pSet.get("domicileCode");
		String name=(String)pSet.get("name");
		String assistanceType=(String)pSet.get("assistanceType");
		String releaseType=(String)pSet.get("releaseType");
		String releaseDate=(String)pSet.get("releaseDate");
		String idCard=(String)pSet.get("idCard");
		map.put("procedureName", "SAM_RELEASE_PRINT");
		map.put("parameterNum", 5);
		map.put("NumberOfResultSet",1);
		map.put("parameterName_1", "releaseDate");
		map.put("parameterName_2", "domicileCode");
		map.put("parameterName_3", "peoName");
		map.put("parameterName_4", "assistanceType");
		map.put("parameterName_5", "idCard");
		Proc procduce = new ProceduresUtil().init(getDataSource(),map);
		map.put("parameterValue_1", releaseDate);
		if(domicileCode.indexOf("000")!=-1){
			map.put("parameterValue_2", getAreaCodeLikePrefix(domicileCode)+"%");
		}else {
			map.put("parameterValue_2", domicileCode+"%");
		}
		map.put("parameterValue_3", name);
		map.put("parameterValue_4", assistanceType);
		map.put("parameterValue_5", idCard);
		DataSet set = new DataSet();
		List results = null;
		Object object = null;
		object = procduce.call(map).get("results");
		if (object instanceof ArrayList) {
			results = (List) object;
			for (Object o : results) {
				set.add((Record) o);
			}
		}
		ProceduresUtil.fixDataSet(set);
		return set;
	}
	
	/**
	* @Title: queryPeopleDetail
	* @Description: TODO(导出家庭成员明细的方法)
	* @return DataSet  
	* @param pset void  
	* @throws
	* @author sunlei
	 */
	public DataSet queryPeopleDetail(ParameterSet pSet) {
		StringBuffer sql=new StringBuffer();
		List<Integer> typeList = new ArrayList<Integer>();
		List<String> objsList = new ArrayList<String>();
		String name=(String)pSet.getParameter("name");
		String idCard=(String)pSet.getParameter("idCard");
		String qReleaseDate=(String)pSet.getParameter("qReleaseDate");
		String domicileCode=(String)pSet.getParameter("domicileCode");
		String assistanceType = (String)pSet.getParameter("assistanceType");
		sql.append(" select  t.domicile_name,p.name,p.id_card,p.sex,t.family_name,e.is_assistance,p.income_month,p.income_year, P.HEALTH_CODE,P.EDU_CODE,P.MARRIAGE_CODE  from baseinfo_family_archive   t,  baseinfo_people_archive   p, sam_people_extend_archive e where p.people_archive_id = e.people_archive_id(+) and t.family_archive_id = p.family_archive_id(+) and P.APPLY_ID IN ( ");
		sql.append(" SELECT A.APPLY_ID FROM SAM_RELEASE_DETAIL A WHERE  ");
		if(StringUtils.isNotEmpty(qReleaseDate)){
			sql.append("  A.RELEASE_DATE= ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(qReleaseDate);
		}
		if (StringUtils.isNotEmpty(name)) {
			sql.append(" and A.NAME= ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(name);
		}
		if (StringUtils.isNotEmpty(idCard)) {
			sql.append(" and A.ID_CARD = ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(idCard);
		}
		if (StringUtils.isNotEmpty(assistanceType)) {
			sql.append(" and A.ASSISTANCE_TYPE = ? ");
			typeList.add(Types.VARCHAR);
			objsList.add(assistanceType);
		}
		if (StringUtils.isNotEmpty(domicileCode)) {
			sql.append(" AND A.DOMICILE_CODE LIKE ? ");
			objsList.add(domicileCode+"%");
			typeList.add(Types.VARCHAR);
		}
		sql.append(" ) ");
		sql.append(" ORDER BY P.DOMICILE_CODE, P.FAMILY_ARCHIVE_ID, P.RELATIONSHIP_TYPE, P.ID_CARD desc ");
		DataSet ds = new DataSet();
		if (typeList.size() != 0 && objsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			//int start = pSet.getPageStart();
			int start=getDsStart(pSet);
			//int limit = pSet.getPageLimit();
			int limit =getDsLimit(pSet);
			Object[] args = objsList.toArray(new Object[objsList.size()]);
			
			System.out.println(sql.toString());
			
			ds= executeDataset(sql.toString(), types, args,start,limit,  true);
		}
		return ds;
	}
	/**
	 * @Title: getDsLimit 
	 * @Description: excel分页信息
	 * @author 
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
	 * @Description: excel分页信息
	 * @author 
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
}
