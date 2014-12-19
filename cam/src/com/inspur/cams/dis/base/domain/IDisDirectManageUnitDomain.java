package com.inspur.cams.dis.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.dis.base.data.DisDirectManageUnit;

/**
 * 直管单位配置表domain
 * @author 
 * @date 2012-11-19
 */
public interface IDisDirectManageUnitDomain {

	/**
	 * 查询 直管单位配置表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 直管单位配置表
	 * @param pset
	 * @return
	 */
	public DisDirectManageUnit get(String rId);

	/**
	 * 增加 直管单位配置表
	 * @param disDirectManageUnit
	 */
	@Trans
	public void insert(DisDirectManageUnit disDirectManageUnit);
	
	/**
	 * 修改 直管单位配置表
	 * @param disDirectManageUnit
	 */
	@Trans
	public void update(DisDirectManageUnit disDirectManageUnit);
	
	/**
	 * 删除 直管单位配置表
	 * @param rId
	 */
	@Trans
	public void delete(String rId);
	
	/**
	 * 保存
	 * @param pset
	 */
	@Trans
	public void save(ParameterSet pset);
	
	/**
	 * 删除（将inUse字段改为0，并为删除数据库）
	 */
	@Trans
	public void deleteInUse(ParameterSet pset);

	
	/**
	 * @Description: 查询指定单位下的所有直属单位
	 * @author xuexzh
	 */
	public DataSet queryAllUnit(ParameterSet pset);

}