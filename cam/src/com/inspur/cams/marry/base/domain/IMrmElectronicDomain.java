package com.inspur.cams.marry.base.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.marry.base.data.MrmElectronic;

/**
 * 婚姻电子档案domain接口
 */
public interface IMrmElectronicDomain {
	
	/**
	 * 查询电子档案信息（用于普通法律要件上传/删除列表）
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);
	/**
	 * 通过sql查询下载列表
	 * @param pset
	 * @return
	 */
	public DataSet queryElectronic(ParameterSet pset);
	/**
	 * 通过sql查询登记阶段法律要件信息（用于普通法律要件拼装法律要件列表）
	 * @param pset
	 * @return
	 */
	public DataSet queryCatalogBySql(ParameterSet pset);
	
	/**
	 * 保存上传文件到数据库
	 * @param catalogCode
	 * @param list
	 */
	@Trans
	public void uploadSave(List<MrmElectronic> list);
	/**
	 * 删除
	 */
	@Trans
	public void delete(String electronicId);
	/**
	 * 根据applyId删除
	 */
	@Trans
	public void delByApplyId(String applyId);
	
	/**
	 * 变更中单个保存文件
	 * @param mrmElectronic
	 */
	@Trans
	public void insert(MrmElectronic mrmElectronic);
	
	/**
	 * 上传印章备案
	 * @param list
	 */
	@Trans
	public void batchInsert(List<MrmElectronic> list);
	
	/**
	 * 根据deptId查询
	 * @param pset
	 * @return
	 */
	public DataSet queryElectronicByDeptId(ParameterSet pset);
	
	/**
	 * 档案管理中保存档案件号方法
	 * @param mrmElectronicRecords
	 */
	public void savePieceNumber(Record[] mrmElectronicRecords);
	
	/**
	 * 更新电子档案方法
	 * @param bean
	 */
	public void update(MrmElectronic bean);
	/**
	 * 只查询电子档案表方法
	 * @param pset
	 * @return
	 */
	public DataSet queryElectronicOnly(ParameterSet pset);
}
