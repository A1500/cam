package com.inspur.cams.comm.bbs.cmd;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Map.Entry;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.upload.MultipartRequestWrapper;
import org.loushang.next.upload.UploadFile;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.persistent.transaction.PlatformTransactionManager;
import org.loushang.persistent.transaction.TransactionDefinition;
import org.loushang.persistent.transaction.TransactionStatus;
import org.loushang.persistent.transaction.support.DefaultTransactionDefinition;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.TransactionFactory;

import com.inspur.cams.comm.bbs.dao.IPubPostAttachmentDao;
import com.inspur.cams.comm.bbs.dao.jdbc.PubPostAttachmentDao;
import com.inspur.cams.comm.bbs.data.PubPost;
import com.inspur.cams.comm.bbs.data.PubPostAttachment;
import com.inspur.cams.comm.bbs.domain.IPubPostDomain;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.comm.util.BspUtil;

/**
 * 帖子表cmd
 * @author 
 * @date Thu Apr 25 01:05:26 GMT 2013
 */
public class PubPostCmd extends BaseAjaxCommand {

	private IPubPostDomain pubPostDomain = ScaComponentFactory
			.getService(IPubPostDomain.class, "pubPostDomain/pubPostDomain");
	private IPubPostAttachmentDao attachmentDao = (PubPostAttachmentDao) DaoFactory
	.getDao("com.inspur.cams.comm.bbs.dao.jdbc.PubPostAttachmentDao");
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		PubPost pubPost = (PubPost) record.toBean(PubPost.class);
		pubPostDomain.insert(pubPost);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		PubPost pubPost = (PubPost) record.toBean(PubPost.class);
		pubPostDomain.update(pubPost);
	}
	
	// 删除
	public void delete() {
		String postId = (String) getParameter("postId");
		pubPostDomain.delete(postId);
	}
	
	//保存
	public void save() {
		//根据数据源获取事务管理器。
		PlatformTransactionManager txManager = TransactionFactory.getTransactionManager("dataSource");
		//定义事务的一些属性，比如只读、隔离级别等。
		TransactionDefinition definition = new DefaultTransactionDefinition();
		//事务开始
		TransactionStatus status = txManager.getTransaction(definition);
		try{
			
			Record record = (Record) getParameter("record");
			PubPost pubPost = (PubPost) record.toBean(PubPost.class);
			String id=IdHelp.getUUID32();
			pubPostDomain.save(pubPost,id);
			//保存通知附件信息
			batchInsertAttachment(id);
		}catch(Throwable err){
			//事务回退
			txManager.rollback(status);
			throw new RuntimeException(err);
		}
		//事务提交。
		txManager.commit(status);
		
	}
	//删除帖子
	public void deletePost() {
		Record record = (Record) getParameter("record");
		PubPost pubPost = (PubPost) record.toBean(PubPost.class);
		pubPostDomain.deletePost(pubPost);
	}
	/**
	 * @description:保存通知附件信息
	 * @author zhangdongdong
	 * @since 2013-04-27
	 */
	public void batchInsertAttachment(String id) {
		MultipartRequestWrapper wrapRequest = (MultipartRequestWrapper) getRequest();// 获取包装后的request
		Map<String, UploadFile> map = wrapRequest.getUploadFiles();// 获取所有上传的文件
		Set<Entry<String,UploadFile>> set = map.entrySet();
		Iterator<Entry<String,UploadFile>> iterator = set.iterator();
		UploadFile uploadfile = null;
		PubPostAttachment attachment = null;


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
			// 遍历Map，封装成_Attachment对象，并放入List中。
			while (iterator.hasNext()) {
				List<PubPostAttachment> list = new ArrayList<PubPostAttachment>();;
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
				attachment=new PubPostAttachment();
				attachment.setAttachId(IdHelp.getUUID32());
				attachment.setPostId(id);
				attachment.setAttachName(uploadfile.getFileName());
				attachment.setAttachContent(uploadfile);
				attachment.setAttachPeopleCode(BspUtil.getCorpOrgan().getOrganCode());
				attachment.setAttachPeopleName(BspUtil.getCorpOrgan().getOrganName());
				attachment.setAttachTime(DateUtil.getTime());
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
}