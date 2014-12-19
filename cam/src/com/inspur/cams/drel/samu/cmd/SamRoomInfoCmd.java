package com.inspur.cams.drel.samu.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.samu.data.SamRoomInfo;
import com.inspur.cams.drel.samu.domain.ISamRoomInfoDomain;
import com.inspur.cams.prs.prsTrainDic.dao.DicPrsTrainField;

/**
 * 房间信息cmd
 * @author 
 * @date 2012-09-26
 */
public class SamRoomInfoCmd extends BaseAjaxCommand {

	private ISamRoomInfoDomain samRoomInfoDomain = ScaComponentFactory
			.getService(ISamRoomInfoDomain.class, "samRoomInfoDomain/samRoomInfoDomain");
	
	// 增加
	public void insert() {
		String roomId=IdHelp.getUUID32();
		Record record = (Record) getParameter("record");
		record.set("roomId", roomId);
		SamRoomInfo samRoomInfo = (SamRoomInfo) record.toBean(SamRoomInfo.class);
		samRoomInfoDomain.insert(samRoomInfo);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		SamRoomInfo samRoomInfo = (SamRoomInfo) record.toBean(SamRoomInfo.class);
		samRoomInfoDomain.update(samRoomInfo);
	}
	
	// 删除
	public void delete() {
		String roomId = (String) getParameter("roomId");
		samRoomInfoDomain.delete(roomId);
	}
	public void save(){
		Record[] records = (Record[]) getParameter("records");
		for (int i = 0; i < records.length; i++) {
			String roomId=IdHelp.getUUID32();
			records[i].set("roomId",roomId);
			SamRoomInfo SamRoomInfo = (SamRoomInfo) records[i].toBean(SamRoomInfo.class);
			if (SamRoomInfo.getState()==Record.STATE_DELETED){
				samRoomInfoDomain.delete(roomId);
			}else if(SamRoomInfo.getState() == Record.STATE_MODIFIED){
				samRoomInfoDomain.update(SamRoomInfo);
			}else if(SamRoomInfo.getState()==Record.STATE_NEW){
				samRoomInfoDomain.insert(SamRoomInfo);
			}
		}
	}
	
}