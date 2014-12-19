package com.inspur.cams.bpt.capital.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import com.inspur.cams.bpt.capital.data.BptCapitalsta;

/**
 * @title: 资金发放标准 Dao 层接口
 * @description: 资金发放标准 Dao 层接口
*/
 public interface IBptCapitalstaDao extends BaseCURD<BptCapitalsta>{
	
	/**
	 * 删除资金标准
	 */
	public void deleteStandard(ParameterSet pset);
	 
	public void save(List<BptCapitalsta> list);
	
	/**
	 * 资金管理
	 */
	public DataSet queryDataSet(ParameterSet pset);
	
	public void deleteBatch(ParameterSet pset);
}

