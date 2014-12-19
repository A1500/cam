package com.inspur.cams.sorg.base.domain.support;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.sorg.base.dao.ISomElectronicDao;
import com.inspur.cams.sorg.base.data.SomAspchief;
import com.inspur.cams.sorg.base.data.SomElectronic;
import com.inspur.cams.sorg.base.domain.ISomElectronicDomain;

/**
 * 社会组织电子档案domain实现类
 * @author Muqi
 * @date 2011-5-17
 */
public class SomElectronicDomain implements ISomElectronicDomain {
	@Reference
	private ISomElectronicDao somElectronicDao;

	/**
	 * 查询电子档案信息
	 */
	public DataSet query(ParameterSet pset) {
		return somElectronicDao.queryElectronicBySql(pset);
	}
	public DataSet queryElectronic(ParameterSet pset){
		return somElectronicDao.queryElectronic(pset);
	}
	
	public DataSet queryElectronicOnly(ParameterSet pset){
		return somElectronicDao.query(pset);
	}
	/**
	 * 通过sql查询登记阶段法律要件信息
	 */
	public DataSet queryCatalogBySql(ParameterSet pset) {
		return somElectronicDao.queryCatalogBySql(pset);
	}
	
	/**
	 * 通过sql查询归档阶段法律要件信息
	 */
	public DataSet queryArchiveCatalogBySql(ParameterSet pset) {
		return somElectronicDao.queryArchiveCatalogBySql(pset);
	}

	/**
	 * 通过sql查询人员法律要件信息
	 */
	public DataSet queryPeopleCatalogBySql(ParameterSet pset) {
		return somElectronicDao.queryPeopleCatalogBySql(pset);
	}
	/**
	 * 通过sql查询人员Electronic信息
	 */
	public DataSet queryPeopleElectronic(ParameterSet pset) {
		return somElectronicDao.queryPeopleElectronicBySql(pset);
	}
	/**
	 * 保存上传文件到数据库
	 */
	public void uploadSave(List<SomElectronic> list) {
		for (int i = 0; i < list.size(); i++) {
			SomElectronic bean = list.get(i);
			String dutyId = bean.getDutyId();
			if(dutyId!=null && !("".equals(dutyId))){
				somElectronicDao.insertSomDutyElectronicBySql(dutyId,bean.getElectronicId());
			}
		}
		somElectronicDao.batchInsert(list);
	}
	/**
	 * 通过主键删除档案文件
	 */
	public void deleteById(String electronicId) {
		somElectronicDao.deleteById(electronicId);
	}
	/**
	 * 删除SOM_ELECTRONIC和SOM_DUTY_ELECTRONIC
	 */
	public void delElectronicAndDutyElectronic(SomElectronic somElectronic){
		String electronicId = somElectronic.getElectronicId();
		String dutyId = somElectronic.getDutyId();
		if(electronicId!=null && !("".equals(electronicId)) && dutyId!=null && !("".equals(dutyId))){
			deleteById(electronicId);
			somElectronicDao.deleteSomDutyElectronicBySql(dutyId,electronicId);
		}
	}
	/**
	 * 删除法定代表人的SOM_ELECTRONIC和SOM_DUTY_ELECTRONIC
	 */
	public void delLegalElectronicAndDutyElectronic(ParameterSet pset){
		String taskCode = (String) pset.getParameter("taskCode");
		String fileCodes = (String) pset.getParameter("fileCodes");
		String dutyId = (String) pset.getParameter("dutyId");
		Map<String, String> map = new HashMap<String, String>();
		if(taskCode!=null && !("".equals(taskCode))){
			map.put("TASK_CODE@=", taskCode);
		}
		if(fileCodes!=null && !("".equals(fileCodes))){
			map.put("FILE_CODE@in", fileCodes);
		}
		List<SomElectronic> list = somElectronicDao.queryNoPage(map);
		for (int i = 0; i < list.size(); i++) {
			SomElectronic bean = list.get(i);
			bean.setDutyId(dutyId);
			delElectronicAndDutyElectronic(bean);
		}
	}
	/**
	 * 插入一个电子档案信息
	 */
	public void insert(SomElectronic somElectronic) {	
		 somElectronicDao.insert(somElectronic);
	}
	/**
	 * 上传印章备案
	 */
	public void batchInsert(List<SomElectronic> list) {
		somElectronicDao.batchInsert(list);
		
	}
	
	/**
	 * 更新
	 */
	public void update(SomElectronic bean) {
		somElectronicDao.update(bean);
		
	}
	
	/**
	 * 根据sorgId查询社会组织的所有档案
	 * @param pset
	 * @return
	 */
	public DataSet queryElectronicBySorgId(ParameterSet pset){
		return somElectronicDao.queryElectronicBySorgId(pset);
	}
	
	/**
	 * 档案管理中保存档案件号方法
	 * @param somElectronicRecords
	 */
	public void savePieceNumber(Record[] somElectronicRecords){
		//先处理一条目录里的
		for(int somElectronicRecordNum = 0; somElectronicRecordNum < somElectronicRecords.length; somElectronicRecordNum++){
			SomElectronic somElectronic = (SomElectronic)somElectronicRecords[somElectronicRecordNum].toBean(SomElectronic.class);
			String pieceNumber = somElectronic.getPieceNumber();
			String idx[] = somElectronic.getElectronicId().split(";");
			//一个目录里会有多条
			for(int idxNum = 0; idxNum<idx.length; idxNum++){
				ParameterSet pset = new ParameterSet();
				pset.setParameter("ELECTRONIC_ID", idx[idxNum]);
				//此处没调用根据id精确查询方法，用的dao的query方法，查出来应为1条
				List<SomElectronic> electronicDSList = somElectronicDao.query(pset).toListBean(SomElectronic.class);
				if(electronicDSList.size()>0){
					SomElectronic somElectronicFromDatabase = electronicDSList.get(0);
					somElectronicFromDatabase.setPieceNumber(pieceNumber);
					somElectronicDao.update(somElectronicFromDatabase);
				}
			}
			
		}
	}
	public void updateSorgId(String sorgId, String taskCode){
		somElectronicDao.updateSorgId(sorgId, taskCode);
	}
	public void saveExistFile(String dutyId, String electronicId) {
		somElectronicDao.insertSomDutyElectronicBySql(dutyId,electronicId);
	}
}
