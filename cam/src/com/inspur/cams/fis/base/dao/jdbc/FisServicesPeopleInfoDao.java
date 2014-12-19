package com.inspur.cams.fis.base.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;

import com.inspur.cams.fis.base.dao.IFisServicesPeopleInfoDao;
import com.inspur.cams.fis.base.data.FisServicesPeopleInfo;

/**
 * 殡葬服务机构工作人员信息表dao
 * @author 
 * @date Wed May 02 09:01:05 GMT+08:00 2012
 */
public class FisServicesPeopleInfoDao extends EntityDao<FisServicesPeopleInfo> implements IFisServicesPeopleInfoDao {
	
	@Override
	public Class<FisServicesPeopleInfo> getEntityClass() {
		return FisServicesPeopleInfo.class;
	}

	/**
	 * @Title: queryForPeopleRecords 
	 * @Description: TODO(查询服务机构人员信息) 
	 * @author wangziming
	 */
	public DataSet queryForPeopleRecords(ParameterSet pset) {

		DataSet ds = new DataSet();
		
		//获取查询条件
		String qname = (String) pset.getParameter("name");
		String qsex = (String) pset.getParameter("sex");
		String qidCard = (String) pset.getParameter("idCard");
		String qworkType = (String) pset.getParameter("workType");
		
		String ifCancel = (String) pset.getParameter("ifCancel");
		String peopleType = (String) pset.getParameter("peopleType");
		String education = (String) pset.getParameter("education");
		String profession = (String) pset.getParameter("profession");
		String startDate = (String) pset.getParameter("startdate");
		String endDate = (String) pset.getParameter("enddate");
		List<Integer> peoType = new ArrayList<Integer>();
		List<String> peoObject = new ArrayList<String>();
		
		StringBuffer sql = new StringBuffer();
		 sql.append("SELECT P.PEOPLE_ID,");
		 sql.append("       P.NAME,");
		 sql.append("       P.SEX,");
		 sql.append("       P.ID_CARD,");
		 sql.append("       P.PHONE,");
		 sql.append("       P.WORK_DATE,");
		 sql.append("       P.IF_CANCEL,");
		 sql.append("       P.PEOPLE_TYPE,");
		 sql.append("       P.EDUCATION,");
		 sql.append("       P.PROFESSION,");
		 sql.append("       P.POSITION,");
		 sql.append("       '' AS DUTY,");
		 sql.append("       '' AS DUTY_LEVEL ");
		 sql.append(" FROM FIS_SERVICES_PEOPLE_INFO P ");
		 sql.append(" WHERE 1 = 1 ");

		if(StringUtils.isNotEmpty(ifCancel)){
			sql.append(" AND P.IF_CANCEL=? ");
			peoType.add(Types.VARCHAR);
			peoObject.add(ifCancel);
		}	
		if(StringUtils.isNotEmpty(qname)){
			sql.append(" AND P.NAME = ? ");
			peoType.add(Types.VARCHAR);
			peoObject.add(qname);
		}		
		if(StringUtils.isNotEmpty(qsex)){
			sql.append(" AND P.SEX = ? ");
			peoType.add(Types.VARCHAR);
			peoObject.add(qsex);
		}
		if(StringUtils.isNotEmpty(peopleType)){
			sql.append(" AND P.PEOPLE_TYPE = ? ");
			peoType.add(Types.VARCHAR);
			peoObject.add(peopleType);
		}	
		if(StringUtils.isNotEmpty(education)){
			sql.append(" AND P.EDUCATION = ? ");
			peoType.add(Types.VARCHAR);
			peoObject.add(education);
		}
		if(StringUtils.isNotEmpty(profession)){
			sql.append(" AND P.PROFESSION = ? ");
			peoType.add(Types.VARCHAR);
			peoObject.add(profession);
		}
		if(StringUtils.isNotEmpty(startDate)){
			sql.append(" AND P.WORK_DATE >= ? ");
			peoType.add(Types.VARCHAR);
			peoObject.add(startDate);
		}
		if(StringUtils.isNotEmpty(endDate)){
			sql.append(" AND P.WORK_DATE <= ? ");
			peoType.add(Types.VARCHAR);
			peoObject.add(endDate);
		}
		if(StringUtils.isNotEmpty(qidCard)){
			sql.append(" AND P.ID_CARD = ? ");
			peoType.add(Types.VARCHAR);
			peoObject.add(qidCard);
		}
		if(StringUtils.isNotEmpty(qworkType)){
			sql.append(" AND P.PEOPLE_ID IN (SELECT D.PEOPLE_ID FROM FIS_SERVICES_DUTY_INFO D WHERE D.WORK_TYPE = ?) ");
			peoType.add(Types.VARCHAR);
			peoObject.add(qworkType);
		}

		sql.append(" ORDER BY P.CREATE_ORGAN,P.PEOPLE_ID");
		if (peoType.size() != 0 && peoObject.size() != 0) {
			int[] peoTypes = new int[peoType.size()];
			for (int i = 0; i < peoType.size(); i++) {
				peoTypes[i] = peoType.get(i);
			}
			Object[] peoArgs = peoObject.toArray(new Object[peoObject.size()]);
			ds = this.executeDataset(sql.toString(), peoTypes, peoArgs, pset.getPageStart(), pset.getPageLimit(), true);
		} else {
			ds = this.executeDataset(sql.toString(), pset.getPageStart(), pset.getPageLimit(), true);
		}
		
		DataSet dutyDs = new DataSet();
		dutyDs = this.executeDataset("SELECT PEOPLE_ID, J.CODE, J.NAME || '(' || P.NAME || ')' AS NAME FROM FIS_SERVICES_DUTY_INFO D LEFT JOIN DIC_FIS_JOB J ON D.WORK_TYPE = J.CODE LEFT JOIN DIC_PROFESSION_LEVEL p ON d.PROFESSION_LEVEL = P.CODE ORDER BY PEOPLE_ID ", true);
		
		StringBuffer dutyTemp = new StringBuffer();
		for(int i = 0; i < ds.getCount(); i ++) {
			Record record = ds.getRecord(i);
			String peopleId = (String)record.get("PEOPLE_ID");
			record.set("DUTY", "");
			dutyTemp.delete(0, dutyTemp.length());
			for(int j = 0; j < dutyDs.getCount(); j++) {
				Record rec = dutyDs.getRecord(j);
				if(peopleId.equals((String)rec.get("PEOPLE_ID"))) {
					dutyTemp.append((String)rec.get("NAME")).append(",");
				}
			}
			if(dutyTemp.toString().endsWith(","))
				dutyTemp.deleteCharAt(dutyTemp.length()-1);
			
			record.set("DUTY", dutyTemp.toString());
		}
		return ds;
	}
}