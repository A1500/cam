package com.inspur.cams.drel.samu.domain.support;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.baseinfo.data.BaseinfoFamily;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.samu.dao.ISamBedInfoDao;
import com.inspur.cams.drel.samu.dao.ISamGerocomiumInfoDao;
import com.inspur.cams.drel.samu.dao.ISamRoomInfoDao;
import com.inspur.cams.drel.samu.dao.ISamWorkerInfoDao;
import com.inspur.cams.drel.samu.data.SamBedInfo;
import com.inspur.cams.drel.samu.data.SamGerocomiumInfo;
import com.inspur.cams.drel.samu.data.SamRoomInfo;
import com.inspur.cams.drel.samu.data.SamWorkerInfo;
import com.inspur.cams.drel.samu.domain.ISamGerocomiumInfoDomain;

/**
 * 敬老院基础信息domain
 * @author 
 * @date 2012-09-26
 */
public class SamGerocomiumInfoDomain implements ISamGerocomiumInfoDomain {

	@Reference
	private ISamGerocomiumInfoDao samGerocomiumInfoDao;
	@Reference
	private ISamRoomInfoDao samRoomInfoDao;
	@Reference
	private ISamBedInfoDao samBedInfoDao;
	@Reference
	private ISamWorkerInfoDao samWorkerInfoDao;
	/**
	 * 查询 敬老院基础信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return samGerocomiumInfoDao.query(pset);
	}

	/**
	 * 获取 敬老院基础信息
	 * @param pset
	 * @return
	 */
	public SamGerocomiumInfo get(String gerocomiumId) {
		return samGerocomiumInfoDao.get(gerocomiumId);
	}

	/**
	 * 增加 敬老院基础信息
	 * @param samGerocomiumInfo
	 */
	public void insert(SamGerocomiumInfo samGerocomiumInfo) {
		samGerocomiumInfoDao.insert(samGerocomiumInfo);
	}
	
	/**
	 * 修改 敬老院基础信息
	 * @param samGerocomiumInfo
	 */
	public void update(SamGerocomiumInfo samGerocomiumInfo) {
		samGerocomiumInfoDao.update(samGerocomiumInfo);
	}
	
	/**
	 * 删除 敬老院基础信息
	 * @param gerocomium Id
	 */
	public void delete(String gerocomiumId) {
		samGerocomiumInfoDao.delete(gerocomiumId);
	}
	/**
	 * 删除 敬老院基础信息所有
	 * @param gerocomium Id
	 */
	public void deleteAll(String gerocomiumId) {
		samGerocomiumInfoDao.deleteAll(gerocomiumId);
	}
	/**
	 * 查询 登记名册敬老院选项
	 * @param pset
	 * @return
	 */
	public DataSet queryGero(ParameterSet pset) {
		return samGerocomiumInfoDao.queryGero(pset);
	}
	/**
	 * 更新老年份是否当前状态
	 * @param 
	 */
	public void updateOldYear(String recordId) {
		samGerocomiumInfoDao.updateOldYear(recordId);
	}
	/**
	 * 更新敬老院基础信息所有
	 * @param gerocomium Id
	 */
	public void updateGerocomium(Record recordGerocomium,Record[] recordRoom,Record[] recordBed,Record[] recordWorker) {
		SamGerocomiumInfo samGerocomiumInfo = (SamGerocomiumInfo) recordGerocomium.toBean(SamGerocomiumInfo.class);
		samGerocomiumInfoDao.update(samGerocomiumInfo);
		if (recordRoom != null) {
			List<SamRoomInfo> samRoomInfoList = new ArrayList<SamRoomInfo>();
			for (int i = 0; i < recordRoom.length; i++) {
				SamRoomInfo samRoomInfo = (SamRoomInfo) recordRoom[i].toBean(SamRoomInfo.class);
				samRoomInfo.setGerocomiumId(samGerocomiumInfo.getGerocomiumId());
				samRoomInfoList.add(samRoomInfo);
				//if(samRoomInfo.getRoomId()==null || "".equals(samRoomInfo.getRoomId())){
					//samRoomInfo.setGerocomiumId(samGerocomiumInfo.getGerocomiumId());
					//samRoomInfo.setRoomId(IdHelp.getUUID32());
					//samRoomInfoDao.insert(samRoomInfo);
				//}else{
					//samRoomInfoDao.update(samRoomInfo);
				//}
			}
			samRoomInfoDao.save(samRoomInfoList);
		}
		if (recordBed != null) {
			for (int i = 0; i < recordBed.length; i++) {
				SamBedInfo samBedInfo = (SamBedInfo) recordBed[i].toBean(SamBedInfo.class);
				if(samBedInfo.getBedId()==null || "".equals(samBedInfo.getBedId())){
					samBedInfo.setBedId(IdHelp.getUUID32());
					samBedInfoDao.insert(samBedInfo);
				}else{
					samBedInfoDao.update(samBedInfo);
				}
			}
		}
		if (recordWorker != null) {
			for (int i = 0; i < recordWorker.length; i++) {
				SamWorkerInfo samWorkerInfo = (SamWorkerInfo) recordWorker[i].toBean(SamWorkerInfo.class);
				if(samWorkerInfo.getWorkerId()==null || "".equals(samWorkerInfo.getWorkerId())){
					samWorkerInfo.setGerocomiumId(samGerocomiumInfo.getGerocomiumId());
					samWorkerInfo.setWorkerId(IdHelp.getUUID32());
					samWorkerInfoDao.insert(samWorkerInfo);
					
				}else{
					samWorkerInfoDao.update(samWorkerInfo);	
				}
			}
		}
	}
	
