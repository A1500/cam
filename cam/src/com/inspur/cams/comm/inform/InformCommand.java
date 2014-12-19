package com.inspur.cams.comm.inform;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Map.Entry;

import org.loushang.bsp.security.context.GetBspInfo;
import org.loushang.bsp.share.organization.OrganFactory;
import org.loushang.bsp.share.organization.provider.IOrganProvider;
import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.upload.MultipartRequestWrapper;
import org.loushang.next.upload.UploadFile;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.next.web.cmd.CommandContext;
import org.loushang.persistent.transaction.PlatformTransactionManager;
import org.loushang.persistent.transaction.TransactionDefinition;
import org.loushang.persistent.transaction.TransactionStatus;
import org.loushang.persistent.transaction.support.DefaultTransactionDefinition;
import org.loushang.sca.transaction.TransactionFactory;

import com.inspur.cams.comm.inform.attachment.InformAttachment;
import com.inspur.cams.comm.inform.attachment.InformAttachmentDao;
import com.inspur.cams.comm.inform.privilege.InformPrivilege;
import com.inspur.cams.comm.inform.privilege.InformPrivilegeDao;
import com.inspur.cams.comm.inform.response.InformResponse;
import com.inspur.cams.comm.inform.response.InformResponseDao;
import com.inspur.cams.comm.informUtil.InformCodec;
import com.inspur.cams.comm.informUtil.InformDateUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.comm.informUtil.InformCodec;


/**
 * @title:InformCommand
 * @description:执行对通知的发布、撤销、删除等操作
 * @author:tianbaoyun
 * @since:2009-10-27
 * @version:1.0
 */
