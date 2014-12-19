package com.inspur.cams.dis.base.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.dis.base.data.DicDisMaterialType;

/**
 * 救灾发放物资类型(字典)domain
 * @author 
 * @date 2012-11-05
 */
public interface IDicDisMaterialTypeDomain {

	/**
	 * 查询 救灾发放物资类型(字典)
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 救灾发放物资类型(字典)
	 * @param pset
	 * @return
	 */
	public DicDisMaterialType get(String code);

	/**
	 * 增加 救灾发放物资类型(字典)
	 * @param dicDisMaterialType
	 */
	@Trans
	public void insert(DicDisMaterialType dicDisMaterialType);
	
	/**
	 * 修改 救灾发放物资类型(字典)
	 * @param dicDisMaterialType
	 */
	@Trans
	public void update(DicDisMaterialType dicDisMaterialType);
	
	/**
	 * 删除 救灾发放物资类型(字典)
	 * @param code
	 */
	@Trans
	public void delete(String code);

	/**
	 * 保存 救灾发放物资类型(字典)
	 * @param code
	 */
	@Trans
	public void save(List<DicDisMaterialType> args);
}