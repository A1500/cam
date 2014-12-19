package com.inspur.cams.bpt.capital.dao.jdbc;

import java.math.BigDecimal;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.bpt.capital.dao.IBptCapitalBudgetDao;
import com.inspur.cams.bpt.capital.data.BPTCapitalBudget;
import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;

public class BPTCapitalBudgetAjaxDao extends EntityDao<BPTCapitalBudget> implements IBptCapitalBudgetDao {

	public BPTCapitalBudgetAjaxDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory
				.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}
    @Override
    protected Class<BPTCapitalBudget> getEntityClass() {
        return BPTCapitalBudget.class;
    }

    public DataSet queryProvince(ParameterSet pset) {
        StringBuffer sql = new StringBuffer();
		sql.append("SELECT Z.INPUT_ID             		  AS INPUT_ID,\n");
		sql.append("       Z.YEAR                        AS YEAR,\n"); 
		sql.append("       NVL(Z.COMPENSATION_SUBSIDY,0) AS COMPENSATION_SUBSIDY,\n"); 
		sql.append("       NVL(Z.INSTITUTION_SUBSIDY,0)  AS INSTITUTION_SUBSIDY,\n"); 
		sql.append("       NVL(Z.MEDICAL_SUBSIDY,0)      AS MEDICAL_SUBSIDY,\n"); 
		sql.append("       NVL(Z.HOUSE_SUBSIDY,0)        AS HOUSE_SUBSIDY,\n"); 
		sql.append("       S.INPUT_ID                    AS INPUT_ID1,\n"); 
		sql.append("       NVL(S.COMPENSATION_SUBSIDY,0) AS COMPENSATION_SUBSIDY1,\n"); 
		sql.append("       NVL(S.INSTITUTION_SUBSIDY,0)  AS INSTITUTION_SUBSIDY1,\n"); 
		sql.append("       NVL(S.MEDICAL_SUBSIDY,0)      AS MEDICAL_SUBSIDY1,\n"); 
		sql.append("       NVL(S.HOUSE_SUBSIDY,0)        AS HOUSE_SUBSIDY1,\n"); 
		sql.append("       S.NOTE                 AS NOTE\n"); 
		sql.append("  FROM BPT_CAPITAL_BUDGET Z, BPT_CAPITAL_BUDGET S\n"); 
		sql.append(" WHERE Z.YEAR = S.YEAR\n"); 
		sql.append("   AND Z.REGION_LEVEL = ?\n"); 
		sql.append("   AND S.REGION_LEVEL = ?");
        DataSet ds = new DataSet();
        List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		
		typeList.add(Types.VARCHAR);
		argsList.add("0");
		typeList.add(Types.VARCHAR);
		argsList.add("1");
		
		String inputId = (String) pset.getParameter("inputId");
		String inputId1 = (String) pset.getParameter("inputId1");
		
		if(inputId != null &&!inputId.equals("")){
			sql.append(" AND Z.INPUT_ID = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(inputId);
		}
		if(inputId1 != null &&!inputId1.equals("")){
			sql.append(" AND S.INPUT_ID = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(inputId1);
		}
		if(typeList.size()!=0&&argsList.size()!=0){
			int[] types = new int[typeList.size()];
			for(int i=0;i<typeList.size();i++){
				types[i] = (Integer)typeList.get(i);
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			ds = this.executeDataset(sql.toString(),types,args,true);
		}
		return ds;
    }

    public void addProvinceBudget(ParameterSet pset) {
        Record record = (Record) pset.getParameter("record");
        BPTCapitalBudget budget = new BPTCapitalBudget();
        String inputId = IdHelp.getUUID32();
        budget.setInputId(inputId);
        budget.setDomicileCode("370000000000");
        budget.setYear(record.get("YEAR")==null?"":(String)record.get("YEAR"));
        budget.setRegionLevel("0");
        budget.setCompensationSubsidy((record.get("COMPENSATION_SUBSIDY")==null||((String)record.get("COMPENSATION_SUBSIDY")).equals(""))?BigDecimal.valueOf(0.0):BigDecimal.valueOf(Double.parseDouble((String)record.get("COMPENSATION_SUBSIDY"))));
        budget.setInstitutionSubsidy((record.get("INSTITUTION_SUBSIDY")==null||((String)record.get("INSTITUTION_SUBSIDY")).equals(""))?BigDecimal.valueOf(0.0):BigDecimal.valueOf(Double.parseDouble((String)record.get("INSTITUTION_SUBSIDY"))));
        budget.setMedicalSubsidy((record.get("MEDICAL_SUBSIDY")==null||((String)record.get("MEDICAL_SUBSIDY")).equals(""))?BigDecimal.valueOf(0.0):BigDecimal.valueOf(Double.parseDouble((String)record.get("MEDICAL_SUBSIDY"))));
        budget.setHouseSubsidy((record.get("HOUSE_SUBSIDY")==null||((String)record.get("HOUSE_SUBSIDY")).equals(""))?BigDecimal.valueOf(0.0):BigDecimal.valueOf(Double.parseDouble((String)record.get("HOUSE_SUBSIDY"))));
        budget.setNote(record.get("NOTE")==null?"":(String)record.get("NOTE"));
        budget.setRegId(BspUtil.getCorpOrgan().getOrganCode());
        budget.setRegTime(DateUtil.getTime());
        this.insert(budget);
        BPTCapitalBudget budget1 = new BPTCapitalBudget();
        String inputId1 = IdHelp.getUUID32();
        budget1.setInputId(inputId1);
        budget1.setDomicileCode("370000000000");
        budget1.setYear(record.get("YEAR")==null?"":(String)record.get("YEAR"));
        budget1.setRegionLevel("1");
        budget1.setCompensationSubsidy((record.get("COMPENSATION_SUBSIDY1")==null||((String)record.get("COMPENSATION_SUBSIDY1")).equals(""))?BigDecimal.valueOf(0.0):BigDecimal.valueOf(Double.parseDouble((String)record.get("COMPENSATION_SUBSIDY1"))));
        budget1.setInstitutionSubsidy((record.get("INSTITUTION_SUBSIDY1")==null||((String)record.get("INSTITUTION_SUBSIDY1")).equals(""))?BigDecimal.valueOf(0.0):BigDecimal.valueOf(Double.parseDouble((String)record.get("INSTITUTION_SUBSIDY1"))));
        budget1.setMedicalSubsidy((record.get("MEDICAL_SUBSIDY1")==null||((String)record.get("MEDICAL_SUBSIDY1")).equals(""))?BigDecimal.valueOf(0.0):BigDecimal.valueOf(Double.parseDouble((String)record.get("MEDICAL_SUBSIDY1"))));
        budget1.setHouseSubsidy((record.get("HOUSE_SUBSIDY1")==null||((String)record.get("HOUSE_SUBSIDY1")).equals(""))?BigDecimal.valueOf(0.0):BigDecimal.valueOf(Double.parseDouble((String)record.get("HOUSE_SUBSIDY1"))));
        budget1.setNote(record.get("NOTE")==null?"":(String)record.get("NOTE"));
        budget1.setRegId(BspUtil.getCorpOrgan().getOrganCode());
        budget1.setRegTime(DateUtil.getTime());
        this.insert(budget1);
    }
    
    public void updateProvinceBudget(ParameterSet pset) {
        Record record = (Record) pset.getParameter("record");
        String inputId = (String)record.get("INPUT_ID");
        pset.clear();
        pset.setParameter("INPUT_ID",inputId);
        BPTCapitalBudget budget = (BPTCapitalBudget)this.query(pset).getRecord(0).toBean(BPTCapitalBudget.class);
        budget.setYear(record.get("YEAR")==null?"":(String)record.get("YEAR"));
        if(record.get("COMPENSATION_SUBSIDY")!=null&&!(record.get("COMPENSATION_SUBSIDY").toString()).equals("")){
        	budget.setCompensationSubsidy(new BigDecimal(record.get("COMPENSATION_SUBSIDY").toString()));
        }
        budget.setInstitutionSubsidy((record.get("INSTITUTION_SUBSIDY")==null||(record.get("INSTITUTION_SUBSIDY").toString()).equals(""))?new BigDecimal(0.0):new BigDecimal(record.get("INSTITUTION_SUBSIDY").toString()));
        budget.setMedicalSubsidy((record.get("MEDICAL_SUBSIDY")==null||(record.get("MEDICAL_SUBSIDY").toString()).equals(""))?new BigDecimal(0.0):new BigDecimal(record.get("MEDICAL_SUBSIDY").toString()));
        budget.setHouseSubsidy((record.get("HOUSE_SUBSIDY")==null||(record.get("HOUSE_SUBSIDY").toString()).equals(""))?new BigDecimal(0.0):new BigDecimal(record.get("HOUSE_SUBSIDY").toString()));
        budget.setNote(record.get("NOTE")==null?"":(String)record.get("NOTE"));
        budget.setModId(BspUtil.getCorpOrgan().getOrganCode());
        budget.setModTime(DateUtil.getTime());
        this.update(budget);
        
        String inputId1 = (String)record.get("INPUT_ID1");
        pset.clear();
        pset.setParameter("INPUT_ID",inputId1);
        BPTCapitalBudget budget1 = (BPTCapitalBudget)this.query(pset).getRecord(0).toBean(BPTCapitalBudget.class);
        budget1.setYear(record.get("YEAR")==null?"":(String)record.get("YEAR"));
        budget1.setCompensationSubsidy((record.get("COMPENSATION_SUBSIDY1")==null||(record.get("COMPENSATION_SUBSIDY1").toString()).equals(""))?new BigDecimal(0.0):new BigDecimal(record.get("COMPENSATION_SUBSIDY1").toString()));
        budget1.setInstitutionSubsidy((record.get("INSTITUTION_SUBSIDY1")==null||(record.get("INSTITUTION_SUBSIDY1").toString()).equals(""))?new BigDecimal(0.0):new BigDecimal(record.get("INSTITUTION_SUBSIDY1").toString()));
        budget1.setMedicalSubsidy((record.get("MEDICAL_SUBSIDY1")==null||(record.get("MEDICAL_SUBSIDY1").toString()).equals(""))?new BigDecimal(0.0):new BigDecimal(record.get("MEDICAL_SUBSIDY1").toString()));
        budget1.setHouseSubsidy((record.get("HOUSE_SUBSIDY1")==null||(record.get("HOUSE_SUBSIDY1").toString()).equals(""))?new BigDecimal(0.0):new BigDecimal(record.get("HOUSE_SUBSIDY1").toString()));
        budget1.setNote(record.get("NOTE")==null?"":(String)record.get("NOTE"));
        budget1.setModId(BspUtil.getCorpOrgan().getOrganCode());
        budget1.setModTime(DateUtil.getTime());
        this.update(budget1);
    }
    
    /**
     * 查询是否存在相同的年份
     */
    public String checkYearExist(ParameterSet pset){
    	String flag = "0";
    	String year = (String)pset.getParameter("year");
    	String organCode = (String)pset.getParameter("organCode");
    	String sql = "SELECT * FROM BPT_CAPITAL_BUDGET T WHERE T.YEAR = ? AND T.DOMICILE_CODE = ?";
    	DataSet ds =  this.executeDataset(sql, new int[]{Types.VARCHAR,Types.VARCHAR},new Object[]{year,organCode},true);
    	if(ds.getCount()>0){
    		flag = "1";
    	}
    	return flag;
    }
    
}