public class InformCommand extends BaseAjaxCommand {
	private InformDao dao = (InformDao) DaoFactory.getDao("com.inspur.cams.comm.inform.InformDao");
	private InformAttachmentDao attachmentDao = (InformAttachmentDao) DaoFactory
			.getDao("com.inspur.cams.comm.inform.attachment.InformAttachmentDao");
	private InformPrivilegeDao privilegeDao = (InformPrivilegeDao) DaoFactory
			.getDao("com.inspur.cams.comm.inform.privilege.InformPrivilegeDao");
	private InformResponseDao responseDao = (InformResponseDao) DaoFactory
			.getDao("com.inspur.cams.comm.inform.response.InformResponseDao");
	private static IOrganProvider IOrgan=(IOrganProvider)OrganFactory.getIOrganProvider();
	/**
	 * @description:发布通知（涉及表IN_INFORM、IN_INFORM_ATTACHMENT、IN_INFORM_PRIVILEGE）
	 * @author huangqiqing
	 * @since 2009-10-28
	 */
	public void insert() {
		// 获取公共 id
		String id = InformDateUtil.getTimeStamp();// 用当前时间戳做主键
		//根据数据源获取事务管理器。
		PlatformTransactionManager txManager = TransactionFactory.getTransactionManager("dataSource");
		//定义事务的一些属性，比如只读、隔离级别等。
		TransactionDefinition definition = new DefaultTransactionDefinition();
		//事务开始
		TransactionStatus status = txManager.getTransaction(definition);
		try{
			//保存通知附件信息
			batchInsertInformAttachment(id);
			//保存通知基本信息
			insertInform(id);
			//保存通知接收人
			batchInsertInformPrivileges(id);
		}catch(Throwable err){
			//事务回退
			txManager.rollback(status);
			throw new RuntimeException(err);
		}
		//事务提交。
		txManager.commit(status);
	}
	/**
	 * @description:保存通知基本信息
	 * @author huangqiqing
	 * @since 2009-11-2
	 */
	public void insertInform(String id) {
		// 获取前台数据
		String userName = getCurrentUserName();
		String organCode = getCurrentUserOrganId();
		Date sendtime = InformDateUtil.getCurrentDate();// 获取当前系统时间，作为发送时间
		String flag = "ok";//ok: 有效 ;delete: 已撤销
		String informtype = String.valueOf(getParameter("informtype"));
		String content = String.valueOf(getParameter("content"));
		String title = String.valueOf(getParameter("title"));
		//int validdaynum = Integer.valueOf(getParameter("validdaynum").toString());
		//封装成InformBean
		Inform informBean = new Inform();
		informBean.setId(id);
		informBean.setInformtype(informtype);
		informBean.setContent(content);
		informBean.setFlag(flag);
		informBean.setSendman(organCode);//发送单位
		informBean.setSendtime(sendtime);
		informBean.setTitle(title);
		//informBean.setValiddaynum(validdaynum);
		informBean.setSendmanid(userName);//发送人

		// 处理事务信息
		PlatformTransactionManager txManager = TransactionFactory
				.getTransactionManager("dataSource");
		TransactionDefinition definition = new DefaultTransactionDefinition();
		// 事务开始
		TransactionStatus status = (TransactionStatus) txManager
				.getTransaction(definition);


		try {
			dao.insert(informBean);
		} catch (Throwable err) {
			// TODO Auto-generated catch block
			// 事务回滚
			txManager.rollback(status);
			throw new RuntimeException(err);
		}
		// 事务提交
		txManager.commit(status);

	}
	/**
	 * @description:保存通知附件信息
	 * @author huangqiqing
	 * @since 2009-11-2
	 */
	public void batchInsertInformAttachment(String id) {
		MultipartRequestWrapper wrapRequest = (MultipartRequestWrapper) getRequest();// 获取包装后的request
		Map<String, UploadFile> map = wrapRequest.getUploadFiles();// 获取所有上传的文件
		Set<Entry<String,UploadFile>> set = map.entrySet();
		Iterator<Entry<String,UploadFile>> iterator = set.iterator();
		UploadFile uploadfile = null;
		InformAttachment attachment = null;


		// 用于存放所有附件的名字
		List<String> filenames = new ArrayList<String>();
		List<String> prefilenames = new ArrayList<String>();
		String filename = null;

		// 处理事务信息
		PlatformTransactionManager txManager = TransactionFactory
				.getTransactionManager("dataSource");
		TransactionDefinition definition = new DefaultTransactionDefinition();
		// 事务开始
		TransactionStatus status = (TransactionStatus) txManager
				.getTransaction(definition);
		try {
			// 遍历Map，封装成_InformAttachment对象，并放入List中。
			while (iterator.hasNext()) {
				List<InformAttachment> list = new ArrayList<InformAttachment>();;
				uploadfile = iterator.next().getValue();
	            if(uploadfile.getFileSize()>5*1024*1024){
	            	throw new RuntimeException(uploadfile.getFileName()+"  文件过大！");
	            }
				// 如果为空，则不在进行对象封装，继续遍历下一条记录。
				if (uploadfile == null) {
					continue;
				}
				// 如果文件名相同，则只保存第一条，其余的放弃。
				filename = uploadfile.getFileName();
				if (filenames.contains(filename)) {
					continue;
				}
				filenames.add(filename);
				prefilenames.add(filename);
				attachment = new InformAttachment();
				attachment.setId(id);
				attachment.setFilename(uploadfile.getFileName());
				attachment.setFilecontent(uploadfile);
				String AttId = IdHelp.getUUID32();
				attachment.setAttid(AttId);
				list.add(attachment);
				// 保存通知附件
				attachmentDao.batchInsert(list);
			}
		} catch (Throwable err) {
			// TODO Auto-generated catch block
			// 事务回滚
			txManager.rollback(status);
			throw new RuntimeException(err);
		}
		// 事务提交
		txManager.commit(status);



	}
	/**
	 * @description:保存通知接收人信息
	 * @author huangqiqing
	 * @since 2009-11-2
	 */
	public void batchInsertInformPrivileges(String id) {
		//接收页面传值
		// 处理事务信息
		PlatformTransactionManager txManager = TransactionFactory
				.getTransactionManager("dataSource");
		TransactionDefinition definition = new DefaultTransactionDefinition();
		// 事务开始
		TransactionStatus status = (TransactionStatus) txManager
				.getTransaction(definition);
		try {
			InformPrivilege informPrivilege=new InformPrivilege();
			informPrivilege.setFlag("0");
			informPrivilege.setId(id);
			informPrivilege.setReceiveman((String)getParameter("CODE"));
			informPrivilege.setReceivemantype("organize");

			// 保存
			privilegeDao.insert(informPrivilege);
		} catch (Throwable err) {
			// TODO Auto-generated catch block
			// 事务回滚
			txManager.rollback(status);
			throw new RuntimeException(err);
		}
		// 事务提交
		txManager.commit(status);

	}

