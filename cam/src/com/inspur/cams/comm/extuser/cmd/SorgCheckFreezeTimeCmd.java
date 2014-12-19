package com.inspur.cams.comm.extuser.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import com.inspur.cams.comm.extuser.dao.jdbc.SorgCheckFreezeTimeDao;
import com.inspur.cams.comm.extuser.data.ComExtUser;
import com.inspur.cams.comm.extuser.data.SorgCheckFreezeTime;
import com.inspur.cams.comm.extuser.domain.IComExtUserDomain;
import com.inspur.cams.comm.util.IdHelp;

/**
 * 社会组织年检冻结账号时间配置表Cmd
 * @author 闫亮亮
 * @date 2012年7月17日
 */
public class SorgCheckFreezeTimeCmd extends BaseAjaxCommand {

	private SorgCheckFreezeTimeDao dao = (SorgCheckFreezeTimeDao) DaoFactory.getDao("com.inspur.cams.comm.extuser.dao.jdbc.SorgCheckFreezeTimeDao");

	/**
	 * 增加
	 */
	public void insert() {
		Record record = (Record) getParameter("sorgCheckFreezeTime");
		SorgCheckFreezeTime sorgCheckFreezeTime = (SorgCheckFreezeTime) record.toBean(SorgCheckFreezeTime.class);
		sorgCheckFreezeTime.setFreezeId(IdHelp.getUUID32());
		sorgCheckFreezeTime.setFreezeYear(sorgCheckFreezeTime.getFreezeDate().substring(0,4));
		dao.insertSorgCheckFreezeTime(sorgCheckFreezeTime);
	}
	
	/**
	 * 修改
	 */
	public void update() {
		Record record = (Record) getParameter("sorgCheckFreezeTime");
		SorgCheckFreezeTime sorgCheckFreezeTime = (SorgCheckFreezeTime) record.toBean(SorgCheckFreezeTime.class);
		sorgCheckFreezeTime.setFreezeYear(sorgCheckFreezeTime.getFreezeDate().substring(0,4));
		dao.updateSorgCheckFreezeTime(sorgCheckFreezeTime);
	}

	/**
	 * 逻辑删除
	 */
	public void delete() {
		Record record = (Record) getParameter("sorgCheckFreezeTime");
		SorgCheckFreezeTime sorgCheckFreezeTime = (SorgCheckFreezeTime) record.toBean(SorgCheckFreezeTime.class);
		dao.deteleSorgCheckFreezeTime(sorgCheckFreezeTime);
	}
	
}