	/**
	 * 保存敬老院基础信息所有
	 * @param gerocomium Id
	 */
	public void saveGerocomium(Record recordGerocomium,Record[] recordRoom,Record[] recordBed,Record[] recordWorker,String recordId){
		SamGerocomiumInfo samGerocomiumInfo = (SamGerocomiumInfo) recordGerocomium.toBean(SamGerocomiumInfo.class);
		if(recordId==null){
			samGerocomiumInfo.setRecordId(IdHelp.getUUID32());
			samGerocomiumInfoDao.insert(samGerocomiumInfo);
			Record returnGerocomium = new Record(samGerocomiumInfo);
			if (recordRoom != null) {
				for (int i = 0; i < recordRoom.length; i++) {
					SamRoomInfo samRoomInfo = (SamRoomInfo) recordRoom[i].toBean(SamRoomInfo.class);
					//samRoomInfo.setRoomId(IdHelp.getUUID32());
					samRoomInfoDao.insert(samRoomInfo);
				}
			}
			if(recordBed!=null){
				for(int j = 0; j < recordBed.length; j++){
					SamBedInfo samBedInfo = (SamBedInfo) recordBed[j].toBean(SamBedInfo.class);
					samBedInfo.setBedId(IdHelp.getUUID32());
					samBedInfoDao.insert(samBedInfo);
				}
			}
		//	Record[] returnWorker=null;
			if (recordWorker != null) {
				for (int i = 0; i < recordWorker.length; i++) {
					SamWorkerInfo samWorkerInfo = (SamWorkerInfo) recordWorker[i].toBean(SamWorkerInfo.class);
					samWorkerInfo.setWorkerId(IdHelp.getUUID32());
					samWorkerInfoDao.insert(samWorkerInfo);
			//		returnWorker[i]=new Record(samWorkerInfo);
				}
			}
		}else{
			samGerocomiumInfoDao.updateOldYear(recordId);
			samGerocomiumInfo.setRecordId(IdHelp.getUUID32());
			samGerocomiumInfo.setIfCurrent("1");
			samGerocomiumInfoDao.insert(samGerocomiumInfo);
			if (recordRoom != null) {
				List<SamRoomInfo> samRoomInfoList = new ArrayList<SamRoomInfo>();
				for (int i = 0; i < recordRoom.length; i++) {
					SamRoomInfo samRoomInfo = (SamRoomInfo) recordRoom[i].toBean(SamRoomInfo.class);
					samRoomInfo.setGerocomiumId(samGerocomiumInfo.getGerocomiumId());
					samRoomInfoList.add(samRoomInfo);
//					if(samRoomInfo.getRoomId()==null || "".equals(samRoomInfo.getRoomId())){
//						samRoomInfo.setGerocomiumId(samGerocomiumInfo.getGerocomiumId());
//						//samRoomInfo.setRoomId(IdHelp.getUUID32());
//						samRoomInfoDao.insert(samRoomInfo);
//					}else{
//						samRoomInfoDao.update(samRoomInfo);
//					}
				}
				samRoomInfoDao.save(samRoomInfoList);
			}
			if (recordBed != null) {
				for (int i = 0; i < recordBed.length; i++) {
					SamBedInfo samBedInfo = (SamBedInfo) recordBed[i].toBean(SamBedInfo.class);
					if(samBedInfo.getBedId()==null || "".equals(samBedInfo.getBedId())){
						samBedInfo.setBedId(IdHelp.getUUID32());
						samBedInfoDao.insert(samBedInfo);
					}else{
						samBedInfoDao.update(samBedInfo);
					}
				}
			}
			if (recordWorker != null) {
				for (int i = 0; i < recordWorker.length; i++) {
					SamWorkerInfo samWorkerInfo = (SamWorkerInfo) recordWorker[i].toBean(SamWorkerInfo.class);
					if(samWorkerInfo.getWorkerId()==null || "".equals(samWorkerInfo.getWorkerId())){
						samWorkerInfo.setGerocomiumId(samGerocomiumInfo.getGerocomiumId());
						samWorkerInfo.setWorkerId(IdHelp.getUUID32());
						samWorkerInfoDao.insert(samWorkerInfo);
						
					}else{
						samWorkerInfoDao.update(samWorkerInfo);	
					}
				}
			}
		}
		
	}
	/**
	 * 敬老院基本情况统计
	 * @param pset
	 * @return
	 */
	public DataSet reportGeroInfo(ParameterSet pset){
		
		DataSet ds = samGerocomiumInfoDao.reportGeroInfo(pset);
		DataSet ds1 = samGerocomiumInfoDao.count1(pset);
		DataSet ds2 = samGerocomiumInfoDao.count2(pset);
		for(int c = 0 ;c<ds1.getCount();c++){
		for(int i = 0 ;i<ds1.getCount();i++){
			for(int j=0;j<ds2.getCount();j++){
				for(int k=0;k<ds.getCount();k++){
				Record re1 = ds1.getRecord(i);
				String code1 =(re1.get("AREA_LEVEL_CODE")!=null?re1.get("AREA_LEVEL_CODE"):"0").toString();
				String a = (re1.get("UN_NUM_SUM")!=null?re1.get("UN_NUM_SUM"):"0").toString();
				float Fa=Float.parseFloat(a);
				
				Record re2= ds2.getRecord(j);
				String code2 =(re2.get("AREA_LEVEL_CODE")!=null?re2.get("AREA_LEVEL_CODE"):"0").toString();
				String b = (re2.get("IN_NUM_SUM")!=null?re2.get("IN_NUM_SUM"):"0").toString();
				float Fb=Float.parseFloat(b);
				
				Record re= ds.getRecord(k);
				String code= (re.get("AREA_LEVEL_CODE")!=null?re.get("AREA_LEVEL_CODE"):"0").toString();
				
				if(code.equals(code2)){
				if(code1.equals(code2)){
					if(Fb+Fa==0){
						float keptRate=0;
						re.set("KEPT_RATE",keptRate);
						}
					else
					{
						float keptRate=Fb/(Fb+Fa);
						re.set("KEPT_RATE",keptRate);
					}
				
						}
					}
				}			
			}
		}
	}
		return ds;
	}

