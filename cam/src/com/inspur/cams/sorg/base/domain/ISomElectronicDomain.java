package com.inspur.cams.sorg.base.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.sorg.base.data.SomElectronic;

/**
 * 社会组织电子档案domain接口
 * @author Muqi
 * @date 2011年7月19日10:13:14
 */
public interface ISomElectronicDomain {
	
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
	 * 通过sql查询归档阶段法律要件信息（用于普通法律要件归档查询）
	 * @param pset
	 * @return
	 */
	public DataSet queryArchiveCatalogBySql(ParameterSet pset);
	/**
	 * 通过sql查询人员法律要件信息（用于人员法律要件拼装法律要件列表）
	 * @param pset
	 * @return
	 */
	public DataSet queryPeopleCatalogBySql(ParameterSet pset);
	/**
	 * 通过sql查询人员Electronic信息（用于人员法律要件上传/删除列表）
	 * @param pset
	 * @return
	 */
	public DataSet queryPeopleElectronic(ParameterSet pset);
	
	/**
	 * 保存上传文件到数据库
	 * @param catalogCode
	 * @param list
	 */
	@Trans
	public void uploadSave(List<SomElectronic> list);
	/**
	 * 通过主键删除档案文件
	 * @param list
	 */
	@Trans
	public void deleteById(String electronicId);
	
	/**
	 * 删除SOM_ELECTRONIC和SOM_DUTY_ELECTRONIC
	 * @param somElectronic
	 */
	@Trans
	public void delElectronicAndDutyElectronic(SomElectronic somElectronic);
	/**
	 * 删除法定代表人的SOM_ELECTRONIC和SOM_DUTY_ELECTRONIC
	 * @param somElectronic
	 */
	@Trans
	public void delLegalElectronicAndDutyElectronic(ParameterSet pset);
	/**
	 * 变更中单个保存文件
	 * @param somElectronic
	 */
	@Trans
	public void insert(SomElectronic somElectronic);
	
	/**
	 * 上传印章备案
	 * @param list
	 */
	@Trans
	public void batchInsert(List<SomElectronic> list);
	
	/**
	 * 根据sorgId查询社会组织的所有档案
	 * @param pset
	 * @return
	 */
	public DataSet queryElectronicBySorgId(ParameterSet pset);
	
	/**
	 * 档案管理中保存档案件号方法
	 * @param somElectronicRecords
	 */
	public void savePieceNumber(Record[] somElectronicRecords);
	
	/**
	 * 更新电子档案方法
	 * @param bean
	 */
	public void update(SomElectronic bean);
	/**
	 * 只查询电子档案表方法
	 * @param pset
	 * @return
	 */
	public DataSet queryElectronicOnly(ParameterSet pset);
	/**
	 * 通过taskCode更新sorgId
	 */
	@Trans
	public void updateSorgId(String sorgId, String taskCode);
	/**
	 * 选择已经上传的附件生成中间表
	 */
	@Trans
	public void saveExistFile(String dutyId, String electronicId);
}
