package com.inspur.cams.marry.base.domain.support;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.marry.base.dao.IMrmElectronicDao;
import com.inspur.cams.marry.base.data.MrmElectronic;
import com.inspur.cams.marry.base.domain.IMrmElectronicDomain;
import com.inspur.cams.comm.util.RecordToBeanUtil;

/**
 * 婚姻电子档案domain实现类
 */
public class MrmElectronicDomain implements IMrmElectronicDomain {
	@Reference
	private IMrmElectronicDao mrmElectronicDao;

	/**
	 * 查询电子档案信息
	 */
	public DataSet query(ParameterSet pset) {
		return RecordToBeanUtil.uppercaseToLowercase(mrmElectronicDao.queryElectronicBySql(pset));
	}
	public DataSet queryElectronic(ParameterSet pset){
		return RecordToBeanUtil.uppercaseToLowercase(mrmElectronicDao.queryElectronic(pset));
	}
	
	public DataSet queryElectronicOnly(ParameterSet pset){
		return mrmElectronicDao.query(pset);
	}
	/**
	 * 通过sql查询登记阶段法律要件信息
	 */
	public DataSet queryCatalogBySql(ParameterSet pset) {
		return mrmElectronicDao.queryCatalogBySql(pset);
	}
	

	/**
	 * 保存上传文件到数据库
	 */
	public void uploadSave(List<MrmElectronic> list) {
		for (int i = 0; i < list.size(); i++) {
			MrmElectronic bean = list.get(i);
			mrmElectronicDao.insert(bean);
		}
		
	}
	/**
	 * 根删除
	 */
	public void delete(String electronicId) {
		mrmElectronicDao.delete(electronicId);
	}
	/**
	 * 根据applyId删除
	 */
	public void delByApplyId(String applyId) {
		mrmElectronicDao.delByApplyId(applyId);
	}
	/**
	 * 插入一个电子档案信息
	 */
	public void insert(MrmElectronic mrmElectronic) {	
		 mrmElectronicDao.insert(mrmElectronic);
	}
	/**
	 * 上传印章备案
	 */
	public void batchInsert(List<MrmElectronic> list) {
		mrmElectronicDao.batchInsert(list);
		
	}
	
	/**
	 * 更新
	 */
	public void update(MrmElectronic bean) {
		mrmElectronicDao.update(bean);
		
	}
	
	/**
	 * 根据deptId查询
	 * @param pset
	 * @return
	 */
	public DataSet queryElectronicByDeptId(ParameterSet pset){
		return RecordToBeanUtil.uppercaseToLowercase(mrmElectronicDao.queryElectronicByDeptId(pset));
	}
	
	/**
	 * 档案管理中保存档案件号方法
	 * @param mrmElectronicRecords
	 */
	public void savePieceNumber(Record[] mrmElectronicRecords){
		//先处理一条目录里的
		for(int mrmElectronicRecordNum = 0; mrmElectronicRecordNum < mrmElectronicRecords.length; mrmElectronicRecordNum++){
			MrmElectronic mrmElectronic = (MrmElectronic)mrmElectronicRecords[mrmElectronicRecordNum].toBean(MrmElectronic.class);
			String idx[] = mrmElectronic.getElectronicId().split(";");
			//一个目录里会有多条
			for(int idxNum = 0; idxNum<idx.length; idxNum++){
				ParameterSet pset = new ParameterSet();
				pset.setParameter("ELECTRONIC_ID", idx[idxNum]);
				//此处没调用根据id精确查询方法，用的dao的query方法，查出来应为1条
				List<MrmElectronic> electronicDSList = mrmElectronicDao.query(pset).toListBean(MrmElectronic.class);
				if(electronicDSList.size()>0){
					MrmElectronic mrmElectronicFromDatabase = electronicDSList.get(0);
					mrmElectronicDao.update(mrmElectronicFromDatabase);
				}
			}
			
		}
	}

}
