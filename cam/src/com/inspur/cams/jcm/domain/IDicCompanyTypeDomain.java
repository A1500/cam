package com.inspur.cams.jcm.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.jcm.data.DicCompanyType;

/**
 * 单位所属类别domain
 * @author 
 * @date 2014-05-21
 */
public interface IDicCompanyTypeDomain {

	/**
	 * 查询 单位所属类别
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 单位所属类别
	 * @param pset
	 * @return
	 */
	public DicCompanyType get(String code);

	/**
	 * 增加 单位所属类别
	 * @param dicCompanyType
	 */
	@Trans
	public void insert(DicCompanyType dicCompanyType);
	
	/**
	 * 修改 单位所属类别
	 * @param dicCompanyType
	 */
	@Trans
	public void update(DicCompanyType dicCompanyType);
	
	/**
	 * 删除 单位所属类别
	 * @param code
	 */
	@Trans
	public void delete(String code);
	
	/**
	 * 保存 字典
	 * @param code
	 */
	@Trans
	public void save(List equList,List comList,List monList);

}