	/**
	 * @description:撤销通知，将通知由“有效”置为“已撤销”状态
	 * @author huangqiqing
	 * @since 2009-10-28
	 */
	public void cancleInform() {

		PlatformTransactionManager txManager = TransactionFactory
		.getTransactionManager("dataSource");
		TransactionDefinition definition = new DefaultTransactionDefinition();
		// 事务开始
		TransactionStatus status = (TransactionStatus) txManager
				.getTransaction(definition);
		try {
			Record[] records = (Record[]) getParameter("records");
			String ids[] = new String[records.length];
			for (int i = 0; i < records.length; i++) {
				ids[i] = records[i].get("ID").toString();
			}
			dao.cancleInform(ids);
		} catch (Throwable err) {
			// TODO Auto-generated catch block
			// 事务回滚
			txManager.rollback(status);
			throw new RuntimeException(err);
		}
		// 事务提交
		txManager.commit(status);

	}

	/**
	 * @description:删除通知及相关附件、接收人、回执等信息
	 * @author huangqiqing
	 * @since 2009-11-2
	 */
	public void delete() {
		Record[] records = (Record[]) getParameter("records");
		String id[] = new String[records.length];
		for (int i = 0; i < records.length; i++) {
			id[i] = records[i].get("ID").toString();
		}
		PlatformTransactionManager txManager = TransactionFactory
		.getTransactionManager("dataSource");
		TransactionDefinition definition = new DefaultTransactionDefinition();
		// 事务开始
		TransactionStatus status = (TransactionStatus) txManager
				.getTransaction(definition);
		try{
			// 删除通知基本信息
			dao.batchDelete(id);
			// 删除通知附件
			attachmentDao.batchDeleteInformAttachment(id);
			// 删除通知接收人
			privilegeDao.batchDeleteInformPrivileges(id);
			// 删除通知回执信息
			//responseDao.batchDeleteInformResponse(id);

		}catch (Throwable err) {
			// TODO Auto-generated catch block
			// 事务回滚
			txManager.rollback(status);
			throw new RuntimeException(err);
		}
		// 事务提交
		txManager.commit(status);
	}

	/**
	 * @description:在收件箱页面执行删除通知操作，只删除in_inform_privilege表中的相应记录。
	 * @author huangqiqing
	 * @since 2009-11-11
	 */
	public void deleteInformPrivileges() {
		Record[] records = (Record[]) getParameter("records");
		String id[] = new String[records.length];
		for (int i = 0; i < records.length; i++) {
			id[i] = records[i].get("ID").toString();
		}
		// 删除通知接收人
		privilegeDao.batchDeleteByInformIdAndUserId(id, getCurrentUserName(),getCurrentUserOrganId());
	}

