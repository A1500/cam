package com.inspur.cams.bpt.capital.domain;

import java.util.List;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import com.inspur.cams.bpt.capital.data.BptCapitalsta;

/**
 * @title:资金发放标准Domain层接口
 * @description:资金发放标准Domain层接口
 */

public interface IBptCapitalstaDomain {
	
	/**
	 * 资金管理、伤残(批量显示,生效日期起，生效日期止，录入人，录入时间)
	 */
	public DataSet queryDataSet(ParameterSet pset);
	
	/**
	 * 资金管理批量删除
	 */
	public void deleteBatch(ParameterSet pset);
	
	/**
	 * 删除资金标准（伤残、三属、复员军人、生活补助）
	 */
	public void deleteStandard(ParameterSet pset);
	
	public void insert(BptCapitalsta bptCapitalsta);
	
	public void update(BptCapitalsta bptCapitalsta);
	
	public void batchInsert(List list);
	
	public void save(List list);
}
