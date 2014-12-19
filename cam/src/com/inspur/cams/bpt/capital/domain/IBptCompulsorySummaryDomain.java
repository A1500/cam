package com.inspur.cams.bpt.capital.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import com.inspur.cams.bpt.capital.data.BptCompulsorySummary;

/**
 * 优待金发放汇总表
 */
public interface IBptCompulsorySummaryDomain {
	
	/**
	 * 查询优待金发放汇总【利用Dao方法】
	 */
	public DataSet query(ParameterSet pset);
	
	/**
	 * 查询优待金发放汇总
	 */
    public DataSet queryCompulsorySummary(ParameterSet pset);
    
    /**
	 * 添加优待金发放汇总
	 */
    public void insertCompulsorySummary(BptCompulsorySummary bptCompulsorySummary);
    
    /**
	 * 批量删除优待金发放汇总
	 */
    public void deleteCompulsorySummary(String[] delIds);
    
    /**
	 * 删除优待金汇总
	 */
    public void deleteRegisterId(ParameterSet param);
    
    /**
     * 修改优待金发放汇总
     */
    public void update(BptCompulsorySummary bptCompulsorySummary);
    
    /**
	 * 修改优待金总额
	 */
	public void updateNonCompuSumm(ParameterSet pset);
}
