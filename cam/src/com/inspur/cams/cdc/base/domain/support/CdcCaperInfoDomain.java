package com.inspur.cams.cdc.base.domain.support;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.cdc.base.dao.ICdcCaperInfoDao;
import com.inspur.cams.cdc.base.data.CdcCaperInfo;
import com.inspur.cams.cdc.base.data.CdcVoluntaryCaperInfo;
import com.inspur.cams.cdc.base.data.CdcVoluntaryInfo;
import com.inspur.cams.cdc.base.domain.ICdcCaperInfoDomain;
import com.inspur.cams.cdc.base.domain.ICdcVoluntaryCaperInfoDomain;
import com.inspur.cams.cdc.base.domain.ICdcVoluntaryInfoDomain;
import com.inspur.cams.comm.util.IdHelp;

/**
 * 活动信息domain
 * 
 * @author
 * @date 2013-02-26
 */
@SuppressWarnings("unchecked")
public class CdcCaperInfoDomain implements ICdcCaperInfoDomain {

	@Reference
	private ICdcCaperInfoDao cdcCaperInfoDao;

	@Reference
	private ICdcVoluntaryInfoDomain cdcVoluntaryInfoDomain;

	@Reference
	private ICdcVoluntaryCaperInfoDomain cdcVoluntaryCaperInfoDomain;

	/**
	 * 查询 活动信息
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return cdcCaperInfoDao.query(pset);
	}

	/**
	 * 获取 活动信息
	 * 
	 * @param pset
	 * @return
	 */
	public CdcCaperInfo get(String caperId) {
		return cdcCaperInfoDao.get(caperId);
	}

	/**
	 * 增加 活动信息
	 * 
	 * @param cdcCaperInfo
	 */
	public void insert(CdcCaperInfo cdcCaperInfo) {
		cdcCaperInfoDao.insert(cdcCaperInfo);
		cdcVoluntaryCaperInfoDomain.batchInsert(cdcCaperInfo.getCdcVoluntaryCaperInfoList());
		cdcVoluntaryInfoDomain.updateCaperTimes(cdcCaperInfo.getCdcVoluntaryInfoList(),1); // 更新志愿者信息参加活动次数/时间
	}

