package com.inspur.sdmz.jzfa.dao;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.sdmz.jzfa.data.Detail;

/**
 * 救助方案明细Dao接口
 * @author shgtch
 * @date 2011-4-16
 */
public interface IDetailDao {

	/**
	 * 增加一条救助方案明细
	 * @param jzfamx
	 */
	public void addJzfamx(Detail jzfamx);
	
	/**
	 * 修改一条救助方案明细
	 * @param jzfamx
	 */
	public void updateJzfamx(Detail jzfamx);
	
	/**
	 * 删除一条救助方案明细
	 * @param jzfamxid
	 */
	public void deleteJzfamx(String jzfamxid);
	
	/**
	 * 通过救助方案ID删除救助方案明细
	 * @param jzfaid
	 */
	public void deleteJzfamxByJzfaid(String jzfaid);
	
	/**
	 * 查询救助方案明细
	 * @param pset
	 * @return
	 */
	public DataSet jzfamxQuery(ParameterSet pset);
	
	/**
	 * 根据救助方案内码查询救助方案明细
	 * @param jzfaid
	 * @return
	 */
	public DataSet jzfamxQueryByJzfaid(String jzfaid);
	
	/**
	 * 明细数据统计
	 * @return
	 */
	//public DataSet sjtjmx(String jzfaid);
	public DataSet sjtjmx(ParameterSet params,String jzfaid);
	
	/**
	 * 根据身份证号查询审核通过的家庭ID
	 * @param sfzh
	 * @return
	 */
	public String getCheckedJtidBysfzh(String sfzh);
	/**
	 * 根据身份证号查询审核通过的家庭ID
	 * @param sfzh
	 * @return
	 */
	//public DataSet jzfaCfjz(ParameterSet pset);
	
	public DataSet jzfaCfjz(ParameterSet pset,String planId);
	
	/**
	 * 查询受助人在其他救助方案中的信息
	 * @param pset
	 * @return
	 */
	public DataSet queryOtherAssisted(ParameterSet pset);
}