	public SamGerocomiumInfo savesamGerocomiumInfo(String recordId,
			SamGerocomiumInfo samGerocomiumInfo, Record[] recordWorker) {
		if(recordId==null){
			samGerocomiumInfo.setRecordId(IdHelp.getUUID32());
			samGerocomiumInfoDao.insert(samGerocomiumInfo);
		//	Record[] returnWorker=null;
			if (recordWorker != null) {
				for (int i = 0; i < recordWorker.length; i++) {
					SamWorkerInfo samWorkerInfo = (SamWorkerInfo) recordWorker[i].toBean(SamWorkerInfo.class);
					samWorkerInfo.setWorkerId(IdHelp.getUUID32());
					samWorkerInfoDao.insert(samWorkerInfo);
				//	returnWorker[i]=new Record(samWorkerInfo);
				}
			}
		}else{
			samGerocomiumInfoDao.updateOldYear(recordId);
			samGerocomiumInfo.setRecordId(IdHelp.getUUID32());
			samGerocomiumInfo.setIfCurrent("1");
			samGerocomiumInfoDao.insert(samGerocomiumInfo);
			if (recordWorker != null) {
				for (int i = 0; i < recordWorker.length; i++) {
					SamWorkerInfo samWorkerInfo = (SamWorkerInfo) recordWorker[i].toBean(SamWorkerInfo.class);
					if(samWorkerInfo.getWorkerId()==null || "".equals(samWorkerInfo.getWorkerId())){
						samWorkerInfo.setGerocomiumId(samGerocomiumInfo.getGerocomiumId());
						samWorkerInfo.setWorkerId(IdHelp.getUUID32());
						samWorkerInfoDao.insert(samWorkerInfo);
						
					}else{
						samWorkerInfoDao.update(samWorkerInfo);	
					}
				}
			}
		}
		return samGerocomiumInfo;
		
	}
}