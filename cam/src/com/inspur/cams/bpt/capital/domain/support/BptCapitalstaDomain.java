package com.inspur.cams.bpt.capital.domain.support;

import java.util.List;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;
import com.inspur.cams.bpt.capital.dao.IBptCapitalstaDao;
import com.inspur.cams.bpt.capital.data.BptCapitalsta;
import com.inspur.cams.bpt.capital.domain.IBptCapitalstaDomain;
/**
 * @title:资金发放标准Domain层
 * @description:资金发放标准Domain层
 */

public class BptCapitalstaDomain implements IBptCapitalstaDomain{
	@Reference
	private IBptCapitalstaDao bptCapitalstaDao;
	
	/**
	 * 资金管理、伤残(批量显示,生效日期起，生效日期止，录入人，录入时间)
	 */
	public DataSet queryDataSet(ParameterSet pset){
		return bptCapitalstaDao.queryDataSet(pset);
	}
	
	/**
	 * 资金管理批量删除
	 */
	public void deleteBatch(ParameterSet pset){
		 bptCapitalstaDao.deleteBatch(pset);
	}
	
	/**
	 * 删除资金标准（伤残、三属、复员军人、生活补助）
	 */
	public void deleteStandard(ParameterSet pset){
		bptCapitalstaDao.deleteStandard(pset);
	}
	
	public void insert(BptCapitalsta bptCapitalsta){
		bptCapitalstaDao.insert(bptCapitalsta);
	}
	
	public void update(BptCapitalsta bptCapitalsta){
		bptCapitalstaDao.update(bptCapitalsta);
	}
	
	public void batchInsert(List list){
		bptCapitalstaDao.batchInsert(list);
	}
	
	public void save(List list){
		bptCapitalstaDao.save(list);
	}
}
