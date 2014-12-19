package com.inspur.cams.marry.base.domain;

import java.math.BigDecimal;
import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.marry.base.data.MrmBasePerson;

/**
 * 婚登用户增加
 * @author shgtch
 * @date 2011-12-5
 */
public interface IMrmBasePersonDomain {
	
	/**
	 * 查询婚登用户
	 * @param pSet
	 * @return
	 */
	public DataSet query(ParameterSet pSet);
	
	/**
	 * 保存婚登用户
	 * @param mrmBasePerson
	 */
	@Trans
	public void insert(MrmBasePerson mrmBasePerson);
	
	/**
	 * 保存婚登用户
	 * @param mrmBasePerson
	 */
	@Trans
	public void insertAll(MrmBasePerson mrmBasePerson);
	
	/**
	 * 增加bsp用户
	 * @param mrmBasePerson
	 */
	@Trans
	public void insertBspUser(MrmBasePerson mrmBasePerson);
	
	/**
	 * 修改婚登用户
	 * @param mrmBasePerson
	 */
	@Trans
	public void update(MrmBasePerson mrmBasePerson);

	/**
	 * 批量修改婚登用户
	 * @param list
	 */
	@Trans
	public void batchUpdate(List<MrmBasePerson> list);

	/**
	 * 删除婚登用户
	 * @param delIds
	 */
	@Trans
	public void delete(String delIds);
	
	/**
	 * 添加婚登人员信息
	 */
	@Trans
	public void insertPerson(MrmBasePerson mrmBasePerson);
	
	/**
	 * 查询登记人员报名信息
	 */
	public DataSet examApplyDataSet(ParameterSet pSet);
	
	/**
	 * 升为颁证员
	 */
	public void updateBzy(MrmBasePerson mrmBasePerson);
	//登记员证号
	public void updateCertificate(MrmBasePerson mPerson);
	//办证员证号
	public void updateBzyzh(MrmBasePerson mPerson);
}
