package com.inspur.cams.jcm.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.jcm.dao.IJcmCompanyMoneyDao;
import com.inspur.cams.jcm.data.JcmCompanyMoney;

/**
 * 工作经费信息dao
 * @author 
 * @date 2014-05-16
 */
public class JcmCompanyMoneyDao extends EntityDao<JcmCompanyMoney> implements IJcmCompanyMoneyDao {
	
	@Override
	public Class<JcmCompanyMoney> getEntityClass() {
		return JcmCompanyMoney.class;
	}

	public DataSet analysisMoney(ParameterSet pset) {
		String companyId = (String)pset.getParameter("companyId");
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objList = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer();
		sql.append("select YEAR,SUM(MONEY_COST) AS MONEY_COST from JCM_COMPANY_MONEY D WHERE 1=1 ");
		if (StringUtils.isNotEmpty(companyId)) {
			sql.append(" AND D.COMPANY_ID = ?  ");
			objList.add(companyId);
			typeList.add(Types.VARCHAR);
		}
		sql.append("GROUP BY YEAR ORDER BY YEAR");
		DataSet ds = new DataSet();
		if (typeList.size() > 0 && objList.size() > 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < types.length; i++) {
				types[i] = typeList.get(i);
			}
			Object[] objs = objList.toArray(new Object[objList.size()]);
			ds = this.executeDataset(sql.toString(), types, objs, true);
		}else{
			ds = this.executeDataset(sql.toString(), true);
		}
		return ds;
	}
	public DataSet analysisMoney1(ParameterSet pset) {
		String year = (String)pset.getParameter("year");
		String code = (String)pset.getParameter("organCode");
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objList = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer();
		sql.append("select * from ((select substr(C.ID, 0, 4) || '00000000' code, ");
		sql.append("C.NAME NAME,C.LEVE,NVL(sum(sss.MONEY_COST), 0) MONEY_COST from DIC_CITY C ");
		sql.append("LEFT JOIN (select S.ORGAN_CODE code, SUM(D.MONEY_COST) AS MONEY_COST from JCM_COMPANY_MONEY D, jcm_company_profile S ");
		sql.append("WHERE D.COMPANY_ID = S.COMPANY_ID AND D.YEAR = ? GROUP BY S.ORGAN_CODE) sss ON C.ID = substr(sss.code, 0, 4) || '00000000'");
		sql.append(" WHERE C.LEVE = '1' AND C.IS_SELF = '0' group by substr(C.ID, 0, 4), C.NAME,C.LEVE) UNION (");
		sql.append("select substr(C.ID, 0, 6) || '000000' code, ");
		sql.append("C.NAME NAME,C.LEVE,NVL(sum(sss.MONEY_COST), 0) MONEY_COST from DIC_CITY C ");
		sql.append("LEFT JOIN (select S.ORGAN_CODE code, SUM(D.MONEY_COST) AS MONEY_COST from JCM_COMPANY_MONEY D, jcm_company_profile S ");
		sql.append("WHERE D.COMPANY_ID = S.COMPANY_ID AND D.YEAR = ? GROUP BY S.ORGAN_CODE) sss ON C.ID = substr(sss.code, 0, 6) || '000000'");
		sql.append(" WHERE C.LEVE = '2' AND C.IS_SELF = '0' group by substr(C.ID, 0, 6), C.NAME,C.LEVE)) DD ");
		objList.add(year);
		typeList.add(Types.VARCHAR);
		objList.add(year);
		typeList.add(Types.VARCHAR);
		if(code!=null&&!"".equals(code)){
			 if(code.substring(2,12).equals("0000000000")){
				 sql.append(" WHERE DD.leve = '1'");
				 
				}else if(code.substring(4,12).equals("00000000")){
					sql.append(" WHERE DD.leve = '2' AND DD.CODE LIKE '"+code.substring(0,4)+"%'");
				}
		 }
		DataSet ds = new DataSet();
		if (typeList.size() > 0 && objList.size() > 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < types.length; i++) {
				types[i] = typeList.get(i);
			}
			Object[] objs = objList.toArray(new Object[objList.size()]);
			ds = this.executeDataset(sql.toString(), types, objs, true);
		}else{
			ds = this.executeDataset(sql.toString(), true);
		}
		return ds;
	}

}