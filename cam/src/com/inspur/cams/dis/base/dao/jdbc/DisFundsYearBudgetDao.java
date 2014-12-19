package com.inspur.cams.dis.base.dao.jdbc;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;

import com.inspur.cams.comm.util.ProceduresUtil;
import com.inspur.cams.comm.util.ProceduresUtil.Proc;
import com.inspur.cams.dis.base.dao.IDisFundsYearBudgetDao;
import com.inspur.cams.dis.base.data.DisFundsYearBudget;

/**
 * 救灾资金年度预算表dao
 * @author 
 * @date 2012-11-15
 */
public class DisFundsYearBudgetDao extends EntityDao<DisFundsYearBudget> implements IDisFundsYearBudgetDao {
	
	@Override
	public Class<DisFundsYearBudget> getEntityClass() {
		return DisFundsYearBudget.class;
	}

	/**
	 * 查询是否存在年度disYear，若有返回true，没有返回false
	 * @param budgetType
	 * @return
	 */
	public DataSet queryDisYear(DisFundsYearBudget disFundsYearBudget){
		StringBuffer sql = new StringBuffer();
		sql.append(" select * from dis_funds_year_budget where dis_year='").append(disFundsYearBudget.getDisYear()).
			append("' and fill_organ_code='").append(disFundsYearBudget.getFillOrganCode()).append("'");
		return executeDataset(sql.toString(),false);//false为返回不定义字段
	}
	
	/**
	 * 查询一年预算金额总和
	 */
	public DataSet queryYearMoneyReady(ParameterSet pset){
		StringBuffer sql = new StringBuffer();
		sql.append(" select nvl(sum(BUDGET_MONEY),0) summ from DIS_FUNDS_YEAR_BUDGET where dis_year='").append((String)pset.get("disYear")).append("' ");
		sql.append(" and FILL_ORGAN_CODE='").append((String)pset.get("organCode")).append("' ");
		return executeDataset(sql.toString(),true);
	}
	
	/**
	 * @Description: 预算统计
	 * @author xuexzh
	 */
	public DataSet queryBudgetForSums(ParameterSet pset) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("procedureName", "DIS_QUERY_FUNDS_BUDGET"); //FIS_QUERY_FUNERAL_CRE_AREA_NUM
		map.put("parameterNum", 2);
		map.put("parameterName_1", "in_area_code");
		map.put("parameterName_2", "in_year");
		map.put("NumberOfResultSet", 1);
		Proc procduce = new ProceduresUtil().init(getDataSource(), map);
		DataSet set = new DataSet();
		List results = null;
		Object object = null;
		String qOrganCode = (String) pset.getParameter("qOrganCode");
		String qDisYear = (String) pset.getParameter("qDisYear");
		map.put("parameterValue_1", qOrganCode);
		map.put("parameterValue_2", qDisYear);

		object = procduce.call(map).get("results");
		if (object instanceof ArrayList) {
			results = (List) object;
			BigDecimal zero = new BigDecimal(0.0);
			Record addRec = new Record(); 
			for (int i=0; i<results.size(); i++) {
				Record rec = (Record)results.get(i);
				if(i!=0 && "00".equals((String)rec.get("BUDGET_TYPE"))) {
					if(!addRec.containsKey("BUDGET_MONEY")) {
						addRec.set("BUDGET_MONEY", zero);
					}
					if(!addRec.containsKey("YEAR_MONEY")) {
						addRec.set("YEAR_MONEY", zero);
					}
					
					addRec.set("TOTAL_MONEY", ((BigDecimal)addRec.get("BUDGET_MONEY")).add((BigDecimal)addRec.get("YEAR_MONEY")));
					set.add(addRec);
					addRec = new Record();  
				}
				
				if("00".equals((String)rec.get("BUDGET_TYPE"))) {
					addRec.set("ID", (String)rec.get("ID"));
					addRec.set("NAME", (String)rec.get("NAME"));
					addRec.set("AMOUNT_TOTAL", (BigDecimal)rec.get("AMOUNT_TOTAL"));
					addRec.set("AMOUNT", (BigDecimal)rec.get("AMOUNT"));
					addRec.set("METERIAL", (BigDecimal)rec.get("METERIAL"));
				}else {
					if("01,02".equals((String)rec.get("BUDGET_TYPE"))) {
						addRec.set("BUDGET_MONEY", zero);
						addRec.set("YEAR_MONEY", zero);
					}else if("01".equals((String)rec.get("BUDGET_TYPE"))){
						addRec.set("YEAR_MONEY", (BigDecimal)rec.get("BUDGET_MONEY"));
					}else if("02".equals((String)rec.get("BUDGET_TYPE"))){
						addRec.set("BUDGET_MONEY", (BigDecimal)rec.get("BUDGET_MONEY"));
					}
				}
			}
			if(results.size() > 0) {
				if(!addRec.containsKey("BUDGET_MONEY")) {
					addRec.set("BUDGET_MONEY", zero);
				}
				if(!addRec.containsKey("YEAR_MONEY")) {
					addRec.set("YEAR_MONEY", zero);
				}
				addRec.set("TOTAL_MONEY", ((BigDecimal)addRec.get("BUDGET_MONEY")).add((BigDecimal)addRec.get("YEAR_MONEY")));
				set.add(addRec);
			}
		}
		ProceduresUtil.fixDataSet(set);
		return set;
	}
}