	/**
	 * 修改 活动信息
	 * 
	 * @param cdcCaperInfo
	 */
	public void update(CdcCaperInfo cdcCaperInfo) {
		//先查询历史关系信息
		ParameterSet pset = new ParameterSet();
		pset.put("CAPER_ID", cdcCaperInfo.getCaperId());
		DataSet ds = cdcVoluntaryCaperInfoDomain.query(pset);
		if (ds.getCount() > 0) {
			// 获取原志愿者集合
			Map<String,Integer> ids = new HashMap<String,Integer>();
			int i = 0;
			for (; i < ds.getCount(); i++) {
				ids.put(ds.getRecord(i).get("voluntaryId").toString(), i);
			}

			// 遍历查重/否
			List<CdcVoluntaryInfo> addIds = new ArrayList<CdcVoluntaryInfo>();
			List<CdcVoluntaryInfo> modifyIds = new ArrayList<CdcVoluntaryInfo>();
			List<CdcVoluntaryInfo> removeIds = new ArrayList<CdcVoluntaryInfo>();
			for (i = 0; i < cdcCaperInfo.getCdcVoluntaryInfoList().size(); i++) {
				CdcVoluntaryInfo cdcVoluntaryInfo = cdcCaperInfo.getCdcVoluntaryInfoList().get(i);
				if (ids.containsKey(cdcVoluntaryInfo.getVoluntaryId())) {
					// 如果已存在，判断是否修改
					CdcVoluntaryCaperInfo cdcVoluntaryCaperInfo = (CdcVoluntaryCaperInfo) ds.getRecord(ids.get(cdcVoluntaryInfo.getVoluntaryId())).toBean(
							CdcVoluntaryCaperInfo.class);
					if (cdcVoluntaryCaperInfo.getStartTime().equals(cdcVoluntaryInfo.getStartTime()) && 
							cdcVoluntaryCaperInfo.getEndTime().equals(cdcVoluntaryInfo.getEndTime())
							&& cdcVoluntaryCaperInfo.getDiffTimes().longValue() == (cdcVoluntaryInfo.getTotalTimes().longValue())) {
						// 如果三个均相等，则代表未修改
					} else {
						// 如果三个不等，则代表已修改,先更新，并存入修改集合
						BigDecimal diffs = cdcVoluntaryInfo.getTotalTimes().subtract(cdcVoluntaryCaperInfo.getDiffTimes());
						cdcVoluntaryCaperInfo.setStartTime(cdcVoluntaryInfo.getStartTime());
						cdcVoluntaryCaperInfo.setEndTime(cdcVoluntaryInfo.getEndTime());
						cdcVoluntaryCaperInfo.setDiffTimes(cdcVoluntaryInfo.getTotalTimes());
						cdcVoluntaryCaperInfoDomain.update(cdcVoluntaryCaperInfo);
						cdcVoluntaryInfo.setTotalTimes(diffs);
						modifyIds.add(cdcVoluntaryInfo);
					}
					// 删除集合中对应ID
					ids.remove(cdcVoluntaryInfo.getVoluntaryId());
				} else {
					// 如果不存在，则需要新增
					addIds.add(cdcVoluntaryInfo);
				}
			}
			
			//查看剩余需要删除的ID
			Iterator<String> iterator = ids.keySet().iterator();
			while (iterator.hasNext()) {
				CdcVoluntaryCaperInfo cdcVoluntaryCaperInfo = (CdcVoluntaryCaperInfo) ds.getRecord(ids.get(iterator.next())).toBean(
						CdcVoluntaryCaperInfo.class);
				CdcVoluntaryInfo cdcVoluntaryInfo = new CdcVoluntaryInfo();
				cdcVoluntaryInfo.setVoluntaryId(cdcVoluntaryCaperInfo.getVoluntaryId());
				cdcVoluntaryInfo.setTotalTimes(cdcVoluntaryCaperInfo.getDiffTimes());
				removeIds.add(cdcVoluntaryInfo);
			}

			cdcCaperInfoDao.update(cdcCaperInfo);
			//分别对需要增加/删除的志愿者参加活动次数/时间
			cdcVoluntaryInfoDomain.updateCaperTimes(addIds, 1); // 更新志愿者信息参加活动次数/时间
			cdcVoluntaryInfoDomain.updateCaperTimes(removeIds, -1); // 更新志愿者信息参加活动次数/时间
			cdcVoluntaryInfoDomain.updateCaperTimes(modifyIds, 0); // 更新志愿者信息参加活动时间
			
			//删除/修改过期的志愿者参加活动记录
			for (i=0; i < ds.getCount(); i++) {
				CdcVoluntaryCaperInfo cdcVoluntaryCaperInfo = (CdcVoluntaryCaperInfo) ds.getRecord(i).toBean(CdcVoluntaryCaperInfo.class);
				if(ids.containsKey(cdcVoluntaryCaperInfo.getVoluntaryId())) {
					cdcVoluntaryCaperInfoDomain.delete(cdcVoluntaryCaperInfo.getRecordId());
				}
			}
			//增加过期的志愿者参加活动记录
			for (i=0; i < addIds.size(); i++) {
				CdcVoluntaryCaperInfo cdcVoluntaryCaperInfo = new CdcVoluntaryCaperInfo();
				cdcVoluntaryCaperInfo.setRecordId(IdHelp.getUUID32());
				cdcVoluntaryCaperInfo.setCaperId(cdcCaperInfo.getCaperId());
				cdcVoluntaryCaperInfo.setVoluntaryId(addIds.get(i).getVoluntaryId());
				cdcVoluntaryCaperInfo.setStartTime(addIds.get(i).getStartTime());
				cdcVoluntaryCaperInfo.setEndTime(addIds.get(i).getEndTime());
				cdcVoluntaryCaperInfo.setDiffTimes(addIds.get(i).getTotalTimes());
				cdcVoluntaryCaperInfoDomain.insert(cdcVoluntaryCaperInfo);
			}
		} else {
			//如果无历史信息，则直接增加
			cdcCaperInfoDao.update(cdcCaperInfo);
			cdcVoluntaryCaperInfoDomain.batchInsert(cdcCaperInfo.getCdcVoluntaryCaperInfoList());
			cdcVoluntaryInfoDomain.updateCaperTimes(cdcCaperInfo.getCdcVoluntaryInfoList(),1); // 更新志愿者信息参加活动次数/时间
		}
	}

	/**
	 * 删除 活动信息
	 * 
	 * @param caperId
	 */
	
	public void deleteCaper(String caperId) {
		ParameterSet pset = new ParameterSet();
		pset.put("CAPER_ID", caperId);
		DataSet ds = cdcVoluntaryCaperInfoDomain.query(pset);
		if (ds.getCount() > 0) {
			// 获取原志愿者集合
			List<CdcVoluntaryInfo> vIds = new ArrayList<CdcVoluntaryInfo>();
			int i = 0;
			for (; i < ds.getCount(); i++) {
				CdcVoluntaryCaperInfo cdcVoluntaryCaperInfo = (CdcVoluntaryCaperInfo) ds.getRecord(i).toBean(
						CdcVoluntaryCaperInfo.class);
				CdcVoluntaryInfo cdcVoluntaryInfo = new CdcVoluntaryInfo();
				cdcVoluntaryInfo.setVoluntaryId(cdcVoluntaryCaperInfo.getVoluntaryId());
				cdcVoluntaryInfo.setTotalTimes(cdcVoluntaryCaperInfo.getDiffTimes());
				vIds.add(cdcVoluntaryInfo);
			}
			cdcVoluntaryInfoDomain.updateCaperTimes(vIds, -1);// 更新志愿者信息参加活动次数-1
		}
		cdcVoluntaryCaperInfoDomain.deleteByCaper(caperId);
		cdcCaperInfoDao.delete(caperId);
	}

}