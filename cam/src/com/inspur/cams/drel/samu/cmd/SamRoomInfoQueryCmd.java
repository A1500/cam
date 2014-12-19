package com.inspur.cams.drel.samu.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.samu.domain.ISamRoomInfoDomain;

/**
 * 房间信息查询cmd
 * @author 
 * @date 2012-09-26
 */
public class SamRoomInfoQueryCmd extends BaseQueryCommand {

	private ISamRoomInfoDomain samRoomInfoDomain = ScaComponentFactory
			.getService(ISamRoomInfoDomain.class, "samRoomInfoDomain/samRoomInfoDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return samRoomInfoDomain.query(pset);
	}
	
}