	/**
	 * @description:根据通知Id执行查询，返回该通知的明细信息
	 * @author huangqiq
	 * @since 2009-11-2
	 */
	public void getDetailByInformId() {
		String id = String.valueOf(getParameter("id"));
		// 从IN_INFORM表中获取“通知标题”、“发送人”、“通知内容”信息。
		List<Map<String, Object>> list = dao.queryById(id);
		Map<String, Object> map = list.get(0);
		setReturn("title", map.get("TITLE"));
		setReturn("sendman", map.get("SENDMAN"));
		setReturn("content", map.get("CONTENT"));
		setReturn("sendmanid", map.get("SENDMANID"));
		setReturn("informtype", map.get("INFORMTYPE"));

		// 从IN_INFORM_PRIVILEGE表中获取“接收人”
		list = privilegeDao.queryByInformId(id);
		if(list==null){
			setReturn("receiveman","无接收部门！");
		}else{
			StringBuffer receiveman = new StringBuffer();
			StringBuffer receivemanid = new StringBuffer();
			for (int i = 0; i < list.size(); i++) {
				receiveman.append(list.get(i).get("RECEIVEMAN"));
				receiveman.append(",");
				receivemanid.append(list.get(i).get("RECEIVEMANID"));
				receivemanid.append(",");
			}
			if (receiveman.length() > 0) {
				receiveman.deleteCharAt(receiveman.length() - 1);// 去掉最后面的“,”
			}
			if (receivemanid.length() > 0) {
				receivemanid.deleteCharAt(receivemanid.length() - 1);// 去掉最后面的“,”
			}
			setReturn("receiveman", receiveman.toString());
			setReturn("receivemanid", receivemanid.toString());
		}


		// 从IN_INFORM_ATTACHMENT获取“附件名称”信息
		list = attachmentDao.queryByInformId(id);
		StringBuffer filename = new StringBuffer();
		StringBuffer AttId = new StringBuffer();
		for (int i = 0; i < list.size(); i++) {
			filename.append(list.get(i).get("FILENAME"));// 转码前
			filename.append("~");// 分隔符
			filename.append(InformCodec.encode(list.get(i).get("FILENAME").toString()));// 转码后
			filename.append(",");
			//拿到发件箱附件的主键ID
			AttId.append(list.get(i).get("ATTID"));
			AttId.append(",");
		}
		if (filename.length() > 0) {
			filename.deleteCharAt(filename.length() - 1);// 去掉最后面的“,”
			AttId.deleteCharAt(AttId.length() - 1);
		}
		setReturn("filename", filename.toString());
		setReturn ("AttId",AttId.toString());
		String page = String.valueOf(getParameter("page"));

		// 如果不是来自发件箱页面，需要进一步判断是否是第一次阅读，如果是，则在回执表中插入一条回执信息。
		// 并将数据库中该条记录的状态置为”1“（0：未阅，1：已阅）
		if (!"sendpage".equals(page)&&!"bulletinsendpage".equals(page)) {
			boolean isResponsed = true;
			isResponsed = privilegeDao.isResponsed(id, getCurrentUserName(),getCurrentUserOrganId());
			if (!isResponsed) {
				privilegeDao.changeToResponsed(id, getCurrentUserName(),getCurrentUserOrganId());
			}
		}
	}

	/**
	 * @description:新增加一条回执信息
	 * @author huangqiqing
	 * @since 2009-11-11
	 */
	public void newResponse(String informId) {
		String receiveman = getCurrentUserName();
		Date receivetime = InformDateUtil.getCurrentDate();// 获取当前系统时间，作为回执时间
		InformResponse response = new InformResponse();
		response.setId(informId);
		response.setReceiveman(receiveman);
		response.setReceivetime(receivetime);
		responseDao.insert(response);
	}

	/**
	 * @description:根据传入参数封装成PrivilegeBean并返回。
	 * @author huangqiqing
	 * @return InformPrivilege
	 * @since 2009-11-11
	 */
	public InformPrivilege toPrivilegeBean(String id, String receiveMan,
			String receiveManType) {
		InformPrivilege privledge = new InformPrivilege();
		privledge.setId(id);
		privledge.setFlag("0");// 0 未阅；1 已阅
		privledge.setReceivemantype(receiveManType);
		privledge.setReceiveman(receiveMan);
		privledge.setReceiveorder(new BigDecimal(0));// 接收顺序
		return privledge;
	}

	/**
	 * @description:返回当前登陆用户userName
	 * @author huangqiqing
	 * @return String
	 * @since 2009-11-11
	 */
	public String getCurrentUserName() {
		return GetBspInfo.getBspInfo(getRequest()).getUserName();
	}

	/**
	 * @description:返回当前登陆用户所在部门code
	 * @author huangqiqing
	 * @return String
	 * @since 2009-11-11
	 */
	public String getCurrentUserOrganId() {

		String  organId=	GetBspInfo.getBspInfo(CommandContext.getRequest()).getDepartmentOrganId();
		String cantCode =IOrgan.getOrganByOrganId(organId).getOrganCode();

		return cantCode;
	}
}
