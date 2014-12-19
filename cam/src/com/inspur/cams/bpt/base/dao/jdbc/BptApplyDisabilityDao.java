package com.inspur.cams.bpt.base.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.bpt.base.dao.IBptApplyDisabilityDao;
import com.inspur.cams.bpt.base.data.BptApplyDisability;
import com.inspur.cams.bpt.util.FilterLimit;

/**
 * @title:BptApplyDisabilityDao
 * @description:
 * @author:
 * @since:2011-06-10
 * @version:1.0
*/
 public class BptApplyDisabilityDao extends EntityDao<BptApplyDisability> implements IBptApplyDisabilityDao{

 	public BptApplyDisabilityDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class<BptApplyDisability> getEntityClass() {
		return BptApplyDisability.class;
	}
   
   /**
	 * 查询未提交的调残、换证（补证）、证件变更人员列表
	 * @param pset
	 * @return
	 */
	public DataSet queryUnCommiAdjust(ParameterSet pset){
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT C.FULL_NAME AS DOMI_NAME, P.FAMILY_ID AS FAMILY_ID, P.NAME, P.SEX,\n");
		sql.append("       P.NATION, P.ID_CARD, P.DISABILITY_NO, A.APPROVE_DATE,\n"); 
		sql.append("       P.DISABILITY_STATE_CODE, B.DISABILITY_TYPE_CODE,\n");
		sql.append("       D.DISABILITY_LEVEL_CODE, D.DISABILITY_CASE_CODE,\n");
		sql.append("       D.DISABILITY_GENUS_CODE, D.PEOPLE_ID, A.APPLY_ID , A.SERVICE_TYPE\n"); 
		sql.append("  FROM BASEINFO_PEOPLE P, BPT_PEOPLE B, BPT_PEOPLE_DISABILITY D, DIC_CITY C,\n");
		sql.append("       BPT_APPLY_DISABILITY A\n"); 
		sql.append(" WHERE P.PEOPLE_ID = B.PEOPLE_ID AND B.PEOPLE_ID = D.PEOPLE_ID AND\n"); 
		sql.append("       P.PEOPLE_ID = A.PEOPLE_ID AND P.DISABILITY_FLAG = '1' AND\n");
		sql.append("       P.DOMICILE_CODE = C.ID AND A.COMMIT_FLAG = '0'");
		String organCode = (String)pset.getParameter("organCode");
		String serviceType = (String)pset.getParameter("serviceType");
		String serviceType1 = (String)pset.getParameter("serviceType1");
		organCode =FilterLimit.filterByOrganCode(sql,organCode);
		typeList.add(Types.VARCHAR);
		argsList.add(organCode);
		if(serviceType1 != null && !serviceType1.equals("")&&serviceType != null && !serviceType.equals("")){
			sql.append(" AND (A.SERVICE_TYPE = ? OR A.SERVICE_TYPE = ?)");
			typeList.add(Types.VARCHAR);
			argsList.add(serviceType1);
			typeList.add(Types.VARCHAR);
			argsList.add(serviceType);
		} else if(serviceType != null && !serviceType.equals("")){
			sql.append(" AND A.SERVICE_TYPE = ?");
			typeList.add(Types.VARCHAR);
			argsList.add(serviceType);
		}
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = typeList.get(i);
		}
		Object[] args = argsList.toArray(new Object[argsList.size()]);
		return this.executeDataset(sql.toString(), types, args, pset.getPageStart(), pset.getPageLimit(), true);
	}
	 /**
	   * 删除伤残相关信息
	 * @param pset
	 */
	public void deleteAboutDisability(ParameterSet pset){
		   String applyId = (String)pset.getParameter("applyId");
		   String peopleId = (String)pset.getParameter("peopleId");
		   String disType = (String)pset.getParameter("disType");
		   int[] type = new int[1];
		   Object[] applyid = new Object[1];
		   Object[] peopleid = new Object[1];
		   type[0]=Types.VARCHAR;
		   applyid[0] = applyId;
		   peopleid[0] = peopleId;
		   StringBuffer sql = new StringBuffer();
		   sql.append("UPDATE BASEINFO_PEOPLE B SET B.DISABILITY_FLAG='0',");
		   sql.append("b.DISABILITY_LEVEL_CODE='',");
		   sql.append("b.DISABILITY_CASE_CODE='',");
		   sql.append("b.DISABILITY_NO='',");
		   sql.append("b.DISABILITY_STATE_CODE='0' ");
		   sql.append("WHERE PEOPLE_ID=?");
		   if("assess".equals(disType)){//评残
			   this.executeUpdate("DELETE BPT_APPLY_DISABILITY_NOTICE WHERE PEOPLE_ID=?", type, peopleid);
			   this.executeUpdate("DELETE BPT_DISABILITY_IDENTI WHERE PEOPLE_ID=?", type, peopleid);
			   this.executeUpdate("DELETE BPT_DISABILITY_OPEN WHERE APPLY_ID=?", type, applyid);
			   this.executeUpdate("DELETE BPT_DECISION_LETTER WHERE APPLY_ID=?", type, applyid);
			   this.executeUpdate("DELETE BPT_APPLY_DISABILITY WHERE APPLY_ID=?", type, applyid);
			   this.executeUpdate("DELETE BPT_PEOPLE_DISABILITY  WHERE PEOPLE_ID=?", type, peopleid);
			   this.executeUpdate("DELETE BPT_PHYSICAL_EXAMINATION  WHERE APPLY_ID=?", type, applyid);
			   this.executeUpdate(sql.toString(), type, peopleid);
			   this.executeUpdate( "UPDATE BPT_PEOPLE B SET B.DISABILITY_TYPE_CODE='00' WHERE PEOPLE_ID=?", type, peopleid);
			 //删除伤残中参试人员体检表
			   applyid[0] = applyId+"@";
			   this.executeUpdate("DELETE BPT_PHYSICAL_EXAMINATION  WHERE APPLY_ID=?", type, applyid);
			   
		   }else if("adjust".equals(disType)){//调残
			   this.executeUpdate("DELETE BPT_APPLY_DISABILITY_NOTICE WHERE PEOPLE_ID=?", type, peopleid);
			   this.executeUpdate("DELETE BPT_DISABILITY_IDENTI WHERE PEOPLE_ID=?", type, peopleid);
			   this.executeUpdate("DELETE BPT_DISABILITY_OPEN WHERE APPLY_ID=?", type, applyid);
			   this.executeUpdate("DELETE BPT_DECISION_LETTER WHERE APPLY_ID=?", type, applyid);
			   this.executeUpdate("DELETE BPT_APPLY_DISABILITY WHERE APPLY_ID=?", type, applyid);
			   this.executeUpdate("DELETE BPT_PHYSICAL_EXAMINATION  WHERE APPLY_ID=?", type, applyid);
		   }else if("veterans".equals(disType)){//残疾军人
			   this.executeUpdate("DELETE BPT_APPLY_DISABILITY WHERE APPLY_ID=?", type, applyid);
			   this.executeUpdate("DELETE BPT_PEOPLE_DISABILITY  WHERE PEOPLE_ID=?", type, peopleid);
			   this.executeUpdate(sql.toString(), type, peopleid);
			   this.executeUpdate("UPDATE BPT_PEOPLE B SET B.DISABILITY_TYPE_CODE='00' WHERE PEOPLE_ID=?", type, peopleid);
		   }else if("assistive".equals(disType)){//器械申请
			   this.executeUpdate("DELETE BPT_APPLY_ASSISTIVE_DEVICES WHERE PEOPLE_ID=?", type, peopleid);
		   }else if("exchange".equals(disType)){//换证补证
			   this.executeUpdate("DELETE BPT_APPLY_DISABILITY WHERE APPLY_ID=?", type, applyid);
		   }else if("change".equals(disType)){//证件变更
			   this.executeUpdate("DELETE BPT_APPLY_DISABILITY WHERE APPLY_ID=?", type, applyid);
		   }
	   }
	
	/**
	 * 查询审批后打证信息
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet queryPrintInfo(ParameterSet pset) {
		DataSet ds = new DataSet();
		List<Integer> param = new ArrayList<Integer>();
		List<Object> obj = new ArrayList<Object>();
		String idCard = (String) pset.getParameter("idCard"); // 身份证
		String serviceType = (String) pset.getParameter("serviceType"); // 业务类型
		String organCode = (String) pset.getParameter("domicileCode"); // 行政区划
		String name = (String) pset.getParameter("name");// 姓名
		String printFlag = (String) pset.getParameter("printFlag");// 是否打证
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT C.FULL_NAME, P.PEOPLE_ID, P.FAMILY_ID, A.APPLY_ID, A.SERVICE_TYPE,\n");
		sql.append("       ID_CARD, P.NAME, P.SEX, P.NATION, P.DISABILITY_STATE_CODE,\n");
		sql.append("       B.DISABILITY_TYPE_CODE, D.REG_TIME,\n");
		sql.append("       (CASE A.SERVICE_TYPE\n");
		sql.append("          WHEN '11' THEN '评残'\n");
		sql.append("          WHEN '12' THEN '调残'\n"); 
		sql.append("        END) AS SERVICE_NAME,\n"); 
		sql.append("       (CASE A.PRINT_FLAG\n");
		sql.append("          WHEN '1' THEN '已打证'\n"); 
		sql.append("          WHEN '0' THEN '未打证'\n");
		sql.append("        END) AS PRINT_FLAG_NAME\n");
		sql.append("  FROM BASEINFO_PEOPLE P, BPT_PEOPLE B, BPT_PEOPLE_DISABILITY D,\n");
		sql.append("       BPT_APPLY_DISABILITY A, DIC_CITY C\n");
		sql.append(" WHERE P.PEOPLE_ID = B.PEOPLE_ID AND P.PEOPLE_ID = D.PEOPLE_ID AND\n"); 
		sql.append("       A.PEOPLE_ID = P.PEOPLE_ID AND P.DOMICILE_CODE = C.ID AND\n");
		sql.append("       A.PASS_FLAG = '1' AND A.SERVICE_TYPE IN ('11', '12') ");
		
		if (idCard != null && !"".equals(idCard)) {
			sql.append(" AND P.ID_CARD= ? ");
			param.add(Types.VARCHAR);
			obj.add(idCard);
		}

		if (name != null && !"".equals(name)) {
			sql.append(" AND P.NAME LIKE ?");
			param.add(Types.VARCHAR);
			obj.add("%"+name+"%");
		}

		if (serviceType != null && !"".equals(serviceType)) {
			sql.append(" AND A.SERVICE_TYPE = ? ");
			param.add(Types.VARCHAR);
			obj.add(serviceType);
		}

		if (printFlag != null && !"".equals(printFlag)) {
			sql.append(" AND A.PRINT_FLAG = ? ");
			param.add(Types.VARCHAR);
			obj.add(printFlag);
		}

		if (organCode != null && !"".equals(organCode)) {
			organCode =FilterLimit.filterByOrganCode(sql,organCode);
			param.add(Types.VARCHAR);
			obj.add(organCode);
		}
		

		if (param.size() != 0 && obj.size() != 0) {
			int[] types = new int[param.size()];
			for (int i = 0; i < param.size(); i++) {
				types[i] = param.get(i);
			}
			Object[] args = obj.toArray(new Object[obj.size()]);
			ds = this.executeDataset(sql.toString(), types, args, pset
					.getPageStart(), pset.getPageLimit(), true);
		} else {
			ds = this.executeDataset(sql.toString(), pset.getPageStart(), pset
					.getPageLimit(), true);
		}

		return ds;
	}
	
	
	/**
	 * 修改打印标示
	 * @param pset
	 */
	public void editPrintFlag(ParameterSet pset) {
		String sql = "UPDATE BPT_APPLY_DISABILITY SET PRINT_FLAG = ? WHERE APPLY_ID = ?";
		this.executeUpdate(sql, new int[]{Types.VARCHAR,Types.VARCHAR}, 
				new Object[]{pset.getParameter("printFlag"),pset.getParameter("applyId")});
	}

	public DataSet queryApplyInfoForCheck(ParameterSet pset) {
		DataSet ds = new DataSet();
		List<Integer> param = new ArrayList<Integer>();
		List<Object> obj = new ArrayList<Object>();
		String peopleId = (String) pset.getParameter("peopleId"); 
		String serviceType = (String) pset.getParameter("serviceType"); // 业务类型
		String passFlg = (String) pset.getParameter("passFlg"); 
		StringBuffer sql = new StringBuffer();
		sql.append(" select * from  BPT_APPLY_DISABILITY d where 1=1 ");

		if (StringUtils.isNotEmpty(peopleId)) {
			sql.append(" AND d.people_Id = ?");
			param.add(Types.VARCHAR);
			obj.add(peopleId);
		}
		if (StringUtils.isNotEmpty(serviceType)) {
			sql.append(" AND d.service_Type = ?");
			param.add(Types.VARCHAR);
			obj.add(serviceType);
		}
		if (StringUtils.isNotEmpty(passFlg)) {
			sql.append(" AND d.PASS_FLAG  is null ");
		}

		if (param.size() != 0 && obj.size() != 0) {
			int[] types = new int[param.size()];
			for (int i = 0; i < param.size(); i++) {
				types[i] = param.get(i);
			}
			Object[] args = obj.toArray(new Object[obj.size()]);
			ds = this.executeDataset(sql.toString(), types, args, pset
					.getPageStart(), pset.getPageLimit(), true);
		} else {
			ds = this.executeDataset(sql.toString(), pset.getPageStart(), pset
					.getPageLimit(), true);
		}

		return ds;
	}
}
