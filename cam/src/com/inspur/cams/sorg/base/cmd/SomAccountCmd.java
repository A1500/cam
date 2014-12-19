package com.inspur.cams.sorg.base.cmd;

import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.base.data.SomAccount;
import com.inspur.cams.sorg.base.domain.ISomAccountDomain;

/**
 * 账户备案保存和修改
 * @author shgtch
 * @date 2011-10-13
 */
public class SomAccountCmd extends BaseAjaxCommand {

	private ISomAccountDomain somAccountDomain = ScaComponentFactory
			.getService(ISomAccountDomain.class, "somAccountDomain/somAccountDomain");

	// 插入
	public void insert() {
		Record record = (Record) getParameter("somAccountRecord");
		SomAccount somAccount = (SomAccount) record.toBean(SomAccount.class);
		somAccountDomain.insert(somAccount);
	}

	// 更新
	public void update() {
		Record record = (Record) getParameter("somAccountRecord");
		SomAccount somAccount = (SomAccount) record.toBean(SomAccount.class);
		somAccountDomain.update(somAccount);
	}
	
	/**
	 *  根据账户查询社会组织ID
	 * @return
	 */
	public String forQuery(){
		//System.out.println("in SomFundAccountCmd");
		ParameterSet pset = getParameterSet();
		String idString2=somAccountDomain.queryForQuery(pset);
		setReturn("idString2", idString2);
		return "";	
	}
	
	public void del() {
		String taskCode = (String) getParameter("taskCode");
		somAccountDomain.del(taskCode);
	}

}
