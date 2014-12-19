package com.inspur.cams.bpt.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.bpt.base.data.BptRegularIdentification;

/**
 * 优抚人员定期认证Domain接口
 * @author 王宝才
 *
 */
public interface IBptRegularIdentificationDomain{
	
	/**
	 * 添加定期认证信息
	 * @param bptRegularIdentification
	 */
	public void insert(BptRegularIdentification bptRegularIdentification);
	
	/**
	 * 查询定期认证信息
	 */
	public DataSet queryRegularIdentification(ParameterSet pset);
	/**
	 * 查询是否认证
	 */
	public DataSet queryRI(ParameterSet pSet);
	
	/**
	 * 查询验证人员信息
	 */
	public DataSet queryRegIdenti(ParameterSet pset);
	/**
	 * 查询认证详细信息
	 */
	/*public DataSet queryRIdentification(ParameterSet pset);*/

	/**
	 * 更新验证人员信息
	 */
	public void updateRegIdenti(BptRegularIdentification bptRegularIdentification);
	/**
	 * 删除验证人员信息
	 */
	public void deleteRegIdenti(String[] delIds);
}