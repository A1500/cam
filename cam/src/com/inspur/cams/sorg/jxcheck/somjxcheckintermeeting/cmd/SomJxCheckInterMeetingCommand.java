package com.inspur.cams.sorg.jxcheck.somjxcheckintermeeting.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.sorg.check.checksuborgan.data.SomCheckSuborgan;
import com.inspur.cams.sorg.jxcheck.somjxcheckintermeeting.dao.*;
import com.inspur.cams.sorg.jxcheck.somjxcheckinterorg.dao.SomJxCheckInterOrg;
import com.inspur.cams.sorg.jxcheck.somjxcheckinterorg.dao.SomJxCheckInterOrgDao;
import com.inspur.sdmz.comm.util.IdHelp;

/**
 * @title:SomJxCheckInterMeetingCommand
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
public class SomJxCheckInterMeetingCommand extends BaseAjaxCommand{
	//国际会议Dao
	private SomJxCheckInterMeetingDao meetingDao = (SomJxCheckInterMeetingDao) DaoFactory
			.getDao("com.inspur.cams.sorg.jxcheck.somjxcheckintermeeting.dao.SomJxCheckInterMeetingDao");
	//国际组织Dao
	private SomJxCheckInterOrgDao orgDao = (SomJxCheckInterOrgDao) DaoFactory
	.getDao("com.inspur.cams.sorg.jxcheck.somjxcheckinterorg.dao.SomJxCheckInterOrgDao");
	
	@Trans
	public void savePage19(){
		Record[] checkInterMeetingRecords = (Record[]) getParameter("somCheckInterMeetingRecords");
		Record[] checkInterOrgRecords = (Record[]) getParameter("somCheckInterOrgRecords");
		String taskCode=(String) getParameter("taskCode");
		//删除已有记录
		meetingDao.deleteByTaskCode(taskCode);
		orgDao.deleteByTaskCode(taskCode);
		if(checkInterMeetingRecords!=null){
			for (int i = 0; i < checkInterMeetingRecords.length; i++) {
				SomJxCheckInterMeeting  checkInterMeeting=(SomJxCheckInterMeeting)checkInterMeetingRecords[i].toBean(SomJxCheckInterMeeting.class);
				 checkInterMeeting.setId(IdHelp.getUUID32());
				 meetingDao.insert(checkInterMeeting);				
			}
		}
		if(checkInterOrgRecords!=null){
			for (int i = 0; i < checkInterOrgRecords.length; i++) {
				SomJxCheckInterOrg  checkInterOrg=(SomJxCheckInterOrg)checkInterOrgRecords[i].toBean(SomJxCheckInterOrg.class);
				checkInterOrg.setId(IdHelp.getUUID32());
				orgDao.insert(checkInterOrg);				
			}
		}
	}
	
}
