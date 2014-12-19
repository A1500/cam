package com.inspur.cams.jcm.dao.jdbc;

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

import com.inspur.cams.comm.util.StrUtil;
import com.inspur.cams.jcm.dao.IJcmCompanyProfileDao;
import com.inspur.cams.jcm.data.JcmCompanyProfile;
import com.inspur.comm.util.ProceduresUtil;
import com.inspur.comm.util.ProceduresUtil.Proc;

/**
 * 单位信息dao
 * @author 
 * @date 2014-05-16
 */
public class JcmCompanyProfileDao extends EntityDao<JcmCompanyProfile> implements IJcmCompanyProfileDao {
	
	@Override
	public Class<JcmCompanyProfile> getEntityClass() {
		return JcmCompanyProfile.class;
	}
	/**
	 * 查询用户信息
	 */
	public DataSet queryUserinfo(ParameterSet pset) {
		List<Object> typeList = new ArrayList<Object>();
		List<Object> argsList = new ArrayList<Object>();
		
		
		StringBuffer sql = new StringBuffer();
		sql.append("select t.user_id , c.* from JCM_USER_INFO t ,jcm_company_profile  c where t.company_id = c.company_id  and   c.ORGAN_CODE like ?\n");
		
		typeList.add(Types.VARCHAR);
		String organCode=StrUtil.n2b((String)pset.getParameter("organCode"));
		if(organCode.indexOf("000")!=-1){
			argsList.add(getAreaCodeLikePrefix(organCode)+"%");
		}else {
			argsList.add(organCode+"%");
		}
		String userId=StrUtil.n2b((String)pset.getParameter("userId"));
		if(StringUtils.isNotEmpty(userId)){
			sql.append(" AND t.USER_ID = ?                       \n");
			typeList.add(Types.VARCHAR);
			argsList.add(userId);
		}
		String companyName=StrUtil.n2b((String)pset.getParameter("companyName"));
		if(StringUtils.isNotEmpty(companyName)){
			sql.append(" AND c.company_name = ?                       \n");
			typeList.add(Types.VARCHAR);
			argsList.add(companyName);
		}
		String companyType=StrUtil.n2b((String)pset.getParameter("companyType"));
		if(StringUtils.isNotEmpty(companyType)){
			sql.append(" AND c.company_type = ?                       \n");
			typeList.add(Types.VARCHAR);
			argsList.add(companyType);
		}
		sql.append("   ORDER BY C.ORGAN_CODE \n");
		
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		}
		Object[] args = argsList.toArray(new Object[argsList.size()]);
		return executeDataset(querySql.toString(), types, args,getDsStart(pset), getDsLimit(pset),  true);
	}
	/**
	 * @Title: getDsStart 
	 * @Description: TODO(excel分页信息A) 
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
	 * @Description: TODO(excel分页信息B) 
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
	public DataSet queryCompany(ParameterSet pset) {
		String companyName = (String)pset.getParameter("companyName");
		String organCode = (String)pset.getParameter("organCode");
		String companyNature = (String)pset.getParameter("companyNature");
		String companyPeopleName = (String)pset.getParameter("companyPeopleName");
		String companyNo = (String)pset.getParameter("companyNo");
		String companyBorgName = (String)pset.getParameter("companyBorgName");
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objList = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer();
		sql.append("select * from JCM_COMPANY_PROFILE D WHERE 1=1 ");
//		if (StringUtils.isNotEmpty(organCode)) {
//			sql.append(" AND D.ORGAN_CODE = ?  ");
//			objList.add(organCode);
//			typeList.add(Types.VARCHAR);
//		}
		if (StringUtils.isNotEmpty(companyName)) {
			sql.append(" AND D.COMPANY_NAME LIKE ?  ");
			objList.add(companyName);
			typeList.add(Types.VARCHAR);
		}
		if (StringUtils.isNotEmpty(companyNature)) {
			sql.append(" and D.COMPANY_NATURE = ?  ");
			objList.add(companyNature);
			typeList.add(Types.VARCHAR);
		}
		if (StringUtils.isNotEmpty(companyPeopleName)) {
			sql.append(" and D.COMPANY_PEOPLE_NAME =?  ");
			objList.add(companyPeopleName);
			typeList.add(Types.VARCHAR);
		}
		if (StringUtils.isNotEmpty(companyNo)) {
			sql.append(" and D.COMPANY_NO=?  ");
			objList.add(companyNo);
			typeList.add(Types.VARCHAR);
		}
		if (StringUtils.isNotEmpty(companyBorgName)) {
			sql.append(" and D.COMPANY_BORG_NAME=?  ");
			objList.add(companyBorgName);
			typeList.add(Types.VARCHAR);
		}
		DataSet ds = new DataSet();
		if (typeList.size() > 0 && objList.size() > 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < types.length; i++) {
				types[i] = typeList.get(i);
			}
			Object[] objs = objList.toArray(new Object[objList.size()]);
			ds = this.executeDataset(sql.toString(), types, objs,getDsStart(pset), getDsLimit(pset),true);
		}
		return ds;
	}
	
	/**
	 * 删除单位信息，关联删除该单位经费信息
	 * */
	public void deleteAll(ParameterSet pset) {
		String companyId = (String) pset.getParameter("companyId");
		StringBuffer sql = new StringBuffer();
		StringBuffer sqls = new StringBuffer();
		sql.append("DELETE FROM JCM_COMPANY_MONEY T WHERE T.COMPANY_ID = '"+companyId+"'");
		sqls.append("DELETE FROM JCM_OFFICE_EQUIPMENT T WHERE T.COMPANY_ID = '"+companyId+"'");
		executeUpdate(sql.toString());
		executeUpdate(sqls.toString());
	}
	

	/**
	 * 查询 单位信息
	 * @param jcmCompanyProfile
	 */
	public DataSet queryCompanyInfo(ParameterSet pset){
		String areaCode=(String)pset.getParameter("areaCode");
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("procedureName", "JCM_COMPANY_INFO_REPORT");
		map.put("parameterNum", 1);
		map.put("parameterName_1", "areaCode");
		map.put("NumberOfResultSet",1);
		Proc procduce = new ProceduresUtil().init(getDataSource(),map);
		map.put("parameterValue_1", areaCode);
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
		set = ProceduresUtil.fixDataSet(set);
		return set;
	}
	
	
	/**
	 * 查询下级行政区划
	 * @param ups
	 * @return
	 */
	public DataSet getOrgan(String ups) {
		String JCM_COMPANY_UPS_QUERY = "select * from  JCM_COMPANY_PROFILE t where t.order_company_id = ? order by organ_code";
		int[] types = new int[] {Types.VARCHAR};
		Object[] objs = new Object[] {ups};
		List list = null;
		list = executeQuery(JCM_COMPANY_UPS_QUERY, types, objs);
		DataSet ds = new DataSet();
		for (int i = 0; i < list.size(); i++) {
			HashMap map = (HashMap) list.get(i);
			JcmCompanyProfile view = new JcmCompanyProfile();
			view.setCompanyId((String) map.get("COMPANY_ID"));
			view.setCompanyName((String) map.get("COMPANY_NAME"));
			view.setOrderCompanyId((String) map.get("ORDER_COMPANY_ID"));
//			view.setUps((String) map.get("LEVE"));
			view.setOrganType((String) map.get("ORGAN_TYPE"));
			ds.addRecord(view);
		}
		return ds;
	}
}