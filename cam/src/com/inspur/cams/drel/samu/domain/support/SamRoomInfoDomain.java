package com.inspur.cams.drel.samu.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.samu.dao.ISamRoomInfoDao;
import com.inspur.cams.drel.samu.data.SamRoomInfo;
import com.inspur.cams.drel.samu.domain.ISamRoomInfoDomain;

/**
 * 房间信息domain
 * @author 
 * @date 2012-09-26
 */
public class SamRoomInfoDomain implements ISamRoomInfoDomain {

	@Reference
	private ISamRoomInfoDao samRoomInfoDao;

	/**
	 * 查询 房间信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return samRoomInfoDao.query(pset);
	}

	/**
	 * 获取 房间信息
	 * @param pset
	 * @return
	 */
	public SamRoomInfo get(String roomId) {
		return samRoomInfoDao.get(roomId);
	}

	/**
	 * 增加 房间信息
	 * @param samRoomInfo
	 */
	public void insert(SamRoomInfo samRoomInfo) {
		samRoomInfoDao.insert(samRoomInfo);
	}
	
	/**
	 * 修改 房间信息
	 * @param samRoomInfo
	 */
	public void update(SamRoomInfo samRoomInfo) {
		samRoomInfoDao.update(samRoomInfo);
	}
	
	/**
	 * 删除 房间信息
	 * @param roomId
	 */
	public void delete(String roomId) {
		samRoomInfoDao.delete(roomId);
	}

}