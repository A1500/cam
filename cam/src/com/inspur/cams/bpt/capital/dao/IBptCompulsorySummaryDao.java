package com.inspur.cams.bpt.capital.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.bpt.capital.data.BptCompulsorySummary;


/**
 * @title:IBptCompulsorySummaryDao
 * @description:优待金发放汇总 Dao 层 接口
 * @author:
 * @since:2011-06-07
 * @version:1.0
*/
 public interface IBptCompulsorySummaryDao extends BaseCURD<BptCompulsorySummary>{
	public void save(List<BptCompulsorySummary> list);
	public void deleteRegisterId(ParameterSet param);
	
	/**
	 * 查询除义务兵家庭外其他优抚对象优待金发放汇总
	 */
	public DataSet queryCompulsorySummary(ParameterSet pset);
	
	/**
	 * 修改优待金总额
	 */
	public void updateNonCompuSumm(ParameterSet pset);
}

