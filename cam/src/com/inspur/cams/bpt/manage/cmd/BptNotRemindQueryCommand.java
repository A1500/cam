package com.inspur.cams.bpt.manage.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.bpt.base.dao.jdbc.BptNotRemindDao;
import com.inspur.cams.bpt.base.data.BptNotRemind;
/**
 * @title:BptNotRemindQueryCommand
 * @description:
 * @author:
 * @since:2014-05-09
 * @version:1.0
*/
public class BptNotRemindQueryCommand extends BaseQueryCommand{

	private BptNotRemindDao dao = (BptNotRemindDao) DaoFactory
			.getDao("com.inspur.cams.bpt.base.dao.jdbc.BptNotRemindDao");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<BptNotRemind> dao = (EntityDao<BptNotRemind>) DaoFactory
				.getDao("com.inspur.cams.bpt.base.dao.jdbc.BptNotRemindDao");
		return dao.query(pset);
	}
	/**
	 * 查询提醒待办任务
	 * 
	 * @param pset
	 * @return
	 */
	@Trans
	public DataSet  queryDaiBanRemind (){
		ParameterSet pset = getParameterSet();
		dao.deleteInvalidRW();
		return dao.queryDaiBanRemind(pset);
	}
	/**
	 * 查询提醒需认证人员
	 * 
	 * @param pset
	 * @return
	 */
	@Trans
	public DataSet  queryDoubPeopleRemind (){
		ParameterSet pset = getParameterSet();
		dao.deleteInvalidDP();
		return dao.queryDoubPeopleRemind(pset);
	}
}
