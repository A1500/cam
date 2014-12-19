package com.inspur.cams.comm.extuser.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import com.inspur.cams.comm.extuser.data.SorgCheckFreezeTime;

/**
 * 社会组织年检冻结账号时间配置表QueryCmd
 * @author 闫亮亮
 * @date 2012年7月17日
 */
public class SorgCheckFreezeTimeQueryCmd extends BaseQueryCommand {

	@SuppressWarnings("unchecked")
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SorgCheckFreezeTime> dao = (EntityDao<SorgCheckFreezeTime>) DaoFactory.getDao("com.inspur.cams.comm.extuser.dao.jdbc.SorgCheckFreezeTimeDao");
		return dao.query(pset);
	}
}
