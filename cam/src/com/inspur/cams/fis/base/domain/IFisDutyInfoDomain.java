package com.inspur.cams.fis.base.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.fis.base.data.FisDutyInfo;

/**
 * @Path com.inspur.cams.fis.base.domain.IFisDutyInfoDomain
 * @Description: TODO 殡葬业务人员岗位信息表Domain的接口
 * @author jiangzhaobao
 * @date 2011-11-15
 */
public interface IFisDutyInfoDomain {

	public DataSet query(ParameterSet pset);

	@Trans
	public void save(List<FisDutyInfo> list);

	@Trans
	public void insert(FisDutyInfo bean);

	@Trans
	public void update(FisDutyInfo bean);

	@Trans
	public void delete(String key);

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
