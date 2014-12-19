package com.inspur.cams.bpt.capital.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;
import com.inspur.cams.bpt.capital.dao.IBptCompulsorySummaryDao;
import com.inspur.cams.bpt.capital.data.BptCompulsorySummary;
import com.inspur.cams.bpt.capital.domain.IBptCompulsorySummaryDomain;

/**
 * 优待金发放汇总表
 */
public class BptCompulsorySummaryDomain implements IBptCompulsorySummaryDomain {
	@Reference
	private IBptCompulsorySummaryDao bptCompulsorySummaryDao;
	
	/**
	 * 修改优待金总额
	 */
	public void updateNonCompuSumm(ParameterSet pset){
		bptCompulsorySummaryDao.updateNonCompuSumm(pset);
	}
	
	/**
	 * 查询优待金发放汇总【利用Dao方法】
	 */
	public DataSet query(ParameterSet pset){
		return bptCompulsorySummaryDao.query(pset);
	}
	
	/**
	 * 查询优待金发放汇总
	 */
	public DataSet queryCompulsorySummary(ParameterSet pset) {
		return bptCompulsorySummaryDao.queryCompulsorySummary(pset);
	}
	
	/**
	 * 添加优待金发放汇总
	 */
	public void insertCompulsorySummary(BptCompulsorySummary bptCompulsorySummary) {
		bptCompulsorySummaryDao.insert(bptCompulsorySummary);
	}
	
	/**
	 * 批量删除优待金发放汇总
	 */
	public void deleteCompulsorySummary(String[] delIds){
		bptCompulsorySummaryDao.batchDelete(delIds);
	}
	
	/**
	 * 删除优待金汇总
	 */
	public void deleteRegisterId(ParameterSet param) {
		bptCompulsorySummaryDao.deleteRegisterId(param);
	}
	
	/**
     * 修改优待金发放汇总
     */
    public void update(BptCompulsorySummary bptCompulsorySummary){
    	bptCompulsorySummaryDao.update(bptCompulsorySummary);
    }
}
