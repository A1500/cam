package com.inspur.cams.fis.base.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.fis.base.data.FisDutyInfo;

/**
 * @Path com.inspur.cams.fis.base.dao.IFisDutyInfoDao  
 * @Description: TODO 殡葬业务人员岗位信息表Dao的接口
 * @author jiangzhaobao
 * @date 2011-11-15
 */
 public interface IFisDutyInfoDao extends BaseCURD<FisDutyInfo>{
	public void save(List<FisDutyInfo> list);
	//public void delete(String key);

	/**
	* @Title: queryForExport
	* @Description: TODO(数据上报导出数据方法)
	* @param set
	* @return DataSet  
	* @throws
	* @author luguosui
	 */
	public DataSet queryForExport(ParameterSet set);
}

