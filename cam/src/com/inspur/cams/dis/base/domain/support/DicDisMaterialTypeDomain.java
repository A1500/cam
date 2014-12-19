package com.inspur.cams.dis.base.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.dis.base.dao.IDicDisMaterialTypeDao;
import com.inspur.cams.dis.base.data.DicDisMaterialType;
import com.inspur.cams.dis.base.domain.IDicDisMaterialTypeDomain;

/**
 * 救灾发放物资类型(字典)domain
 * @author 
 * @date 2012-11-05
 */
public class DicDisMaterialTypeDomain implements IDicDisMaterialTypeDomain {

	@Reference
	private IDicDisMaterialTypeDao dicDisMaterialTypeDao;

	/**
	 * 查询 救灾发放物资类型(字典)
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return dicDisMaterialTypeDao.query(pset);
	}

	/**
	 * 获取 救灾发放物资类型(字典)
	 * @param pset
	 * @return
	 */
	public DicDisMaterialType get(String code) {
		return dicDisMaterialTypeDao.get(code);
	}

	/**
	 * 增加 救灾发放物资类型(字典)
	 * @param dicDisMaterialType
	 */
	public void insert(DicDisMaterialType dicDisMaterialType) {
		dicDisMaterialTypeDao.insert(dicDisMaterialType);
	}
	
	/**
	 * 修改 救灾发放物资类型(字典)
	 * @param dicDisMaterialType
	 */
	public void update(DicDisMaterialType dicDisMaterialType) {
		dicDisMaterialTypeDao.update(dicDisMaterialType);
	}
	
	/**
	 * 删除 救灾发放物资类型(字典)
	 * @param code
	 */
	public void delete(String code) {
		dicDisMaterialTypeDao.delete(code);
	}
	
	/**
	 * 保存 救灾发放物资类型(字典)
	 * @param code
	 */
	public void save(List<DicDisMaterialType> args) {
		dicDisMaterialTypeDao.save(args);
	}
}