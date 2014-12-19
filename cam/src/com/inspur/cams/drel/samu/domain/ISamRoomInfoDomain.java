package com.inspur.cams.drel.samu.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.samu.data.SamRoomInfo;

/**
 * 房间信息domain
 * @author 
 * @date 2012-09-26
 */
public interface ISamRoomInfoDomain {

	/**
	 * 查询 房间信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 房间信息
	 * @param pset
	 * @return
	 */
	public SamRoomInfo get(String roomId);

	/**
	 * 增加 房间信息
	 * @param samRoomInfo
	 */
	@Trans
	public void insert(SamRoomInfo samRoomInfo);
	
	/**
	 * 修改 房间信息
	 * @param samRoomInfo
	 */
	@Trans
	public void update(SamRoomInfo samRoomInfo);
	
	/**
	 * 删除 房间信息
	 * @param roomId
	 */
	@Trans
	public void delete(String roomId);

}